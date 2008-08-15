<?php
// $Id: /cvsroot/tikiwiki/tiki/tiki-index.php,v 1.198.2.22 2008-03-12 15:10:01 ricks99 Exp $

// Copyright (c) 2002-2007, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

// Initialization
$section = 'wiki page';
require_once('tiki-setup.php');
include_once('lib/structures/structlib.php');
include_once('lib/wiki/wikilib.php');
include_once('lib/stats/statslib.php');
include_once('lib/ajax/ajaxlib.php');
require_once ("lib/wiki/wiki-ajax.php");
require_once ("lib/wiki/renderlib.php");

if ($prefs['feature_categories'] == 'y') {
	global $categlib;
	if (!is_object($categlib)) {
		include_once('lib/categories/categlib.php');
	}
}

if($prefs['feature_wiki'] != 'y') {
    $smarty->assign('msg', tra('This feature is disabled').': feature_wiki');
    $smarty->display('error.tpl');
    die;  
}

if(!isset($_SESSION['thedate'])) {
    $thedate = $tikilib->now;
} else {
    $thedate = $_SESSION['thedate'];
}

if (isset($_REQUEST['page_id'])) {
    $_REQUEST['page'] = $tikilib->get_page_name_from_id($_REQUEST['page_id']);
    //TODO: introduce a get_info_from_id to save a sql request
}

$use_best_language = false;

if ((!isset($_REQUEST['page']) || $_REQUEST['page'] == '') and !isset($_REQUEST['page_ref_id'])) {
	$_REQUEST['page'] = $userHomePage = $userlib->get_user_default_homepage2($user);
	
	// Create the HomePage if it doesn't exist
	if ( ! empty($userHomePage) ) {
		if ( ! $tikilib->page_exists($userHomePage)) {
			$tikilib->create_page($userHomePage,0,'!Congratulations
This is the default ))HomePage(( for your Tiki. If you are seeing this page, your installation was successful.

You can change this page after logging in. Please review the [http://doc.tikiwiki.org/wiki+syntax|wiki syntax] for editing details.


!!{img src=pics/icons/star.png alt="Star"} Get started.
To begin configuring your site:
#Log in as the __admin__ with password __admin__.
#Change the admin password.
#Enable specific Tiki features.
#Configure the features.


!!{img src=pics/icons/help.png alt="Help"} Need help?
For more information:
*[http://info.tikiwiki.org/Learn+More|Learn more about TikiWiki].
*[http://info.tikiwiki.org/Help+Others|Get help], including the [http://doc.tikiwiki.org|official documentation] and [http://www.tikiwiki.org/forums|support forums].
*[http://info.tikiwiki.org/Join+the+community|Join the TikiWiki community].
',$tikilib->now,'Tiki initialization', 'admin', '0.0.0.0', '', 'en', false, null, 'n', '');
			header('Location: tiki-index.php?page='.$userHomePage);
		}
	} else {
		$smarty->assign('msg', tra('No name indicated for wiki page'));
		$smarty->display('error.tpl');
		die;
	}
	if ($prefs['feature_best_language'] == 'y') {
		$use_best_language = true;
	}
}

$structure = 'n';
$smarty->assign('structure',$structure);
// Feature checks made in the function for structure language
$structlib->use_user_language_preferences();

if (isset($_REQUEST['page_ref_id'])) {
    // If a structure page has been requested
    $page_ref_id = $_REQUEST['page_ref_id'];
} else {
    // else check if page is the head of a structure 
    $page_ref_id = $structlib->get_struct_ref_if_head($_REQUEST['page']);
}

//If a structure page isnt going to be displayed
if (!isset($page_ref_id)) {
    //Check to see if its a member of any structures
    if (isset($_REQUEST['structure']) && !empty($_REQUEST['structure'])) {
      $struct=$_REQUEST['structure'];
    } else {
      $struct='';
    }
    //Get the structures this page is a member of
    $structs = $structlib->get_page_structures($_REQUEST["page"],$struct);
	$structs_with_perm = array(); 
	foreach ($structs as $t_structs) {
		if ($tikilib->user_has_perm_on_object($user,$t_structs['pageName'],'wiki page','tiki_p_view')) {
			$structs_with_perm[] = $t_structs;
		}
	}
    //If page is only member of one structure, display if requested
    $single_struct = count($structs_with_perm) == 1; 
    if ((!empty($struct) || $prefs['feature_wiki_open_as_structure'] == 'y') && $single_struct) {
      $page_ref_id=$structs_with_perm[0]['req_page_ref_id'];
      $_REQUEST['page_ref_id']=$page_ref_id;
    }

}

if(isset($page_ref_id)) {
    $page_info = $structlib->s_get_page_info($page_ref_id);
    $info = null;
    // others still need a good set page name or they will get confused.
    // comments of home page were all visible on every structure page
    $page = $page_info['pageName'];
    $_REQUEST['page']=$page;
} else {
    $page_ref_id = '';
	$smarty->assign('showstructs', $structs_with_perm);
	$smarty->assign('page_ref_id', $page_ref_id);
}

$page = $_REQUEST['page'];

if (!$tikilib->page_exists($page) && function_exists('utf8_encode') && $tikilib->page_exists(utf8_encode($page))) {
    $page = $_REQUEST["page"] = utf8_encode($page);
}

$use_best_language = $use_best_language || isset($_REQUEST['bl']) || isset($_REQUEST['best_lang']);

$info = null;
if ($prefs['feature_multilingual'] == 'y' && $use_best_language) { // chose the best language page
	global $multilinguallib;
	include_once('lib/multilingual/multilinguallib.php');
	$info = $tikilib->get_page_info($page);
	$bestLangPageId = $multilinguallib->selectLangObj('wiki page', $info['page_id']);
	if ($info['page_id'] != $bestLangPageId) {
		$page = $tikilib->get_page_name_from_id($bestLangPageId);
//TODO: introduce a get_info_from_id to save a sql request
		$info = null;
	} elseif ($info['lang'] != $prefs['language'] && $prefs['feature_homePage_if_bl_missing'] == 'y') {
		if (!isset($userPageName))
			$userPageName = $userlib->get_user_default_homepage2($user);
		$page = $userPageName;
		$info = $tikilib->get_page_info($page);
		$bestLangPageId = $multilinguallib->selectLangObj('wiki page', $info['page_id']);
		if ($info['page_id'] != $bestLangPageId) {
			$page = $tikilib->get_page_name_from_id($bestLangPageId);
			$info = null;
		}
	}
}



// Get page data, if available
if (!$info)
	$info = $tikilib->get_page_info($page);


// If the page doesn't exist then display an error
if(empty($info) && !($user && $prefs['feature_wiki_userpage'] == 'y' && strcasecmp($prefs['feature_wiki_userpage_prefix'].$user, $page) == 0)) {
  if ($user && $prefs['feature_wiki_userpage'] == 'y' && strcasecmp($prefs['feature_wiki_userpage_prefix'], $page) == 0) {
    header('Location: tiki-index.php?page='.$prefs['feature_wiki_userpage_prefix'].$user);
    die;
  }
  if ($prefs['feature_wiki_userpage'] == 'y' && strcasecmp($prefs['feature_wiki_userpage_prefix'], substr($page, 0, strlen($prefs['feature_wiki_userpage_prefix']))) == 0)
	$isUserPage = true;
  else
	$isUserPage = false;
  $likepages = $wikilib->get_like_pages($page);
  /* if we have exactly one match, redirect to it */
  if(count($likepages) == 1  && !$isUserPage) {
    header ("Status: 302 Found"); /* PHP3 */
    header ("HTTP/1.0 302 Found"); /* PHP4 */
    header("Location: tiki-index.php?page=$likepages[0]");
    die;
  }
  $smarty->assign_by_ref('likepages', $likepages);
  $smarty->assign('msg',tra('Page cannot be found'));
  header ('Status: 404 Not Found'); /* PHP3 */
  header ('HTTP/1.0 404 Not Found'); /* PHP4 */
  $smarty->assign('headtitle',tra('Page cannot be found'));
  $smarty->assign('errortitle',tra('Page cannot be found').' (404)');
  $smarty->assign('errortype', '404');
  $smarty->assign('create', $isUserPage? 'n': 'y');
  $smarty->display("error.tpl");
  die;
}


if (empty($info) && $user && $prefs['feature_wiki_userpage'] == 'y' && (strcasecmp($prefs['feature_wiki_userpage_prefix'].$user, $page) == 0 || strcasecmp($prefs['feature_wiki_userpage_prefix'], $page) == 0 )) {
	header('Location: tiki-editpage.php?page='.$prefs['feature_wiki_userpage_prefix'].$user);
    	die;
}
if ($prefs['feature_multilingual'] == 'y' && $prefs['feature_sync_language'] == 'y' && !empty($info['lang'])) {
	$_SESSION['s_prefs']['language'] = $info['lang'];
	$prefs['language'] = $info['lang'];
}

/*Wiki SECURITY warning to optimizers : Although get_page_info is currently
called even if permission is denied, we must still get page's real name
(case-sensitive) before tiki-pagesetup.php is included. Bug #990242 for
details */
// Update the pagename with the canonical name.  This makes it
// possible to link to a page using any case, but the page is still
// displayed with the original capitalization.  So if there's a page
// called 'About Me', then one can conveniently make a link to it in
// the text as '... learn more ((about me)).'.  When the link is
// followed, then it still says 'About Me' in the title.
$page = $info['pageName'];

$pageRenderer = new WikiRenderer( $info, $user );
$pageRenderer->applyPermissions();

if( $page_ref_id )
	$pageRenderer->setStructureInfo( $page_info );

// Get the authors style for this page
$wiki_authors_style = ( $prefs['wiki_authors_style_by_page'] == 'y' && $info['wiki_authors_style'] != '' ) ? $info['wiki_authors_style'] : $prefs['wiki_authors_style'];
$smarty->assign('wiki_authors_style', $wiki_authors_style);

// Now check permissions to access this page
if($tiki_p_view != 'y') {
	$smarty->assign('errortype', 401);
	$smarty->assign('msg',tra('Permission denied you cannot view this page'));
	$smarty->display('error.tpl');
	die;  
}

// Convert page to structure
if (isset($_REQUEST['convertstructure']) && isset($structs) && count($structs) == 0) {
	$page_ref_id = $structlib->s_create_page(0, null, $page);
	header('Location: tiki-index.php?page_ref_id='.$page_ref_id );
}

if(isset($_REQUEST['copyrightpage'])) {
  $smarty->assign_by_ref('copyrightpage',$_REQUEST['copyrightpage']); 
}

// BreadCrumbNavigation here
// Remember to reverse the array when posting the array

if(!isset($_SESSION['breadCrumb'])) {
    $_SESSION['breadCrumb']=Array();
}
if(!in_array($page,$_SESSION['breadCrumb'])) {
    if(count($_SESSION['breadCrumb'])>$prefs['userbreadCrumb']) {
	array_shift($_SESSION['breadCrumb']);
    } 
    array_push($_SESSION['breadCrumb'],$page);
} else {
    // If the page is in the array move to the last position
    $pos = array_search($page, $_SESSION['breadCrumb']);
    unset($_SESSION['breadCrumb'][$pos]);
    array_push($_SESSION['breadCrumb'],$page);
}
//print_r($_SESSION["breadCrumb"]);


// Now increment page hits since we are visiting this page
if($prefs['count_admin_pvs'] == 'y' || $user!='admin') {
    $tikilib->add_hit($page);
}

// Check if we have to perform an action for this page
// for example lock/unlock
if( 
	($tiki_p_admin_wiki == 'y') 
	|| 
	($user and ($tiki_p_lock == 'y') and ($prefs['feature_wiki_usrlock'] == 'y'))
  ) {
    if(isset($_REQUEST['action'])) {
	check_ticket('index');
	if($_REQUEST['action']=='lock') {
	    $wikilib->lock_page($page);
	    $info['flag'] = 'L';
	    $smarty->assign('lock',true);  
	}  
    }
}

if( 
	($tiki_p_admin_wiki == 'y') 
	|| 
	($user and ($user == $info['user']) and ($tiki_p_lock == 'y') and ($prefs['feature_wiki_usrlock'] == 'y'))
  ) {
    if(isset($_REQUEST['action'])) {
	check_ticket('index');
	if ($_REQUEST['action']=='unlock') {
	    $wikilib->unlock_page($page);
	    $smarty->assign('lock',false);  
	    $info['flag'] = 'U';
	}  
    }
}


// Save to notepad if user wants to
if($user 
	&& $tiki_p_notepad == 'y' 
	&& $prefs['feature_notepad'] == 'y' 
	&& isset($_REQUEST['savenotepad'])) {
    check_ticket('index');
    $tikilib->replace_note($user,0,$page,$info['data']);
}

// Process an undo here
if(isset($_REQUEST['undo'])) {
    if( $pageRenderer->canUndo ) {
	$area = 'delundopage';
	if ($prefs['feature_ticketlib2'] != 'y' or (isset($_POST['daconfirm']) and isset($_SESSION["ticket_$area"]))) {
	    key_check($area);

	    // Remove the last version	
	    $wikilib->remove_last_version($page);
	    // If page was deleted then re-create
	    if(!$tikilib->page_exists($page)) {
		$tikilib->create_page($page,0,'',$tikilib->now,'Tiki initialization'); 
	    }
	    // Restore page information
	    $info = $tikilib->get_page_info($page);  	
	} else {
	    key_get($area);
	}
    }	
}

if(isset($_REQUEST['refresh'])) {
    check_ticket('index');
    $tikilib->invalidate_cache($page);	
}

$cat_type = 'wiki page';
$cat_objid = $page;
include_once('tiki-section_options.php');

if ( isset($_REQUEST['saved_msg']) && $info['user'] == $user ) {
	// Generate the 'Page has been saved...' message
	require_once('lib/smarty_tiki/modifier.userlink.php');
	$smarty->assign('saved_msg', sprintf( tra('Page saved (version %d).'), $info['version'] ) );
}

// Comments engine!
if ($prefs['feature_wiki_comments'] == 'y' and $tiki_p_wiki_view_comments == 'y') {
    $comments_per_page = $prefs['wiki_comments_per_page'];
    $thread_sort_mode = $prefs['wiki_comments_default_ordering'];
    $comments_vars=Array('page');
    $comments_prefix_var='wiki page:';
    $comments_object_var='page';
    include_once('comments.php');
}

if($prefs['feature_wiki_attachments'] == 'y') {
    if(isset($_REQUEST['removeattach'])) {
	check_ticket('index');
	$owner = $wikilib->get_attachment_owner($_REQUEST['removeattach']);
	if( ($user && ($owner == $user) ) || ($tiki_p_wiki_admin_attachments == 'y') ) {
		$area = 'removeattach';
	    if ($prefs['feature_ticketlib2'] != 'y' or (isset($_POST['daconfirm']) and isset($_SESSION["ticket_$area"]))) {
			key_check($area);
			$wikilib->remove_wiki_attachment($_REQUEST['removeattach']);
		} else {
			key_get($area);
		}
	}
    $smarty->assign('atts_show', 'y');
    }
    if(isset($_REQUEST['attach']) && ($tiki_p_wiki_admin_attachments == 'y' || $tiki_p_wiki_attach_files == 'y')) {
	check_ticket('index');
	// Process an attachment here
	if(isset($_FILES['userfile1'])&&is_uploaded_file($_FILES['userfile1']['tmp_name'])) {
	    $ret = $tikilib->attach_file($_FILES['userfile1']['name'], $_FILES['userfile1']['tmp_name'], $prefs['w_use_db']== 'y'? 'db': 'dir');	
	    if ($ret['ok']) {
	    	// Set "data" field only if we're using db
	    	if( $prefs['w_use_db'] == 'y' )
		{
		    $wikilib->wiki_attach_file($page, $_FILES['userfile1']['name'], $_FILES['userfile1']['type'], $_FILES['userfile1']['size'], $ret['data'], $_REQUEST['attach_comment'], $user, $ret['fhash']);
		} else {
		    $wikilib->wiki_attach_file($page, $_FILES['userfile1']['name'], $_FILES['userfile1']['type'], $_FILES['userfile1']['size'], '', $_REQUEST['attach_comment'], $user, $ret['fhash']);
		}
	    } else {
				$smarty->assign('msg', $ret['error']);
				$smarty->display('error.tpl');
				die();
		}		
	}
    }

	if( isset( $_REQUEST['sort_mode'] ) )
		$pageRenderer->setSortMode( $_REQUEST['sort_mode'] );
	if( isset( $_REQUEST['atts_show'] ) )
		$pageRenderer->setShowAttachments( $_REQUEST['atts_show'] );
}

// Watches
if ($prefs['feature_user_watches'] == 'y') {
	if($user && isset($_REQUEST['watch_event'])) {
		check_ticket('index');
		if (($_REQUEST['watch_action'] == 'add_desc' || $_REQUEST['watch_action'] == 'del_desc') && $tiki_p_watch_structure != 'y') {
			$smarty->assign('errortype', 401);
			$smarty->assign('msg',tra('Permission denied'));
			$smarty->display('error.tpl');
			die;
		}
		if($_REQUEST['watch_action']=='add') {
			$tikilib->add_user_watch($user,$_REQUEST['watch_event'],$_REQUEST['watch_object'],'wiki page',$page,"tiki-index.php?page=$page");
		} elseif($_REQUEST['watch_action'] == 'add_desc') {
			$tikilib->add_user_watch($user,$_REQUEST['watch_event'],$_REQUEST['watch_object'],'structure',$page,"tiki-index.php?page=$page&amp;structure=$struct");
		} else {
			$tikilib->remove_user_watch($user,$_REQUEST['watch_event'],$_REQUEST['watch_object']);
		}
	}
}


$sameurl_elements=Array('pageName','page');

if(isset($_REQUEST['mode']) && $_REQUEST['mode']=='mobile') {
    include_once('lib/hawhaw/hawtikilib.php');
    HAWTIKI_index($info);
}

ask_ticket('index');

//add a hit
$statslib->stats_hit($page,'wiki');
if ($prefs['feature_actionlog'] == 'y') {
	include_once('lib/logs/logslib.php');
	$logslib->add_action('Viewed', $page);
}

$ajaxlib->registerTemplate("tiki-show_page.tpl");
$ajaxlib->processRequests();

// Detect if we have a PDF export mod installed
$smarty->assign('pdf_export', file_exists('lib/mozilla2ps/mod_urltopdf.php') ? 'y' : 'n');

// Display the Index Template
$pageRenderer->runSetups();
$smarty->assign('mid','tiki-show_page.tpl');
$smarty->display("tiki.tpl");

// xdebug_dump_function_profile(XDEBUG_PROFILER_CPU);
// debug: print all objects

?>

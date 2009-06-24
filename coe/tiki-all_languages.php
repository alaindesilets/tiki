<?php

global $prefs;

require 'tiki-setup.php';
ini_set('display_errors', 'on');
error_reporting(E_ALL);
include_once('lib/multilingual/multilinguallib.php');
include_once('lib/wiki/wikilib.php');
include_once('lib/wiki/renderlib.php');

if ($prefs['feature_multilingual'] != 'y') {
	$smarty->assign('msg', tra("This feature is disabled").": feature_multilingual");
	$smarty->display("error.tpl");
	die;
}

if ($prefs['feature_multilingual_one_page'] != 'y') {
	$smarty->assign('msg', tra("This feature is disabled").": feature_multilingual_one_page");
	$smarty->display("error.tpl");
	die;
}

if( !isset($_REQUEST['page']) ) {
	header('Location: tiki-index.php');
	die;
}

$pages = array();

$requested = $tikilib->get_page_info( $_REQUEST['page'] );
$page_id = $requested['page_id'];
$pages[] = $requested;
$unordered = array();
$excluded = array();

$prefered_langs = $multilinguallib->preferedLangs();


if (count($prefered_langs) == 1) {
   // If user only has one language, then assume he wants to see all 
   // languages supported by the site (otherwise, why would he have asked
   // for all languages). This has the advantage that users can see multiple
   // languages even if they haven't registered and set their language preferences,
   // or if they haven't logged in. Yet, if they have registered, set language
   // preferences, and logged in, they can limit the displayed languages
   // to only those that they want.  
   $prefered_langs = $prefs['available_languages'];
//   print "-- tiki-all_languages: after replacing it by all site languages, \$prefered_langs=";var_dump($prefered_langs);print "<br>\n";
}

// Sort languages according to user's prefences
foreach( $multilinguallib->getTrads( 'wiki page', $page_id ) as $row )
	if( $row['objId'] != $page_id && in_array($row['lang'], $prefered_langs) )
		$unordered[ $row['lang'] ] = $tikilib->get_page_info_from_id( $row['objId'] );
	elseif( $row['lang'] != $requested['lang'] )
		$excluded[] = $row['lang'];

foreach( $prefered_langs as $lang )
	if( array_key_exists( $lang, $unordered ) )
		$pages[] = $unordered[$lang];

$contents = array();

$show_langs_side_by_side = false;
if (count($pages) == 2) {
   // If only two languages, its best to show 
   // them side by side for easier comparison
   // (as opposed to one on top of the other).
   // But for more than two languages, side by
   // side is not possible, cause not enough real estate
   $show_langs_side_by_side = true;
}


foreach( array_reverse( $pages ) as $id => $info )
{
	$page = $info['pageName'];
	$section = 'wiki page';

	$renderer = new WikiRenderer( $info, $user );
	$renderer->applyPermissions();
	$renderer->runSetups();

    $comments_per_page = $prefs['wiki_comments_per_page'];
    $thread_sort_mode = $prefs['wiki_comments_default_ordering'];
    $comments_vars=Array('page');
	$comments_objectId = 'wiki page:' . $info['pageName'];
    include('comments.php');

	$contents[] = $smarty->fetch('tiki-show_page.tpl');
	if ($show_langs_side_by_side) {
	   // Enclose this language inside a table cell
	   $curr_content_index = count($contents) - 1;
	   $contents[$curr_content_index] = "\n<TD>\n$contents[$curr_content_index]\n</TD>\n";
	}

	if( $id === count($pages) - 1 )
		$renderer->restoreAll();
}

$contents = array_reverse( $contents );

if ($show_langs_side_by_side) {
	// Put the two languages side by side in a table 
	// for easier comparison
	array_unshift($contents, "<TABLE>\n");
	$contents[] = "</TABLE>\n";
}

$smarty->assign( 'excluded', $excluded );
$smarty->assign( 'content', $contents);
$smarty->assign( 'mid', 'tiki-all_languages.tpl' );
$smarty->display( 'tiki.tpl' );

<?php
// (c) Copyright 2002-2011 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

$section = 'admin';

require_once ('tiki-setup.php');
include_once ('lib/admin/adminlib.php');

$tikifeedback = array();
$auto_query_args = array('page');

$access->check_permission('tiki_p_admin');
global $logslib; include_once('lib/logs/logslib.php');

/**
 * Display feedback on prefs changed
 * 
 * @param $name		Name of feature
 * @param $message	Other message
 * @param $st		Type of change (0=disabled, 1=enabled, 2=changed, 3=info)
 * @param $num		unknown
 * @return void
 */
function add_feedback( $name, $message, $st, $num = null )
{
	global $tikifeedback;
	$tikifeedback[] = array(
		'num' => $num,
		'mes' => $message,
		'st' => $st,
		'name' => $name,
	);
}

/**
 * simple_set_toggle 
 * 
 * @param mixed $feature 
 * @access public
 * @return void
 */
function simple_set_toggle($feature)
{
	global $_REQUEST, $tikilib, $smarty, $prefs, $logslib;
	if (isset($_REQUEST[$feature]) && $_REQUEST[$feature] == 'on') {
		if ((!isset($prefs[$feature]) || $prefs[$feature] != 'y')) {
			// not yet set at all or not set to y
			if ($tikilib->set_preference($feature, 'y')) {
				add_feedback( $feature, tr('%0 enabled', $feature), 1, 1 );
				$logslib->add_action('feature', $feature, 'system', 'enabled');
			}
		}
	} else {
		if ((!isset($prefs[$feature]) || $prefs[$feature] != 'n')) {
			// not yet set at all or not set to n
			if ($tikilib->set_preference($feature, 'n')) {
				add_feedback($feature, tr('%0 disabled', $feature), 0, 1);
				$logslib->add_action('feature', $feature, 'system', 'disabled');
			}
		}
	}
	global $cachelib;
	require_once ('lib/cache/cachelib.php');
	$cachelib->invalidate('allperms');
}

/**
 * simple_set_value 
 * 
 * @param mixed $feature 
 * @param string $pref 
 * @param mixed $isMultiple 
 * @access public
 * @return void
 */
function simple_set_value($feature, $pref = '', $isMultiple = false)
{
	global $_REQUEST, $tikilib, $prefs, $logslib;
	$old = $prefs[$feature];
	if (isset($_REQUEST[$feature])) {
		if ($pref != '') {
			if ($tikilib->set_preference($pref, $_REQUEST[$feature])) {
				$prefs[$feature] = $_REQUEST[$feature];
			}
		} else {
			$tikilib->set_preference($feature, $_REQUEST[$feature]);
		}
	} elseif ($isMultiple) {
		// Multiple selection controls do not exist if no item is selected.
		// We still want the value to be updated.
		if ($pref != '') {
			if ($tikilib->set_preference($pref, array())) {
				$prefs[$feature] = $_REQUEST[$feature];
			}
		} else {
			$tikilib->set_preference($feature, array());
		}
	}
	if (isset($_REQUEST[$feature]) && $old != $_REQUEST[$feature]) {
		add_feedback( $feature, ($_REQUEST[$feature]) ? tr('%0 set', $feature) : tr('%0 unset', $feature), 2 );
		$logslib->add_action('feature', $feature, 'system', $old .'=>'.isset($_REQUEST['feature'])?$_REQUEST['feature']:'');
	}
	global $cachelib;
	require_once ('lib/cache/cachelib.php');
	$cachelib->invalidate('allperms');
}

/**
 * simple_set_int 
 * 
 * @param mixed $feature 
 * @access public
 * @return void
 */
function simple_set_int($feature) 
{
	global $_REQUEST, $tikilib, $prefs, $logslib;
	if (isset($_REQUEST[$feature]) && is_numeric($_REQUEST[$feature])) {
		$old = $prefs[$feature];
		if ($old != $_REQUEST[$feature]) {
			$tikilib->set_preference($feature, $_REQUEST[$feature]);
			add_feedback( $feature, tr('%0 set', $feature), 2 );
			$logslib->add_action('feature', $feature, 'system', $old . '=>' . $_REQUEST['feature']);
		}
	}
}

/**
 * byref_set_value 
 * 
 * @param mixed $feature 
 * @param string $pref 
 * @access public
 * @return void
 */
function byref_set_value($feature, $pref = '')
{
	global $_REQUEST, $tikilib, $smarty, $logslib;
	simple_set_value($feature, $pref);
}

$crumbs[] = new Breadcrumb(tra('Administration'), tra('Sections'), 'tiki-admin.php', 'Admin+Home', tra('Help on Configuration Sections', '', true));
// Default values for AdminHome
$admintitle = tra('Administration');
$helpUrl = 'Admin+Home';
$helpDescription = $description = '';
$url = 'tiki-admin.php';
$adminPage = '';

global $prefslib; require_once 'lib/prefslib.php';

if( isset ($_REQUEST['pref_filters']) ) {
	$prefslib->setFilters( $_REQUEST['pref_filters'] );
}

$temp_filters = isset($_REQUEST['filters']) ? explode(' ', $_REQUEST['filters']) : null;
$smarty->assign('pref_filters', $prefslib->getFilters($temp_filters));

if( isset( $_REQUEST['lm_preference'] ) ) {
	
	$changes = $prefslib->applyChanges( (array) $_REQUEST['lm_preference'], $_REQUEST );
	foreach( $changes as $pref => $val ) {
		$value = $val['new'];
		if( $value == 'y' ) {
			add_feedback( $pref, tr('%0 enabled', $pref), 1, 1 );
			$logslib->add_action('feature', $pref, 'system', 'enabled');
		} elseif( $value == 'n' ) {
			add_feedback( $pref, tr('%0 disabled', $pref), 0, 1 );
			$logslib->add_action('feature', $pref, 'system', 'disabled');
		} else {
			add_feedback( $pref, tr('%0 set', $pref), 1, 1 );
			$logslib->add_action('feature', $pref, 'system', (is_array($val['old'])?implode($val['old'], ','):$val['old']).'=>'.(is_array($value)?implode($value, ','):$value));
		}
	}
}

if( isset( $_REQUEST['lm_criteria'] ) ) {
	set_time_limit(0);
	try {
		$smarty->assign( 'lm_criteria', $_REQUEST['lm_criteria'] );
		$results = $prefslib->getMatchingPreferences( $_REQUEST['lm_criteria'], $temp_filters );
		$results = array_slice( $results, 0, 10 );
		$smarty->assign( 'lm_searchresults', $results );
		$smarty->assign( 'lm_error', '' );
	} catch(Zend_Search_Lucene_Exception $e) {
		$smarty->assign( 'lm_criteria', $_REQUEST['lm_criteria'] );
		$smarty->assign( 'lm_error', $e->getMessage() );
		$smarty->assign( 'lm_searchresults', '' );
	}
} else {
	$smarty->assign( 'lm_criteria', '' );
	$smarty->assign( 'lm_searchresults', '' );
	$smarty->assign( 'lm_error', '' );
}

$smarty->assign('indexNeedsRebuilding', $prefslib->indexNeedsRebuilding());

if (isset($_REQUEST['page'])) {
	$adminPage = $_REQUEST['page'];
	if ($adminPage == 'features') {
		$admintitle = tra('Features');
		$description = tra('Enable/disable Tiki features here, but configure them elsewhere'); 
		$helpUrl = 'Features+Admin';
		include_once ('admin/include_features.php');
	} else if ($adminPage == 'general') {
		$admintitle = tra('General');
		$description = tra('General preferences and settings');
		$helpUrl = 'General+Admin';
		include_once ('admin/include_general.php');
	} else if ($adminPage == 'login') {
		$admintitle = tra('Login');
		$description = tra('User registration, login and authentication');
		$helpUrl = 'Login+Config';
		include_once ('admin/include_login.php');
	} else if ($adminPage == 'wiki') {
		$admintitle = tra('Wiki');
		$description = tra('Wiki settings');
		$helpUrl = 'Wiki+Config';
		include_once ('admin/include_wiki.php');
	} else if ($adminPage == 'wikiatt') {
		$admintitle = tra('Wiki Attachments');
		$description = tra('Wiki attachments');
		$helpUrl = 'Wiki+Config';
		include_once ('admin/include_wikiatt.php');
	} else if ($adminPage == 'gal') {
		$admintitle = tra('Image Galleries');
		$description = tra('Image galleries');
		$helpUrl = 'Image+Gallery';
		include_once ('admin/include_gal.php');
	} else if ($adminPage == 'fgal') {
		$admintitle = tra('File Galleries');
		$description = tra('File Galleries');
		$helpUrl = 'File+Gallery';
		include_once ('admin/include_fgal.php');
	} else if ($adminPage == 'articles') {
		$admintitle = tra('Articles');
		$description = tra('Articles settings');
		$helpUrl = 'Articles';
		include_once ('admin/include_articles.php');
	} else if ($adminPage == 'polls') {
		$admintitle = tra('Polls');
		$description = tra('Poll comments settings');
		$helpUrl = 'Polls';
		include_once ('admin/include_polls.php');
	} else if ($adminPage == 'blogs') {
		$admintitle = tra('Blogs');
		$description = tra('Configuration options for all blogs on your site');
		$helpUrl = 'Blog';
		include_once ('admin/include_blogs.php');
	} else if ($adminPage == 'forums') {
		$admintitle = tra('Forums');
		$description = tra('Forums settings');
		$helpUrl = 'Forum';
		include_once ('admin/include_forums.php');
	} else if ($adminPage == 'faqs') {
		$admintitle = tra('FAQs');
		$description = tra('FAQ comments settings');
		$helpUrl = 'FAQ';
		include_once ('admin/include_faqs.php');
	} else if ($adminPage == 'trackers') {
		$admintitle = tra('Trackers');
		$description = tra('Trackers settings');
		$helpUrl = 'Trackers';
		include_once ('admin/include_trackers.php');
	} else if ($adminPage == 'webmail') {
		$admintitle = tra('Webmail');
		$description = tra('Webmail');
		$helpUrl = 'Webmail';
		include_once ('admin/include_webmail.php');
	} else if ($adminPage == 'comments') {
		$admintitle = tra('Comments');
		$description = tra('Comments settings');
		$helpUrl = 'Comments';
		include_once ('admin/include_comments.php');
	} else if ($adminPage == 'rss') {
		$admintitle = tra('Feeds');
		$description = tra('Feeds settings');
		$helpUrl = 'Feeds User';
		include_once ('admin/include_rss.php');
	} else if ($adminPage == 'directory') {
		$admintitle = tra('Directory');
		$description = tra('Directory settings');
		$helpUrl = 'Directory';
		include_once ('admin/include_directory.php');
	} else if ($adminPage == 'userfiles') {
		$admintitle = tra('User Files');
		$description = tra('User files');
		$helpUrl = 'User+Files';
		include_once ('admin/include_userfiles.php');
	} else if ($adminPage == 'maps') {
		$admintitle = tra('Maps');
		$description = tra('Maps configuration');
		$helpUrl = 'Maps';
		include_once ('admin/include_maps.php');
	} else if ($adminPage == 'metatags') {
		$admintitle = tra('Meta Tags');
		$description = tra('Meta Tags settings');
		$helpUrl = 'Meta+Tags';
		include_once ('admin/include_metatags.php');
	} else if ($adminPage == 'performance') {
		$admintitle = tra('Performance');
		$description = tra('Speed & Performance');
		$helpUrl = 'Performance';
		include_once ('admin/include_performance.php');
	} else if ($adminPage == 'security') {
		$admintitle = tra('Security');
		$description = tra('Security');
		$helpUrl = 'Security';
		include_once ('admin/include_security.php');
	} else if ($adminPage == 'search') {
		$admintitle = tra('Search');
		$description = tra('Search settings');
		$helpUrl = 'Search';
		include_once ('admin/include_search.php');
	} else if ($adminPage == 'score') {
		$admintitle = tra('Score');
		$description = tra('Score settings');
		$helpUrl = 'Score';
		include_once ('admin/include_score.php');
	} else if ($adminPage == 'community') {
		$admintitle = tra('Community');
		$description = tra('Community settings');
		$helpUrl = 'Community';
		include_once ('admin/include_community.php');
	} else if ($adminPage == 'messages') {
		$admintitle = tra('Messages');
		$description = tra('User Messages');
		$helpUrl = 'Inter-User+Messages';
		include_once ('admin/include_messages.php');
	} else if ($adminPage == 'calendar') {
		$admintitle = tra('Calendar');
		$description = tra('Calendar settings');
		$helpUrl = 'Calendar';
		include_once ('admin/include_calendar.php');
	} else if ($adminPage == 'intertiki') {
		$admintitle = tra('Intertiki');
		$description = tra('Intertiki settings');
		$helpUrl = 'InterTiki';
		include_once ('admin/include_intertiki.php');
	} else if ($adminPage == 'freetags') {
		$admintitle = tra('Freetags');
		$description = tra('Freetags settings');
		$helpUrl = 'Tags';
		include_once ('admin/include_freetags.php');
	} else if ($adminPage == 'gmap') {
		$admintitle = tra('Google Maps');
		$description = tra('Google Maps');
		$helpUrl = 'gmap';
		include_once ('admin/include_gmap.php');
	} else if ($adminPage == 'i18n') {
		$admintitle = tra('i18n');
		$description = tra('Internationalization');
		$helpUrl = 'i18n';
		include_once ('admin/include_i18n.php');
	} else if ($adminPage == 'wysiwyg') {
		$admintitle = tra('wysiwyg');
		$description = tra('Wysiwyg editor');
		$helpUrl = 'Wysiwyg';
		include_once ('admin/include_wysiwyg.php');
	} else if ($adminPage == 'copyright') {
		$admintitle = tra('Copyright');
		$description = tra('Copyright management');
		$helpUrl = 'Copyright';
		include_once ('admin/include_copyright.php');
	} else if ($adminPage == 'category') {
		$admintitle = tra('Category');
		$description = tra('Category');
		$helpUrl = 'Category';
		include_once ('admin/include_category.php');
	} else if ($adminPage == 'module') {
		$admintitle = tra('Module');
		$description = tra('Module');
		$helpUrl = 'Module';
		include_once ('admin/include_module.php');
	} else if ($adminPage == 'look') {
		$admintitle = tra('Look & Feel');
		$description = tra('Customize look and feel of your Tiki');
		$helpUrl = 'Look+and+Feel';
		include_once ('admin/include_look.php');
	} else if ($adminPage == 'textarea') {
		$admintitle = tra('Text area');
		$description = tra('Text area');
		$helpUrl = 'Text+area';
		include_once ('admin/include_textarea.php');
	} else if ($adminPage == 'ads') {
		$admintitle = tra('Site Ads and Banners');
		$description = tra('Configure Site Ads and Banners');
		$helpUrl = 'Look+and+Feel';
		include_once ('admin/include_ads.php');
	} else if ($adminPage == 'profiles') {
		$admintitle = tra('Profiles');
		$description = tra('Install predefined configuration profiles and add-ons.');
		$helpUrl = 'Profiles';
		include_once ('admin/include_profiles.php');
	} else if ($adminPage == 'plugins') {
		$admintitle = tra('Plugin Alias');
		$description = tra('Create shortcut syntaxes to plugins.');
		$helpUrl = 'Plugin+Alias';
		include_once ('admin/include_plugins.php');
	} else if ($adminPage == 'semantic') {
		$admintitle = tra('Semantic Wiki Links');
		$description = tra('Manage semantic tokens used throughout the wiki.');
		$helpUrl = 'Semantic+Admin';
		include_once ('admin/include_semantic.php');
	} else if ($adminPage == 'webservices') {
		$admintitle = tra('Webservice Registration');
		$description = tra('Discover and register web services to allow direct use in wiki pages.');
		$helpUrl = 'WebServices';
		include_once ('admin/include_webservices.php');
	} else if ($adminPage == 'sefurl') {
		$admintitle = tra('Search engine friendly url');
		$description = tra('Search engine friendly url');
		$helpUrl = 'Rewrite+Rules';
		include_once ('admin/include_sefurl.php');
	} else if ($adminPage == 'video') {
		$admintitle = tra('Video');
		$description = tra('Settings for video streaming integration');
		$helpUrl = 'Kaltura+Config';
		include_once ('admin/include_video.php');
	} else if ($adminPage == 'connect') {
		$admintitle = tra('Connect');
		$description = tra('Connect');
		$helpUrl = 'Connect';
		include_once ('admin/include_connect.php');
	} else if ($adminPage == 'rating') {
		$admintitle = tra('Advanced Rating');
		$description = tra('Advanced Rating');
		$helpUrl = 'Advanced+Rating';
		include_once ('admin/include_rating.php');
	} else if ($adminPage == 'payment') {
		$admintitle = tra('Payment');
		$description = tra('Payment');
		$helpUrl = 'Payment';
		include_once ('admin/include_payment.php');
	} else if ($adminPage == 'socialnetworks') {
		$admintitle = tra('Social Networks');
		$description = tra('Settings for social networks integration');
		$helpUrl = 'Social+Networks';
		include_once ('admin/include_socialnetworks.php');
	} else if ($adminPage == 'share') {
		$admintitle = tra('Share');
		$description = tra('Settings for share preferences');
		$helpUrl = 'share';
		include_once ('admin/include_share.php');
	} else {
		$helpUrl = '';
	}
	$url = 'tiki-admin.php' . '?page=' . $adminPage;
	if (!$helpUrl) {
		$helpUrl = ucfirst($adminPage) . '+Config';
	}
	$helpDescription = tr("Help on %0 Config", $admintitle);
	
} else {
	$smarty->assign('admintitle', 'Admin Home');
	$smarty->assign('description', 'Home Page for Administrators');
	$smarty->assign('headtitle', breadcrumb_buildHeadTitle($crumbs));
	$smarty->assign('description', $crumbs[0]->description);
}
$headerlib->add_cssfile('css/admin.css');
if (isset($admintitle) && isset($description)) {
	$crumbs[] = new Breadcrumb($admintitle, $description, $url, $helpUrl, $helpDescription);
	$smarty->assign_by_ref('admintitle', $admintitle);
	$headtitle = breadcrumb_buildHeadTitle($crumbs);
	$smarty->assign_by_ref('headtitle', $headtitle);
	$smarty->assign_by_ref('helpUrl', $helpUrl);
	$smarty->assign_by_ref('description', $description);
}

// VERSION TRACKING
// If the user elected to force a check.
if (!empty($_GET['forcecheck'])) {
	$smarty->assign('tiki_release', $TWV->getLatestMinorRelease());
	if (!$TWV->isLatestMinorRelease()) {
		$prefs['tiki_needs_upgrade'] = 'y';
	} else {
		$prefs['tiki_needs_upgrade'] = 'n';
		add_feedback( null, tr('Current version is up to date : <b>%0</b>', $TWV->version), 3 );
	}
	$smarty->assign('tiki_needs_upgrade', $prefs['tiki_needs_upgrade']);
	// See if a major release is available.
	if (!$TWV->isLatestMajorVersion()) {
		add_feedback( null, tr('A new %0 major release branch is available.', $TWV->branch.'('.$TWV->latestRelease.')'), 3 );
	}
	$tikilib->set_preference('tiki_needs_upgrade', $prefs['tiki_needs_upgrade']);
	$tikilib->set_preference('tiki_release', $TWV->getLatestMinorRelease());
}

// Versioning feature has been enabled, so if the time is right, do a live
// check, otherwise display the stored data.
if ($prefs['feature_version_checks'] == 'y') {
	// Pull version check database settings
	$tiki_version_last_check = $tikilib->get_preference('tiki_version_last_check', 0);
	$tiki_version_check_frequency = $tikilib->get_preference('tiki_version_check_frequency', 0);
	// Time for a version check!
	if ($tikilib->now > ($prefs['tiki_version_last_check'] + $prefs['tiki_version_check_frequency'])) {
		$tikilib->set_preference('tiki_version_last_check', $tikilib->now);
		$smarty->assign('tiki_version', $TWV->version);
		if (!$TWV->isLatestMinorRelease()) {
			$prefs['tiki_needs_upgrade'] = 'y';
			$tikilib->set_preference('tiki_release', $TWV->getLatestMinorRelease());
			$smarty->assign('tiki_release', $TWV->getLatestMinorRelease());
			if (!$TWV->isLatestMajorVersion()) {
				add_feedback( null, tr('A new %0 major release branch is available.', $TWV->branch.'('.$TWV->latestRelease.')'), 3, 1);
			}
		} else {
			$prefs['tiki_needs_upgrade'] = 'n';
			$tikilib->set_preference('tiki_release', $TWV->version);
			$smarty->assign('tiki_release', $TWV->version);
		}
		$tikilib->set_preference('tiki_needs_upgrade', $prefs['tiki_needs_upgrade']);
		$smarty->assign('tiki_needs_upgrade', $prefs['tiki_needs_upgrade']);
	} else {
		$tiki_needs_upgrade = $tikilib->get_preference('tiki_needs_upgrade', 'n');
		$smarty->assign('tiki_needs_upgrade', $tiki_needs_upgrade);
		$tiki_release = $tikilib->get_preference('tiki_release', $TWV->version);
		$smarty->assign('tiki_release', $tiki_release);
		// Normalize database if necessary.  Usually when an upgrade has
		// actually been done, but for whatever reason the database has
		// not had its version tracking info updated.
		if ($tiki_needs_upgrade == 'y' && version_compare($TWV->version, $tiki_release, '>=')) {
			$tiki_needs_upgrade = 'n';
			$tikilib->set_preference('tiki_needs_upgrade', $tiki_needs_upgrade);
			$smarty->assign('tiki_needs_upgrade', $tiki_needs_upgrade);
		}
	}
}

$icons = array(
	"general" => array(
		'position' => '0px 0px;',
		'title' => tr('General'),
	),
	"features" => array(
		'position' => '-100px 0px;',
		'title' => tr('Features'),
	),
	"login" => array(
		'position' => '-200px 0px;',
		'title' => tr('Log in'),
	),
	"community" => array(
		'position' => '-300px 0px;',
		'title' => tr('Community'),
	),
	"profiles" => array(
		'position' => '-400px 0px;',
		'title' => tr('Profiles'),
	),
	"look" => array(
		'position' => '-500px 0px;',
		'title' => tr('Look & Feel'),
	),
	"i18n" => array(
		'position' => '0px -100px;',
		'title' => tr('i18n'),
	),
	"maps" => array(
		'position' => '-100px -500px;',
		'title' => tr('Maps'),
	),	
	"textarea" => array(
		'position' => '-100px -100px;',
		'title' => tr('Editing and Plugins'),
	),
	"module" => array(
		'position' => '-200px -100px;',
		'title' => tr('Module'),
	),
	"metatags" => array(
		'position' => '-300px -100px;',
		'title' => tr('Meta Tags'),
	),
	"performance" => array(
		'position' => '-400px -100px;',
		'title' => tr('Performance'),
	),
	"security" => array(
		'position' => '-500px -100px;',
		'title' => tr('Security'),
	),
	"comments" => array(
		'position' => '0px -200px;',
		'title' => tr('Comments'),
	),
	"rss" => array(
		'position' => '-100px -200px;',
		'title' => tr('Feeds'),
	),
	"connect" => array(
		'position' => '-200px -200px;',
		'title' => tr('Connect'),
	),
	"rating" => array(
		'position' => '-300px -200px;',
		'title' => tr('Rating'),
	),
	"wiki" => array(
		'position' => '-400px -200px;',
		'title' => tr('Wiki'),
		'disabled' => $prefs['feature_wiki'] != 'y',
	),
	"fgal" => array(
		'position' => '-500px -200px;',
		'title' => tr('File Galleries'),
		'disabled' => $prefs['feature_file_galleries'] != 'y',
	),
	"blogs" => array(
		'position' => '0px -300px;',
		'title' => tr('Blogs'),
		'disabled' => $prefs['feature_blogs'] != 'y',
	),
	"gal" => array(
		'position' => '-100px -300px;',
		'title' => tr('Image Galleries'),
		'disabled' => $prefs['feature_galleries'] != 'y',
	),
	"articles" => array(
		'position' => '-200px -300px;',
		'title' => tr('Articles'),
		'disabled' => $prefs['feature_articles'] != 'y',
	),
	"forums" => array(
		'position' => '-300px -300px;',
		'title' => tr('Forums'),
		'disabled' => $prefs['feature_forums'] != 'y',
	),
	"trackers" => array(
		'position' => '-400px -300px;',
		'title' => tr('Trackers'),
		'disabled' => $prefs['feature_trackers'] != 'y',
	),
	"polls" => array(
		'position' => '-500px -300px;',
		'title' => tr('Polls'),
		'disabled' => $prefs['feature_polls'] != 'y',
	),
	"calendar" => array(
		'position' => '0px -400px;',
		'title' => tr('Calendar'),
		'disabled' => $prefs['feature_calendar'] != 'y',
	),
	"category" => array(
		'position' => '-100px -400px;',
		'title' => tr('Categories'),
		'disabled' => $prefs['feature_categories'] != 'y',
	),
	"score" => array(
		'position' => '-200px -400px;',
		'title' => tr('Score'),
		'disabled' => $prefs['feature_score'] != 'y',
	),
	"freetags" => array(
		'position' => '-300px -400px;',
		'title' => tr('Freetags'),
		'disabled' => $prefs['feature_freetags'] != 'y',
	),
	"search" => array(
		'position' => '-400px -400px;',
		'title' => tr('Search'),
		'disabled' => $prefs['feature_search'] != 'y',
	),
	"faqs" => array(
		'position' => '-500px -400px;',
		'title' => tr('FAQs'),
		'disabled' => $prefs['feature_faqs'] != 'y',
	),
	"directory" => array(
		'position' => '0px -500px;',
		'title' => tr('Directory'),
		'disabled' => $prefs['feature_directory'] != 'y',
	),
	"gmap" => array(
		'position' => '-200px -500px;',
		'title' => tr('Google Maps'),
		'disabled' => $prefs['feature_gmap'] != 'y',
	),
	"copyright" => array(
		'position' => '-300px -500px;',
		'title' => tr('Copyright'),
		'disabled' => $prefs['feature_copyright'] != 'y',
	),
	"messages" => array(
		'position' => '-400px -500px;',
		'title' => tr('Messages'),
		'disabled' => $prefs['feature_messages'] != 'y',
	),
	"userfiles" => array(
		'position' => '-500px -500px;',
		'title' => tr('User files'),
		'disabled' => $prefs['feature_userfiles'] != 'y',
	),
	"webmail" => array(
		'position' => '0px -600px;',
		'title' => tr('Webmail'),
		'disabled' => $prefs['feature_webmail'] != 'y',
	),
	"wysiwyg" => array(
		'position' => '-100px -600px;',
		'title' => tr('Wysiwyg'),
		'disabled' => $prefs['feature_wysiwyg'] != 'y',
	),
	"ads" => array(
		'position' => '-200px -600px;',
		'title' => tr('Site Ads and Banners'),
		'disabled' => $prefs['feature_banners'] != 'y',
	),
	"intertiki" => array(
		'position' => '-300px -600px;',
		'title' => tr('InterTiki'),
		'disabled' => $prefs['feature_intertiki'] != 'y',
	),
	"semantic" => array(
		'position' => '-400px -600px;',
		'title' => tr('Semantic links'),
		'disabled' => $prefs['feature_semantic'] != 'y',
	),
	"webservices" => array(
		'position' => '-500px -600px;',
		'title' => tr('Webservices'),
		'disabled' => $prefs['feature_webservices'] != 'y',
	),
	"sefurl" => array(
		'position' => '0px -700px;',
		'title' => tr('Search engine friendly url'),
		'disabled' => $prefs['feature_sefurl'] != 'y',
	),
	"video" => array(
		'position' => '-100px -700px;',
		'title' => tr('Video streaming integration'),
		'disabled' => $prefs['feature_kaltura'] != 'y' && $prefs['feature_watershed'] != 'y',
	),
	"payment" => array(
		'position' => '-200px -700px;',
		'title' => tr('Payment'),
		'disabled' => $prefs['payment_feature'] != 'y',
	),
	"socialnetworks" => array(
		'position' => '-300px -700px;',
		'title' => tr('Social networks'),
		'disabled' => $prefs['feature_socialnetworks'] != 'y',
	),
	"share" => array(
		'position' => '-400px -700px;',
		'title' => tr('Share'),
		'disabled' => $prefs['feature_share'] != 'y',
	),
);

$smarty->assign('icons', $icons);

$smarty->assign_by_ref('tikifeedback', $tikifeedback);
// disallow robots to index page:
$smarty->assign('metatag_robots', 'NOINDEX, NOFOLLOW');
// Display the template
$smarty->assign('adminpage', $adminPage);
$smarty->assign('mid', 'tiki-admin.tpl');
$smarty->assign('trail', $crumbs);
$smarty->assign('crumb', count($crumbs) - 1);
include_once ('installer/installlib.php');
$installer = new Installer;
$smarty->assign('db_requires_update', $installer->requiresUpdate());
$smarty->display('tiki.tpl');

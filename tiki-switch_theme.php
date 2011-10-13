<?php
// (c) Copyright 2002-2011 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

require_once ('tiki-setup.php');

$access->check_feature('change_theme');

if (isset($_SERVER['HTTP_REFERER'])) {
	$orig_url = $_SERVER['HTTP_REFERER'];
} else {
	$orig_url = $prefs['tikiIndex'];
}
if (isset($_REQUEST['theme'])) {
	$new_theme = $_REQUEST['theme'];
	if (empty($new_theme) || $new_theme != $prefs['style']) { // use default theme option when setting 'site default' or changing main theme
		$_REQUEST['theme-option'] = '';
	}
	if ($user && ($prefs['feature_userPreferences'] == 'y' || $tikilib->get_user_preference($user, 'theme') ) && $group_theme == '') {
		$tikilib->set_user_preference($user, 'theme', $new_theme);
	}
	if (empty($new_theme)) {
		$prefs['style'] = $prefs['site_style'];
		$prefs['style_option'] = $prefs['site_style_option'];
		$_SESSION['s_prefs']['style_option'] = $prefs['site_style_option'];
		unset($_REQUEST['theme-option']);
		if ($user && ($prefs['feature_userPreferences'] == 'y' || $tikilib->get_user_preference($user, 'theme-option') ) && empty($group_style)) {
			$tikilib->set_user_preference($user, 'theme-option', $prefs['site_style_option']);
		}
		if ($prefs['themegenerator_feature'] === 'y') {
			$prefs['themegenerator_theme'] = $prefs['site_themegenerator_theme'];
			$_SESSION['s_prefs']['themegenerator_theme'] = $prefs['site_themegenerator_theme'];
			if ($user && ($prefs['feature_userPreferences'] == 'y' || $tikilib->get_user_preference($user, 'theme-themegen') ) && empty($group_style)) {
				$tikilib->set_user_preference($user, 'theme-themegen', $prefs['site_themegenerator_theme']);
			}
			unset($_REQUEST['theme-themegen']);
		}
	} else {
		$prefs['style'] = $new_theme;
	}
	$_SESSION['s_prefs']['style'] = $prefs['style'];
}
if (isset($_REQUEST['theme-option'])) {
	$new_theme_option = $_REQUEST['theme-option'];
	if ($user && ($prefs['feature_userPreferences'] == 'y' || $tikilib->get_user_preference($user, 'theme-option') ) && empty($group_style)) {
		  $tikilib->set_user_preference($user, 'theme-option', empty($new_theme_option) ? 'None' : $new_theme_option);
		  $prefs['style_option'] = $new_theme_option;
	} else {
		  $prefs['style_option'] = $new_theme_option;
		  $_SESSION['s_prefs']['style_option'] = $new_theme_option;
	}
}

if ($prefs['themegenerator_feature'] === 'y' && isset($_REQUEST['theme-themegen'])) {
	$themegen_theme = $_REQUEST['theme-themegen'];
	$prefs['themegenerator_theme'] = $themegen_theme;
	$_SESSION['s_prefs']['themegenerator_theme'] = $themegen_theme;
}
header("location: $orig_url");
exit;

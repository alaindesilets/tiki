<?php

// $Id$
// Copyright (c) 2002-2007, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for
// details.

//this script may only be included - so its better to die if called directly.
$access->check_script($_SERVER["SCRIPT_NAME"],basename(__FILE__));

if ( isset($_SESSION['try_style']) ) {
	$prefs['style'] = $_SESSION['try_style'];
} elseif ( $prefs['change_theme'] != 'y' ) {
	// Use the site value instead of the user value if the user is not allowed to change the theme
	$prefs['style'] = $prefs['site_style'];
	$prefs['style_option'] = $prefs['site_style_option'];
}

if ($tikilib->get_style_path('', '', $prefs['style']) == '') {
	$prefs['style'] = 'thenews.css';
}

if ($group_style = $userlib->get_user_group_theme()) {
	$prefs['style'] = $group_style;
	$smarty->assign_by_ref('group_style', $group_style);
}
		
include_once("lib/csslib.php");
if ( $prefs['transition_style_ver'] == 'css_specified_only' ) {
	$transition_style = $csslib->transition_css('styles/'.$prefs['style'], '');
} elseif ( $prefs['transition_style_ver'] != '' && $prefs['transition_style_ver'] != 'none') {
	$transition_style = $csslib->transition_css('styles/'.$prefs['style'], $prefs['transition_style_ver']);
} else {
	$transition_style = '';
}

if ( $transition_style != '' ) $headerlib->add_cssfile('styles/transitions/'.$transition_style,50);

$headerlib->add_cssfile($tikilib->get_style_path('', '', $prefs['style']), 51);

$style_base = $tikilib->get_style_base($prefs['style']);

// Allow to have an ie6.css file for the theme's specific hacks for IE 6
$style_ie6_css = $tikilib->get_style_path($prefs['style'], $prefs['style-option'], 'ie6.css');;

// include optional "options" cascading stylesheet if set
if ( !empty($prefs['style_option'])) {
	$style_option_css = $tikilib->get_style_path($prefs['style'], $prefs['style_option'], $prefs['style_option']);
	if (!empty($style_option_css)) {
		$headerlib->add_cssfile($style_option_css, 52);
	}
}


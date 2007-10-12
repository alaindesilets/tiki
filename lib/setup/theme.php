<?php

// $Header: /cvsroot/tikiwiki/tiki/lib/setup/theme.php,v 1.2 2007-10-12 07:55:46 nyloth Exp $
// Copyright (c) 2002-2005, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for
// details.

//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER['SCRIPT_NAME'],'tiki-setup.php')!=FALSE) {
  header('location: index.php');
  exit;
}

if ( isset($_SESSION['try_style']) ) {
	$prefs['style'] = $_SESSION['try_style'];
} elseif ( $prefs['feature_userPreferences'] != 'y' || $prefs['change_theme'] != 'y' ) {
	// Use the site value instead of the user value if the user is not allowed to change the theme
	$prefs['style'] = $prefs['site_style'];
}

if ( ! is_file('styles/'.$prefs['style']) and ! is_file('styles/'.$tikidomain.'/'.$prefs['style']) ) {
	$prefs['style'] = 'tikineat.css';
}
if ( $tikidomain and is_file('styles/'.$tikidomain.'/'.$prefs['style']) ) {
	$prefs['style'] = $tikidomain.'/'.$prefs['style'];
}

include_once("csslib.php");
$transition_style = $csslib->transition_css('styles/'.$prefs['style']);
if ( $transition_style != '' ) $headerlib->add_cssfile('styles/transitions/'.$transition_style,50);
$headerlib->add_cssfile('styles/'.$prefs['style'], 51);
$stlstl = split("-|\.", $prefs['style']);
$style_base = $stlstl[0];

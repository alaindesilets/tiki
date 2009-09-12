<?php
// (c) Copyright 2002-2009 by authors of the Tiki Wiki/CMS/Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$
//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER["SCRIPT_NAME"], basename(__FILE__)) !== false) {
	header("location: index.php");
	exit;
}
// Process Features form(s)
if (isset($_REQUEST["features"])) {
	$features_toggles = array(
		"feature_debug_console",
		"feature_events", //2009-04-29 marclaporte: can we remove this?
		"feature_integrator",
		"feature_workflow",
		"feature_xmlrpc",
		"feature_tikitests",
		"use_minified_scripts",
		'debug_ignore_xdebug',
		'feature_purifier',
	);
	$pref_byref_values = array(
		"user_flip_modules"
	);
	check_ticket('admin-inc-features');
	foreach($features_toggles as $toggle) {
		simple_set_toggle($toggle);
	}
	foreach($pref_byref_values as $britem) {
		byref_set_value($britem);
	}
	$cachelib->empty_full_cache();
}
$smarty->assign('php_major_version', substr(PHP_VERSION, 0, strpos(PHP_VERSION, '.')));
ask_ticket('admin-inc-features');

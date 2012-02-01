<?php
// (c) Copyright 2002-2012 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

include_once('tiki-setup.php');
include_once('lib/reportslib.php');

$access->check_user($user);
$access->check_feature('feature_daily_report_watches');

$reportsUsers = Reports_Factory::build('Reports_Users');

//Enable User Reports
if (isset($_POST['report_preferences']) && $_POST['use_daily_reports'] == "true") {
	$reportsUsers->add($user, $_POST['interval'], $_POST['view'], $_POST['type'], $_POST['always_email']);
	header('Location: tiki-user_watches.php');
	die;
}
//Disable User Reports
if (isset($_POST['report_preferences']) && $_POST['use_daily_reports'] != "true") {
	$reportsUsers->delete($user);
	header('Location: tiki-user_watches.php');
	die;
}

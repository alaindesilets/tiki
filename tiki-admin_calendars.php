<?php

// $Header: /cvsroot/tikiwiki/tiki/tiki-admin_calendars.php,v 1.19 2005-01-22 22:54:52 mose Exp $

// Copyright (c) 2002-2005, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

// Initialization
require_once ('tiki-setup.php');

include_once ('lib/calendar/calendarlib.php');

if ($tiki_p_admin_calendar != 'y' and $tiki_p_admin != 'y') {
	$smarty->assign('msg', tra("You do not have permission to use this feature"));
	$smarty->display("error.tpl");
	die;
}

if (!isset($_REQUEST["calendarId"])) {
	$_REQUEST["calendarId"] = 0;
} else {
	 $smarty->assign('individual', $userlib->object_has_one_permission($_REQUEST["calendarId"], 'calendar'));
}

if (isset($_REQUEST["drop"])) {
	$area = "delcalendar";
	if ($feature_ticketlib2 != 'y' or (isset($_POST['daconfirm']) and isset($_SESSION["ticket_$area"]))) {
		key_check($area);
		$calendarlib->drop_calendar($_REQUEST["drop"]);
		$_REQUEST["calendarId"] = 0;
	} else {
		key_get($area); 
	}
}

if (isset($_REQUEST["save"])) {
	check_ticket('admin-calendars');
	$customflags["customlanguages"] = $_REQUEST["customlanguages"];
	$customflags["customlocations"] = $_REQUEST["customlocations"];
	$customflags["customcategories"] = $_REQUEST["customcategories"];
	$customflags["custompriorities"] = $_REQUEST["custompriorities"];
	$customflags["customevents"] = $_REQUEST["customevents"];
	$customflags["personal"] = $_REQUEST["personal"];
	$_REQUEST["calendarId"] = $calendarlib->set_calendar($_REQUEST["calendarId"],$user,$_REQUEST["name"],$_REQUEST["description"],$customflags);
	if ($_REQUEST["personal"]) {
		$userlib->assign_object_permission("Registered", $_REQUEST["calendarId"], "calendar", "tiki_p_view_calendar");
		$userlib->assign_object_permission("Registered", $_REQUEST["calendarId"], "calendar", "tiki_p_edit_calendar");
		$userlib->assign_object_permission("Registered", $_REQUEST["calendarId"], "calendar", "tiki_p_add_calendar");
	}
}

if ($_REQUEST["calendarId"]) {
	$info = $calendarlib->get_calendar($_REQUEST["calendarId"]);
	setcookie("activeTabs".urlencode(substr($_SERVER["REQUEST_URI"],1)),"tab2");
} else {
	$info = array();
	$info["name"] = '';
	$info["description"] = '';
	$info["customlanguages"] = 'n';
	$info["customlocations"] = 'n';
	$info["customcategories"] = 'n';
	$info["custompriorities"] = 'n';
	$info["customevents"] = 'n';
	$info["user"] = "$user";
	$info["personal"] = 'n';
}

$smarty->assign('name', $info["name"]);
$smarty->assign('description', $info["description"]);
$smarty->assign('user', $info["user"]);
$smarty->assign('customlanguages', $info["customlanguages"]);
$smarty->assign('customlocations', $info["customlocations"]);
$smarty->assign('customcategories', $info["customcategories"]);
$smarty->assign('custompriorities', $info["custompriorities"]);
$smarty->assign('customevents', $info["customevents"]);
$smarty->assign('calendarId', $_REQUEST["calendarId"]);
$smarty->assign('personal', $info["personal"]);

if (!isset($_REQUEST["sort_mode"])) {
	$sort_mode = 'name_desc';
} else {
	$sort_mode = $_REQUEST["sort_mode"];
}

$smarty->assign_by_ref('sort_mode', $sort_mode);

if (isset($_REQUEST["find"])) {
	$find = $_REQUEST["find"];
} else {
	$find = '';
}

$smarty->assign('find', $find);

$calendars = $calendarlib->list_calendars(0, -1, $sort_mode, $find);

foreach (array_keys($calendars["data"]) as $i) {
	$calendars["data"][$i]["individual"] = $userlib->object_has_one_permission($i, 'calendar');
}

if (!isset($_REQUEST["offset"])) {
	$offset = 0;
} else {
	$offset = $_REQUEST["offset"];
}
$smarty->assign_by_ref('offset', $offset);

$cant_pages = ceil($calendars["cant"] / $maxRecords);
$smarty->assign_by_ref('cant_pages', $cant_pages);
$smarty->assign('actual_page', 1 + ($offset / $maxRecords));

if ($calendars["cant"] > ($offset + $maxRecords)) {
	$smarty->assign('next_offset', $offset + $maxRecords);
} else {
	$smarty->assign('next_offset', -1);
}

// If offset is > 0 then prev_offset
if ($offset > 0) {
	$smarty->assign('prev_offset', $offset - $maxRecords);
} else {
	$smarty->assign('prev_offset', -1);
}

$smarty->assign_by_ref('calendars', $calendars["data"]);

// $cat_type = 'calendar';
// $cat_objid = $_REQUEST["calendarId"];
// include_once ("categorize_list.php");

ask_ticket('admin-calendars');

// Display the template
$smarty->assign('uses_tabs', 'y');
$smarty->assign('mid', 'tiki-admin_calendars.tpl');
$smarty->display("tiki.tpl");

?>

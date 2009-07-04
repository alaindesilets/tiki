<?php
// $Id: /cvsroot/tikiwiki/tiki/tiki-admin_calendars.php,v 1.34.2.2 2008-02-12 19:20:11 sylvieg Exp $
// Copyright (c) 2002-2007, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// Initialization
$section = 'calendar';
require_once ('tiki-setup.php');
include_once ('lib/calendar/calendarlib.php');
if ($prefs['feature_groupalert'] == 'y') {
    include_once ('lib/groupalert/groupalertlib.php');
}
if ($tiki_p_admin_calendar != 'y' and $tiki_p_admin != 'y') {
    $smarty->assign('errortype', 401);
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
    if ($prefs['feature_ticketlib2'] != 'y' or (isset($_POST['daconfirm']) and isset($_SESSION["ticket_$area"]))) {
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
    $customflags["customparticipants"] = $_REQUEST["customparticipants"];
    $customflags["customcategories"] = $_REQUEST["customcategories"];
    $customflags["custompriorities"] = $_REQUEST["custompriorities"];
    $customflags["customsubscription"] = isset($_REQUEST["customsubscription"]) ? $_REQUEST["customsubscription"] : 'n';
    $customflags["personal"] = $_REQUEST["personal"];
    $customflags['customstatus'] = isset($_REQUEST['customstatus']) ? $_REQUEST['customstatus'] : 'y';
    $options = $_REQUEST['options'];
    if (array_key_exists('customcolors', $options) && strPos($options['customcolors'], '-') > 0) {
        $customColors = explode('-', $options['customcolors']);
        if (!preg_match('/^[0-9a-fA-F]{3,6}$/', $customColors[0])) $options['customfgcolor'] = '000000';
        else $options['customfgcolor'] = $customColors[0];
        if (!preg_match('/^[0-9a-fA-F]{3,6}$/', $customColors[1])) $options['custombgcolor'] = 'ffffff';
        else $options['custombgcolor'] = $customColors[1];
    }
    if (!preg_match('/^[0-9a-fA-F]{3,6}$/', $options['customfgcolor'])) $options['customfgcolor'] = '';
    if (!preg_match('/^[0-9a-fA-F]{3,6}$/', $options['custombgcolor'])) $options['custombgcolor'] = '';
    $options['startday'] = $_REQUEST['startday_Hour'] * 60 * 60;
    $options['endday'] = $_REQUEST['endday_Hour'] * 60 * 60 - 1;
    $extra = array(
        'calname',
        'description',
        'location',
        'description',
        'language',
        'category',
        'participants',
        'url',
        'status',
        'status_calview'
    );
    foreach($extra as $ex) {
        if (isset($_REQUEST['show'][$ex]) and $_REQUEST['show'][$ex] == 'on') {
            $options["show_$ex"] = 'y';
        } else {
            $options["show_$ex"] = 'n';
        }
    }
    $_REQUEST["calendarId"] = $calendarlib->set_calendar($_REQUEST["calendarId"], $user, $_REQUEST["name"], $_REQUEST["description"], $customflags, $options);
    if ($prefs['feature_groupalert'] == 'y') {
        $groupalertlib->AddGroup('calendar', $_REQUEST["calendarId"], $_REQUEST['groupforAlert'], !empty($_REQUEST['showeachuser']) ? $_REQUEST['showeachuser'] : 'n');
    }
    if ($_REQUEST['personal'] == 'y') {
        $userlib->assign_object_permission("Registered", $_REQUEST["calendarId"], "calendar", "tiki_p_view_calendar");
        $userlib->assign_object_permission("Registered", $_REQUEST["calendarId"], "calendar", "tiki_p_view_events");
        $userlib->assign_object_permission("Registered", $_REQUEST["calendarId"], "calendar", "tiki_p_add_events");
        $userlib->assign_object_permission("Registered", $_REQUEST["calendarId"], "calendar", "tiki_p_change_events");
    }
    if ($prefs['feature_categories'] == 'y') {
        $cat_type = 'calendar';
        $cat_objid = $_REQUEST["calendarId"];
        $cat_desc = $_REQUEST["description"];
        $cat_name = $_REQUEST["name"];
        $cat_href = "tiki-calendar.php?calIds[]=" . $_REQUEST["calendarId"];
        include_once ("categorize.php");
    }
}
if (isset($_REQUEST['clean']) && isset($_REQUEST['days'])) {
    check_ticket('admin-calendars');
    $calendarlib->cleanEvents($_REQUEST['calendarId'], $_REQUEST['days']);
}
if ($prefs['feature_categories'] == 'y') {
    $cat_type = 'calendar';
    $cat_objid = $_REQUEST["calendarId"];
    include_once ("categorize_list.php");
    $cs = $categlib->get_object_categories('calendar', $cat_objid);
    if (!empty($cs)) {
        for ($i = count($categories) - 1;$i >= 0;--$i) {
            if (in_array($categories[$i]['categId'], $cs)) {
                $categories[$i]['incat'] = 'y';
            }
        }
    }
}
if ($_REQUEST["calendarId"]) {
    $info = $calendarlib->get_calendar($_REQUEST["calendarId"]);
    $cookietab = 2;
} else {
    $info = array();
    $info["name"] = '';
    $info["description"] = '';
    $info["customlanguages"] = 'n';
    $info["customlocations"] = 'n';
    $info["customparticipants"] = 'n';
    $info["customcategories"] = 'n';
    $info["custompriorities"] = 'n';
    $info["customsubscription"] = 'n';
    $info['customstatus'] = 'y';
    $info["customurl"] = 'n';
    $info["customfgcolor"] = '';
    $info["custombgcolor"] = '';
    $info["show_calname"] = 'y';
    $info["show_description"] = 'y';
    $info["show_category"] = 'n';
    $info["show_location"] = 'n';
    $info["show_language"] = 'n';
    $info["show_participants"] = 'n';
    $info["show_url"] = 'n';
    $info["user"] = "$user";
    $info["personal"] = 'n';
    $info["startday"] = '25200';
    $info["endday"] = '72000';
    $info["defaulteventstatus"] = 0;
    if (!empty($_REQUEST['show']) && $_REQUEST['show'] == 'mod') {
        $cookietab = '2';
    } else {
        $cookietab = 1;
    }
}
if ($prefs['feature_groupalert'] == 'y') {
    $info["groupforAlertList"] = array();
    $info["groupforAlert"] = $groupalertlib->GetGroup('calendar', $_REQUEST["calendarId"]);
    $all_groups = $userlib->list_all_groups();
    if (is_array($all_groups)) {
        foreach($all_groups as $g) {
            $groupforAlertList[$g] = ($g == $info['groupforAlert']) ? 'selected' : '';
        }
    }
    $showeachuser = $groupalertlib->GetShowEachUser('calendar', $_REQUEST['calendarId'], $info['groupforAlert']);
    $smarty->assign('groupforAlert', $info['groupforAlert']);
    $smarty->assign_by_ref('groupforAlertList', $groupforAlertList);
    $smarty->assign_by_ref('showeachuser', $showeachuser);
}
setcookie('tab', $cookietab);
$smarty->assign_by_ref('cookietab', $cookietab);
$smarty->assign('name', $info["name"]);
$smarty->assign('description', $info["description"]);
$smarty->assign('owner', $info["user"]);
$smarty->assign('customlanguages', $info["customlanguages"]);
$smarty->assign('customlocations', $info["customlocations"]);
$smarty->assign('customparticipants', $info["customparticipants"]);
$smarty->assign('customcategories', $info["customcategories"]);
$smarty->assign('custompriorities', $info["custompriorities"]);
$smarty->assign('customsubscription', $info["customsubscription"]);
$smarty->assign('customurl', $info["customurl"]);
$smarty->assign('customfgcolor', $info["customfgcolor"]);
$smarty->assign('custombgcolor', $info["custombgcolor"]);
$smarty->assign('customColors', $info["customfgcolor"] . "-" . $info["custombgcolor"]);
$smarty->assign('show_calname', $info["show_calname"]);
$smarty->assign('show_description', $info["show_description"]);
$smarty->assign('show_category', $info["show_category"]);
$smarty->assign('show_location', $info["show_location"]);
$smarty->assign('show_language', $info["show_language"]);
$smarty->assign('show_participants', $info["show_participants"]);
$smarty->assign('show_url', $info["show_url"]);
$smarty->assign('calendarId', $_REQUEST["calendarId"]);
$smarty->assign('personal', $info["personal"]);
$smarty->assign('startday', $info["startday"] < 0 ? 0 : round($info['startday'] / (60 * 60)));
$smarty->assign('endday', $info["endday"] < 0 ? 0 : round($info['endday'] / (60 * 60)));
$smarty->assign('hours', array(
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23'
));
$smarty->assign('defaulteventstatus', $info['defaulteventstatus']);
$smarty->assign('eventstatus', array(
    0 => tra('Tentative') ,
    1 => tra('Confirmed') ,
    2 => tra('Cancelled')
));
$smarty->assign_by_ref('info', $info);
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
if (!isset($_REQUEST["offset"])) {
    $offset = 0;
} else {
    $offset = $_REQUEST["offset"];
}
$smarty->assign_by_ref('offset', $offset);
$calendars = $calendarlib->list_calendars($offset, $maxRecords, $sort_mode, $find);
foreach(array_keys($calendars["data"]) as $i) {
    $calendars["data"][$i]["individual"] = $userlib->object_has_one_permission($i, 'calendar');
}
$smarty->assign_by_ref('cant', $calendars['cant']);
$smarty->assign_by_ref('calendars', $calendars["data"]);
// $cat_type = 'calendar';
// $cat_objid = $_REQUEST["calendarId"];
// include_once ("categorize_list.php");
include_once ('tiki-section_options.php');
ask_ticket('admin-calendars');
// disallow robots to index page:
$smarty->assign('metatag_robots', 'NOINDEX, NOFOLLOW');
// Display the template
$smarty->assign('uses_tabs', 'y');
$smarty->assign('mid', 'tiki-admin_calendars.tpl');
$smarty->display("tiki.tpl");

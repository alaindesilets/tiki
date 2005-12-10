<?php

// $Header: /cvsroot/tikiwiki/tiki/tiki-freetag_list_objects.php,v 1.3 2005-12-10 17:02:50 amette Exp $

// Copyright (c) 2002-2005, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

//
// $Header: /cvsroot/tikiwiki/tiki/tiki-freetag_list_objects.php,v 1.3 2005-12-10 17:02:50 amette Exp $
//

// Initialization
require_once ('tiki-setup.php');

include_once ('lib/freetag/freetaglib.php');

if ($feature_freetags != 'y') {
	$smarty->assign('msg', tra("This feature is disabled").": feature_freetags");

	$smarty->display("error.tpl");
	die;
}

if (!isset($_REQUEST['tag'])) {
    header('Location: tiki-freetag_list_objects.php');
    exit;
}

if (!isset($_REQUEST["sort_mode"])) {
	$sort_mode = 'name_asc';
} else {
	$sort_mode = $_REQUEST["sort_mode"];
}

$smarty->assign_by_ref('sort_mode', $sort_mode);

if (!isset($_REQUEST["offset"])) {
	$offset = 0;
} else {
	$offset = $_REQUEST["offset"];
}

$smarty->assign_by_ref('offset', $offset);

if (!isset($_REQUEST["type"])) {
	$type = '';
} else {
	$type = $_REQUEST["type"];
}

$smarty->assign('type', $type);

if (isset($_REQUEST["user_only"]) && $_REQUEST["user_only"] == 'on') {
    $view_user = $user;
    $smarty->assign('user_only', 'on');
} else {
    $view_user = '';
    $smarty->assign('user_only', 'off');
}

$smarty->assign('tag', $_REQUEST['tag']);

$objects = $freetaglib->get_objects_with_tag($_REQUEST['tag'], $type, $view_user, $offset, $maxRecords); //, $sort_mode, $find);

$smarty->assign_by_ref('objects', $objects["data"]);
$smarty->assign_by_ref('cantobjects', $objects["cant"]);

$cant_pages = ceil($objects["cant"] / $maxRecords);
$smarty->assign_by_ref('cant_pages', $cant_pages);
$smarty->assign('actual_page', 1 + ($offset / $maxRecords));

if ($objects["cant"] > ($offset + $maxRecords)) {
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

$section = 'freetags';
include_once ('tiki-section_options.php');
ask_ticket('browse-freetags');

// Display the template
$smarty->assign('mid', 'tiki-freetag_list_objects.tpl');
$smarty->display("tiki.tpl");

?>

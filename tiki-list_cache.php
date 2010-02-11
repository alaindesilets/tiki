<?php
// (c) Copyright 2002-2010 by authors of the Tiki Wiki/CMS/Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

require_once ('tiki-setup.php');
$access->check_permission('tiki_p_admin');
if (isset($_REQUEST["remove"])) {
	$area = 'delcache';
	if ($prefs['feature_ticketlib2'] != 'y' or (isset($_POST['daconfirm']) and isset($_SESSION["ticket_$area"]))) {
		key_check($area);
		$tikilib->remove_cache($_REQUEST["remove"]);
	} else {
		key_get($area);
	}
}
if (isset($_REQUEST["refresh"])) {
	check_ticket('list-cache');
	$tikilib->refresh_cache($_REQUEST["refresh"]);
}
// This script can receive the thresold
// for the information as the number of
// days to get in the log 1,3,4,etc
// it will default to 1 recovering information for today
if (!isset($_REQUEST["sort_mode"])) {
	$sort_mode = 'url_desc';
} else {
	$sort_mode = $_REQUEST["sort_mode"];
}
$smarty->assign_by_ref('sort_mode', $sort_mode);
// If offset is set use it if not then use offset =0
// use the maxRecords php variable to set the limit
// if sortMode is not set then use lastModif_desc
if (!isset($_REQUEST["offset"])) {
	$offset = 0;
} else {
	$offset = $_REQUEST["offset"];
}
$smarty->assign_by_ref('offset', $offset);
if (!isset($_REQUEST["find"])) {
	$find = '';
} else {
	$find = $_REQUEST["find"];
}
$smarty->assign('find', $find);
// Get a list of last changes to the Wiki database
$listpages = $tikilib->list_cache($offset, $maxRecords, $sort_mode, $find);
$smarty->assign_by_ref('cant_pages', $listpages["cant"]);
$smarty->assign_by_ref('listpages', $listpages["data"]);
//print_r($listpages["data"]);
ask_ticket('list-cache');
// Display the template
$smarty->assign('mid', 'tiki-list_cache.tpl');
$smarty->display("tiki.tpl");

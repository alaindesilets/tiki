<?php
// (c) Copyright 2002-2009 by authors of the Tiki Wiki/CMS/Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id: /cvsroot/tikiwiki/tiki/tiki-syslog.php,v 1.8.2.1 2008-02-14 10:25:11 nyloth Exp $
require_once ('tiki-setup.php');
if ($tiki_p_admin != 'y') {
	$smarty->assign('errortype', 401);
	$smarty->assign('msg', tra("You do not have permission to use this feature"));
	$smarty->display("error.tpl");
	die;
}
$auto_query_args = array('offset', 'numrows', 'maxRecords', 'find', 'sort_mode');
if (isset($_REQUEST["clean"])) {
	$area = 'cleanlogs';
	if ($prefs['feature_ticketlib2'] != 'y' or (isset($_POST['daconfirm']) and isset($_SESSION["ticket_$area"]))) {
		key_check($area);
		$date = strtotime("-" . $_REQUEST["months"] . " months");
		$logslib->clean_logs($date);
	} else key_get($area);
}

if (!isset($_REQUEST["sort_mode"])) {
	$sort_mode = 'lastModif_desc';
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
if (isset($_REQUEST["max"])) {
	$maxRecords = $_REQUEST["max"];
}
$smarty->assign_by_ref('cant', $list['cant']);
$smarty->assign_by_ref('maxRecords', $maxRecords);

$list = $logslib->list_logs('', '', $offset, $maxRecords, $sort_mode, $find);
$smarty->assign('list', $list['data']);
$urlquery['sort_mode'] = $sort_mode;
$urlquery['find'] = $find;
$smarty->assign_by_ref('urlquery', $urlquery);
ask_ticket('admin-logs');
$smarty->assign('mid', 'tiki-syslog.tpl');
$smarty->display('tiki.tpl');

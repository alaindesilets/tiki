<?php

// $Header: /cvsroot/tikiwiki/tiki/tiki-pagehistory.php,v 1.21 2004-08-13 15:31:58 sylvieg Exp $

// Copyright (c) 2002-2004, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

// Initialization
require_once ('tiki-setup.php');

include_once ('lib/wiki/histlib.php');

if ($feature_wiki != 'y') {
	$smarty->assign('msg', tra("This feature is disabled").": feature_wiki");

	$smarty->display("error.tpl");
	die;
}

if ($feature_history != 'y') {
	$smarty->assign('msg', tra("This feature is disabled").": feature_history");

	$smarty->display("error.tpl");
	die;
}

// Get the page from the request var or default it to HomePage
if (!isset($_REQUEST["page"])) {
	$smarty->assign('msg', tra("No page indicated"));

	$smarty->display("error.tpl");
	die;
} else {
	$page = $_REQUEST["page"];

	$smarty->assign_by_ref('page', $_REQUEST["page"]);
}

include_once ("tiki-pagesetup.php");

// Now check permissions to access this page
if ($tiki_p_view != 'y' || $tiki_p_wiki_view_author != 'y') {
	$smarty->assign('msg', tra("Permission denied you cannot browse this page history"));

	$smarty->display("error.tpl");
	die;
}

// If the page doesn't exist then display an error
if (!$tikilib->page_exists($page)) {
	$smarty->assign('msg', tra("Page cannot be found"));

	$smarty->display("error.tpl");
	die;
}

if (isset($_REQUEST["delete"]) && isset($_REQUEST["hist"])) {
	check_ticket('page-history');
	foreach (array_keys($_REQUEST["hist"])as $version) {
		$histlib->remove_version($_REQUEST["page"], $version);
	}
}

if (isset($_REQUEST['source'])) {
	$smarty->assign('source', true);
	$smarty->assign('oldver', $_REQUEST['source']);

	$version = $histlib->get_version($page, $_REQUEST["source"]);
	$smarty->assign('sourcev', nl2br($version["data"]));
}
else
	$smarty->assign('source', false);

$smarty->assign('preview', false);

if (isset($_REQUEST["preview"])) {
	$version = $histlib->get_version($page, $_REQUEST["preview"]);

	if ($version) {
		$version["data"] = $tikilib->parse_data($version["data"]);
		$smarty->assign_by_ref('preview', $version);

		$smarty->assign('oldver', $_REQUEST["preview"]);
	}
}

$info = $tikilib->get_page_info($page);
$smarty->assign_by_ref('info', $info);

$history = $histlib->get_page_history($page);
$smarty->assign_by_ref('history', $history);

if (isset($_REQUEST["compare"])) {
	foreach ($history as $old) {
		if ($old["version"] == $_REQUEST["oldver"])
			break;
	}
	$smarty->assign_by_ref('old', $old);
	if ($_REQUEST["newver"] == 0) {
		$new =& $info;
		$smarty->assign_by_ref('new', $info);
	}
	else {
		foreach ($history as $new) {
			if ($new["version"] == $_REQUEST["newver"])
				break;
		}
		$smarty->assign_by_ref('new', $new);
	}
	if (!isset($_REQUEST["diff_style"]))
		$_REQUEST["diff_style"] = 'sidediff';
	$smarty->assign('diff_style', $_REQUEST["diff_style"]);
	if ($_REQUEST["diff_style"] == "sideview") {
		$old["data"] = $tikilib->parse_data($old["data"]);
		$new["data"] = $tikilib->parse_data($new["data"]);
	}
	else {
		require_once('lib/diff/difflib.php');
		$html = diff2($old["data"], $new["data"], $_REQUEST["diff_style"]);
		$smarty->assign_by_ref('diffdata', $html);
	}
}
else
	$smarty->assign('diff_style', '');

if($info["flag"] == 'L')
    $smarty->assign('lock',true);  
else
    $smarty->assign('lock',false);
$smarty->assign('page_user',$info['user']);

ask_ticket('page-history');

// Display the template
$smarty->assign('mid', 'tiki-pagehistory.tpl');
$smarty->assign('show_page_bar', 'y');
$smarty->display("tiki.tpl");

?>

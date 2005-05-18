<?php

// $Header: /cvsroot/tikiwiki/tiki/tiki-print_multi_pages.php,v 1.10 2005-05-18 10:58:58 mose Exp $

// Copyright (c) 2002-2005, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

// Initialization
require_once ('tiki-setup.php');

if ($feature_wiki_multiprint != 'y') {
	$smarty->assign('msg', tra("This feature is disabled").": feature_wiki_multiprint");

	$smarty->display("error.tpl");
	die;
}

if (!isset($_REQUEST["printpages"])) {
	$smarty->assign('msg', tra("No pages indicated"));

	$smarty->display("error.tpl");
	die;
} else {
	$printpages = unserialize(urldecode($_REQUEST["printpages"]));
}

if (isset($_REQUEST["print"])) {
	check_ticket('multiprint');
	// Create XMLRPC object
	$pages = array();

	foreach ($printpages as $page) {

		// If the page doesn't exist then display an error
		if (!$tikilib->page_exists($page)) {
			$smarty->assign('msg', tra("Page cannot be found"));

			$smarty->display("error.tpl");
			die;
		}

		// Now check permissions to access this page
		if ($tiki_p_view != 'y') {
			$smarty->assign('msg', tra("Permission denied you cannot view this page"));

			$smarty->display("error.tpl");
			die;
		}

		$page_info = $tikilib->get_page_info($page);
		$page_info["parsed"] = $tikilib->parse_data($page_info["data"]);
		$pages[] = $page_info;
	}
}

$smarty->assign_by_ref('pages', $pages);

ask_ticket('multiprint');

// Display the template
$smarty->display("tiki-print_multi_pages.tpl");

?>

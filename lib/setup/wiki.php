<?php

// $Id$
// Copyright (c) 2002-2007, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for
// details.

//this script may only be included - so its better to die if called directly.
$access->check_script($_SERVER["SCRIPT_NAME"],basename(__FILE__));

// Wiki pagename regexp

if ( $prefs['wiki_page_regex'] == 'strict' ) $page_regex = '([A-Za-z0-9_])([\.: A-Za-z0-9_\-])*([A-Za-z0-9_])';
elseif ( $prefs['wiki_page_regex'] == 'full' ) $page_regex = '([A-Za-z0-9_]|[\x80-\xFF])([\.: A-Za-z0-9_\-]|[\x80-\xFF])*([A-Za-z0-9_]|[\x80-\xFF])';
else $page_regex = '([^\n|\(\)])((?!(\)\)|\||\n)).)*?';

// Wiki dump

$wiki_dump_exists = 'n';
$dump_path = 'dump';

if ( $tikidomain ) {
	$dump_path .= "/$tikidomain";
}
if ( file_exists($dump_path.'/new.tar') ) {
	$wiki_dump_exists = 'y';
}
$smarty->assign('wiki_dump_exists', $wiki_dump_exists);

// Wiki discussion

if ( $prefs['feature_wiki_discuss'] == 'y' ) {
	$wiki_discussion_string = $smarty->fetchLang($prefs['language'], 'wiki-discussion.tpl');
	$smarty->assign('wiki_discussion_string', $wiki_discussion_string);
}

// find out the page name if url=tiki-index_x.php (can be needed in module)
if (strstr($_SERVER['SCRIPT_NAME'], 'tiki-index.php') || strstr($_SERVER['SCRIPT_NAME'], 'tiki-index_p.php') || strstr($_SERVER['SCRIPT_NAME'], 'tiki-index_raw.php')) {
	$check = false;
	if (!isset($_REQUEST['page']) && !isset($_REQUEST['page_ref_id']) && !isset($_REQUEST['page_id'])) {
		$_REQUEST['page'] = $userlib->get_user_default_homepage2($user);
		$check = true;
	}
	$change_language = isset($_REQUEST['bl']) || isset($_REQUEST['best_lang']) || isset($_REQUEST['switchLang']);

	if (($prefs['feature_multilingual'] == 'y' || ($prefs['feature_wiki_structure'] == 'y' && $prefs['feature_multilingual_structures'] == 'y'))
		&& $change_language
		&& (isset($_REQUEST['page']) || isset($_REQUEST['page_ref_id']) || isset($_REQUEST['page_id']))) { // perhaps we have to go to an another page
		if (!empty($_REQUEST['page_id'])) {
			if (isset($_REQUEST['switchLang'])) {
				$info = get_page_info_from_id($page_id);
			}
		} elseif (!empty($_REQUEST['page'])) {
			$info = $tikilib->get_page_info($_REQUEST['page']);
			$_REQUEST['page_id'] = $info['page_id'];
		} elseif (!empty($_REQUEST['page_ref_id'])) {
			global $structlib; include_once('lib/structures/structlib.php');
			$info = $structlib->s_get_page_info($_REQUEST['page_ref_id']);
			$_REQUEST['page_id'] = $info['page_id'];
		}
		if (!empty($_REQUEST['page_id'])) {
			if (isset($_REQUEST['bl']) || isset($_REQUEST['best_lang'])) {
				global $multilinguallib; include_once('lib/multilingual/multilinguallib.php');
				$_REQUEST['page_id'] = $multilinguallib->selectLangObj('wiki page', $_REQUEST['page_id']);
			} elseif (isset($_REQUEST['switchLang']) && $info['lang'] != $_REQUEST['switchLang']) {
				global $multilinguallib; include_once('lib/multilingual/multilinguallib.php');
				$_REQUEST['page_id'] = $multilinguallib->selectLangObj('wiki page', $_REQUEST['page_id'], $_REQUEST['switchLang']);
			}
			if (!empty($_REQUEST['page_id'])) {
				$check = false;
			}
		}
	}

	if ($check && !$tikilib->page_exists($_REQUEST['page'])) {
		$tikilib->create_page($_REQUEST['page'], 0,'{TR()}_HOMEPAGE_CONTENT_{TR}',$tikilib->now,'Tiki initialization', 'admin', '0.0.0.0', '', 'en', false, null, 'n', '');
	}
}

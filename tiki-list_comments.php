<?php
// (c) Copyright 2002-2009 by authors of the Tiki Wiki/CMS/Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id: /cvsroot/tikiwiki/tiki/tiki-list_comments.php,v 1.2.2.1 2007-11-04 22:08:04 nyloth Exp $
require_once ('tiki-setup.php');
include_once ('lib/commentslib.php');
$auto_query_args = array('types_section', 'types', 'show_types', 'sort_mode', 'offset', 'find', 'findfilter_approved');
$commentslib = new Comments($dbTiki);
$access->check_permission('tiki_p_admin_comments');
$title = tra('Comments');
$sections_keys = array('objectType' => 'commentsFeature', 'itemObjectType' => 'itemCommentsFeature');
// types_section is used to limit the user to only one section (e.g. 'blogs')
if (isset($_REQUEST['types_section']) && isset($sections_enabled[$_REQUEST['types_section']])) {
	$title = $title . ' - ' . tra(ucwords($_REQUEST['types_section']));
	$smarty->assign_by_ref('types_section', $_REQUEST['types_section']);
}
if (isset($_REQUEST['types'])) {
	$requested_types = $_REQUEST['types'];
	$default_list_value = 'n';
} else {
	$requested_types = array();
	$default_list_value = 'y';
}
$smarty->assign_by_ref('title', $title);
$show_types = array();
$selected_types = array();
foreach($sections_enabled as $k => $info) {
	if (isset($_REQUEST['types_section']) && $k != $_REQUEST['types_section']) continue;
	foreach($sections_keys as $stype => $sfeature) {
		if (isset($info[$sfeature]) && $prefs[$info[$sfeature]] == 'y' && isset($info[$stype])) {
			// Blog hack, needed because both objectType and itemObjectType of blogs are currently defined as 'blog post'
			if ($info[$stype] == 'blog post' && $stype == 'objectType') {
				$comment_type = 'blog';
				if (isset($requested_types[$info[$stype]])) {
					$requested_types[] = $comment_type;
				}
			} else $comment_type = $info[$stype];
			$show_types[$comment_type] = ucwords($comment_type);
			if ($default_list_value == 'y' || in_array($comment_type, $requested_types)) {
				$selected_types[] = $comment_type;
			}
		}
	}
}
// No need to show types choices if there is only one choice that is already choosed
if (count($show_types) == 1 && count($selected_types) == 1) $show_types = array();
$headers = array('title' => 'Title', 'objectType' => 'Type', 'object' => 'Object', 'userName' => 'Author', 'user_ip' => 'IP', 'commentDate' => 'Date', 'data' => 'Comment',);
if (count($selected_types) == 1) {
	unset($headers['objectType']);
	$headers['object'] = tra(ucwords($selected_types[0]));
}
$smarty->assign_by_ref('show_types', $show_types);
$smarty->assign_by_ref('selected_types', $selected_types);
$smarty->assign_by_ref('headers', $headers);
// Handle actions
if (isset($_REQUEST['checked'])) {
	check_ticket('list_comments');
	$checked = is_array($_REQUEST['checked']) ? $_REQUEST['checked'] : array($_REQUEST['checked']);
	// Delete comment(s)
	if (isset($_REQUEST['remove'])) {
		$area = 'removecomment';
		if ($prefs['feature_ticketlib2'] != 'y' or (isset($_POST['daconfirm']) and isset($_SESSION["ticket_$area"]))) {
			key_check($area);
			foreach($checked as $id) {
				$commentslib->remove_comment($id);
			}
		} else {
			key_get($area, tra('Delete comments'));
		}
	}
	// Approve/Reject comment(s)
	if ($prefs['feature_comments_moderation'] == 'y' && isset($_REQUEST['approve']) && in_array($_REQUEST['approve'], array('y', 'n', 'r'))) {
		foreach($checked as $id) {
			$commentslib->approve_comment($id, $_REQUEST['approve']);
		}
	}
}
if (isset($_REQUEST["sort_mode"])) {
	$sort_mode = $_REQUEST["sort_mode"];
} else {
	$sort_mode = 'commentDate_desc';
}
$smarty->assign_by_ref('sort_mode', $sort_mode);
if (isset($_REQUEST["offset"])) {
	$offset = $_REQUEST["offset"];
} else {
	$offset = 0;
}
$smarty->assign_by_ref('offset', $offset);
if (isset($_REQUEST["find"])) {
	$find = strip_tags($_REQUEST["find"]);
} else {
	$find = '';
}
$smarty->assign_by_ref('find', $find);
if (!isset($_REQUEST['findfilter_approved'])) $_REQUEST['findfilter_approved'] = '';
if ($prefs['feature_comments_moderation'] == 'y') {
	$filter_values = array('approved' => $_REQUEST['findfilter_approved']);
	$filter_names = array('approved' => tra('Approved Status'));
	$filters = array('approved' => array('n' => tra('Queued'), 'y' => tra('Approved'), 'r' => tra('Rejected')));
	asort($filters['approved']);
} else {
	$filters = $filter_names = $filter_values = array();
}
$comments = $commentslib->get_all_comments($selected_types, $offset, $maxRecords, $sort_mode, $find, 'y', $_REQUEST['findfilter_approved']);
foreach($comments['data'] as $k => $v) {
	if ($v['objectType'] == 'post') $comments['data'][$k]['objectType'] = 'blog post';
}
$smarty->assign_by_ref('comments', $comments['data']);
$smarty->assign_by_ref('filters', $filters);
$smarty->assign_by_ref('filter_names', $filter_names);
$smarty->assign_by_ref('filter_values', $filter_values);
$smarty->assign_by_ref('cant', $comments['cant']);
ask_ticket('list_comments');
$smarty->assign('mid', 'tiki-list_comments.tpl');
$smarty->display('tiki.tpl');

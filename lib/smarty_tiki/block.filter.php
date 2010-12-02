<?php
// (c) Copyright 2002-2010 by authors of the Tiki Wiki/CMS/Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id: block.permission.php 25202 2010-02-14 18:16:23Z changi67 $

//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

function smarty_block_filter($params, $content, &$smarty, $repeat) {
	global $prefs;
	
	if (! isset($params['action'])) {
		$params['action'] = '';
	}

	$types = array(
		'wiki page',
		'blog post',
		'article',
		'forum post',
		'trackeritem',

	);
	$filter = isset($_REQUEST['filter']) ? $_REQUEST['filter'] : array();

	// General
	$smarty->assign('filter_action', $params['action']);

	$smarty->assign('filter_content', isset($filter['content']) ? $filter['content'] : '');
	$smarty->assign('filter_type', isset($filter['type']) ? $filter['type'] : '');
	$smarty->assign('filter_types', array_combine($types, array_map('tra', $types)));

	// Categories
	$smarty->assign('filter_deep', isset($filter['deep']));
	$smarty->assign('filter_categories', isset($filter['categories']) ? $filter['categories'] : '');
	$smarty->assign('filter_categmap', json_encode(TikiDb::get()->fetchMap('SELECT categId, name FROM tiki_categories')));

	return $smarty->fetch('filter.tpl');
}

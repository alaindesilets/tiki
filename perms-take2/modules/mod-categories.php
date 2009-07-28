<?php

// $Id$

//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}
if (!function_exists("categories_help")) {
	function categories_help() {
		return "type=wiki page|article|faq|blog|image gallery|image|file gallery|tracker|trackerItem|quiz|poll|survey|sheet|...,deep=on|off, categId=0,style=tree|vert|horiz|plain|phptree";
	}
}

global $prefs, $smarty;

if ($prefs['feature_categories'] != 'y') {
	$module_params['error'] = tra("This feature is disabled").": feature_categories";
} else {
	global $user;
	global $categlib; include_once ('lib/categories/categlib.php');
	if (isset($module_params['type'])) {
		$type = $module_params['type'];
		$urlEnd = '&amp;type='.urlencode($type);
	} else {
		$type = '';
		$urlEnd = '';
	}
	if (isset($module_params['deep']))
		$deep = $module_params['deep'];
	else
		$deep= 'on';
	$urlEnd .= "&amp;deep=$deep";
	$name = "";

	$categories = $categlib->get_all_categories_respect_perms(null, 'view_category');

	if ( empty($categories) ) {
		$module_params['error'] = tra("You do not have permission to use this feature");
	}
	if (isset($module_params['categId'])) {
		$categId = $module_params['categId'];
		foreach ($categories as $cat) {
			if ($cat['categId'] == $categId)
				$name = $cat['name'];
		}
	} else
		$categId = 0;

	if (isset($module_params['style']))
		$style = $module_params['style'];
	else
		$style = 'tree';
		
	if ($prefs['feature_phplayers'] == 'y') {
		global $tikiphplayers; include_once('lib/phplayers_tiki/tiki-phplayers.php');
		$urlEnd .= "\n";
		if ($categId != 0 && $name != "") {
			list($itall, $count) = $tikiphplayers->mkCatEntry($categId, "..", "", $categories, $urlEnd);
			$itall = '.|'.$name.'|tiki-browse_categories.php?parentId='.$categId.$urlEnd.$itall;
		} else {
			list($itall, $count) = $tikiphplayers->mkCatEntry($categId, ".", "", $categories, $urlEnd);
		}
		$smarty->assign('tree', $tikiphplayers->mkmenu($itall, $name, $style));
	} else {
		include_once ('lib/tree/categ_browse_tree.php');
		$tree_nodes = array();
		foreach ($categories as $cat) {
			$tree_nodes[] = array(
				"id" => $cat["categId"],
				"parent" => $cat["parentId"],
				"data" => '<a class="catname" href="tiki-browse_categories.php?parentId=' . $cat["categId"] .$urlEnd.'">' . $cat["name"] . '</a><br />'
			);
		}
		$tm = new CatBrowseTreeMaker("mod_categ");
		$res = $tm->make_tree($categId, $tree_nodes);
		$smarty->assign('tree', $res);
	}
}


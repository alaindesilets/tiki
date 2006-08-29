<?php

// $Header: /cvsroot/tikiwiki/tiki/categorize_list.php,v 1.18 2006-08-29 20:19:01 sylvieg Exp $

// Copyright (c) 2002-2005, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

//this script may only be included - so its better to err & die if called directly.
//smarty is not there - we need setup
require_once('tiki-setup.php');  
$access->check_script($_SERVER["SCRIPT_NAME"],basename(__FILE__));

include_once ('lib/categories/categlib.php');

$smarty->assign('mandatory_category', '-1');
if ($feature_categories == 'y') {
	$smarty->assign('cat_categorize', 'n');

	if (isset($_REQUEST["cat_categorize"]) && $_REQUEST["cat_categorize"] == 'on') {
		$smarty->assign('cat_categorize', 'y');
	}

	$cats = $categlib->get_object_categories($cat_type, $cat_objid);
	if ($cat_type == 'wiki page' || $cat_type == 'blog' || $cat_type == 'image gallery') {
		$ext = ($cat_type == 'wiki page')? 'wiki':str_replace(' ', '_', $cat_type);
		$pref = 'feature_'.$ext.'_mandatory_category';
		if ($$pref > 0)
			$categories = $categlib->list_categs($$pref);
		else
			$categories = $categlib->list_categs();
		$smarty->assign('mandatory_category', $$pref);
	} else
		$categories = $categlib->list_categs();
	$num_categories = count($categories);

	for ($i = 0; $i < $num_categories; $i++) {
		if (in_array($categories[$i]["categId"], $cats)) {
			$categories[$i]["incat"] = 'y';
		} else {
			$categories[$i]["incat"] = 'n';
		}
		if (isset($_REQUEST["cat_categories"]) && isset($_REQUEST["cat_categorize"]) && $_REQUEST["cat_categorize"] == 'on') {
			if (in_array($categories[$i]["categId"], $_REQUEST["cat_categories"])) {
				$categories[$i]["incat"] = 'y';
				// allow to preselect categories when creating a new article
				// like this: /tiki-edit_article.php?cat_categories[]=1&cat_categorize=on
				$smarty->assign('categ_checked', 'y');
			} else {
				$categories[$i]["incat"] = 'n';
			}
		}
	}

	$smarty->assign('catsdump', implode(',',$cats));
	$smarty->assign_by_ref('categories', $categories);

	// check if this page is categorized
	if ($categlib->is_categorized($cat_type, $cat_objid)) {
		$cat_categorize = 'y';
	} else {
		$cat_categorize = 'n';
	}
	$smarty->assign('cat_categorize', $cat_categorize);
}

?>

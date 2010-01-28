<?php

//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

function module_last_created_blogs_info() {
	return array(
		'name' => tra('Last Created blogs'),
		'description' => tra('Displays the specified number of blogs from newest to oldest.'),
		'prefs' => array("feature_blogs"),
		'params' => array(),
		'common_params' => array('nonums', 'rows')
	);
}

function module_last_created_blogs( $mod_reference, $module_params ) {
	global $tikilib, $smarty;
	$ranking = $tikilib->list_blogs(0, $mod_reference["rows"], 'created_desc', '', 'blog');
	
	$smarty->assign('modLastCreatedBlogs', $ranking["data"]);
}

<?php

//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

global $bloglib;
if (!is_object($bloglib)) {
	include_once('lib/blogs/bloglib.php');
}
$ranking = $bloglib->list_blogs(0, $module_rows, 'hits_desc', '');

$smarty->assign('modTopVisitedBlogs', $ranking["data"]);
$smarty->assign('nonums', isset($module_params["nonums"]) ? $module_params["nonums"] : 'n');

?>

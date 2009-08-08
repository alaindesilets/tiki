<?php

//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}
global $tikilib, $smarty;
$ranking = $tikilib->get_files(0, $module_rows, 'lastModif_desc', null, -1, false, true, false, false);

$smarty->assign('modLastFileGalleries', $ranking["data"]);
$smarty->assign('nonums', isset($module_params["nonums"]) ? $module_params["nonums"] : 'n');



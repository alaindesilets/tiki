<?php

//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

function module_last_created_quizzes_info() {
	return array(
		'name' => tra('Last Created Quizzes'),
		'description' => tra('Displays the specified number of quizzes from newest to oldest.'),
		'prefs' => array("feature_quizzes"),
		'params' => array(),
		'common_params' => array('nonums', 'rows')
	);
}

function module_last_created_quizzes( $mod_reference, $module_params ) {
	global $tikilib, $smarty;
	$ranking = $tikilib->list_quizzes(0, $mod_reference["rows"], 'created_desc', '');
	
	$smarty->assign('modLastCreatedQuizzes', $ranking["data"]);
}
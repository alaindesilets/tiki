<?php
// Initialization
$section = 'tinvoice';
require_once ('tiki-setup.php');
require_once ('lib/tinvoice/tinvoicelib.php');

if ($feature_tinvoice != 'y') {
	$smarty->assign('msg', tra("This feature is disabled").": feature_tinvoice");

	$smarty->display("error.tpl");
	die;
}
if ($feature_ajax != 'y') {
	$smarty->assign('msg', tra("This feature is disabled").": feature_ajax");

	$smarty->display("error.tpl");
	die;
}
if ($tiki_p_tinvoice_edit != 'y') {
	$smarty->assign('msg', tra("You do not have permission to use this feature"));

	$smarty->display("error.tpl");
	die;
}
$tinvoicelib=new TinvoiceLib($dbTiki);
$userId=$tikilib->get_user_id($user);
$banks=$tinvoicelib->list_banks($userId);
$smarty->assign("banks",$banks);

var_dump($banks);
// Display the template
$smarty->assign('mid', 'tiki-tinvoice_banks.tpl');
$smarty->display("tiki.tpl");

?>

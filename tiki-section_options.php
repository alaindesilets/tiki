<?php # $Header: /cvsroot/tikiwiki/tiki/tiki-section_options.php,v 1.3 2003-03-22 22:39:07 lrargerich Exp $

if($feature_theme_control == 'y') {
	include('tiki-tc.php');
}

if($layout_section == 'y') {
$section_top_bar=$section.'_top_bar';
$section_bot_bar=$section.'_bot_bar';
$section_left_column=$section.'_left_column';
$section_right_column=$section.'_right_column';
if(isset($$section_top_bar)) {
$smarty->assign('feature_top_bar',$$section_top_bar);
$smarty->assign('feature_bot_bar',$$section_bot_bar);
$smarty->assign('feature_left_column',$$section_left_column);
$smarty->assign('feature_right_column',$$section_right_column);
} else {
$smarty->assign('feature_top_bar','y');
$smarty->assign('feature_bot_bar','y');
$smarty->assign('feature_left_column','y');
$smarty->assign('feature_right_column','y');
	
}
}
?>
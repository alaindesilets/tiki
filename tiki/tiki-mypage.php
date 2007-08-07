<?php

// $Header: /cvsroot/tikiwiki/tiki/tiki-mypage.php,v 1.4 2007-08-07 14:02:54 niclone Exp $

// Copyright (c) 2002-2007, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

require_once ('tiki-setup.php');
require_once ('lib/mypage/mypagelib.php');
require_once ('lib/ajax/ajaxlib.php');

if (strlen($user) <= 0) {
    $id_users=0;
} else {
    $id_users=$userlib->get_user_id($user);
}

function mypage_ajax_init() {
    global $ajaxlib;

    //$ajaxlib->debugOn();
    $ajaxlib->setRequestURI("tiki-mypage_ajax.php");
    $ajaxlib->registerFunction("mypage_win_setrect");
    $ajaxlib->registerFunction("mypage_win_destroy");
    $ajaxlib->registerFunction("mypage_win_create");
    $ajaxlib->processRequests();
}

function mypage_init() {
    global $smarty, $headerlib, $id_users;

    $headerlib->add_cssfile("lib/mootools/extensions/windoo/themes/windoo.css");
    $headerlib->add_cssfile("lib/mootools/extensions/windoo/themes/windoo.aero.css");
    $headerlib->add_cssfile("lib/mootools/extensions/windoo/themes/windoo.alphacube.css");
    $headerlib->add_cssfile("lib/mootools/extensions/windoo/themes/windoo.aqua.css");


    $id_mypage=isset($_REQUEST['id_mypage']) ? (int)$_REQUEST['id_mypage'] : 0;

    $mypage=new MyPage($id_mypage, $id_users);
    $smarty->assign('mypagejswindows', $mypage->getJSCode());
    $smarty->assign('id_mypage', $id_mypage);

    $width=$mypage->getParam('width');
    $height=$mypage->getParam('height');
    $width=($width == 0 ? '100%' : $width.'px');
    $height=($height == 0 ? '100%' : $height.'px');

    $smarty->assign('mypage_width', $width);
    $smarty->assign('mypage_height', $height);

    // deactivate left and right columns 
    $smarty->assign('feature_right_column', 'n');
    $smarty->assign('feature_left_column', 'n');


    mypage_ajax_init();

    $smarty->assign("mid", "tiki-mypage.tpl");
    $smarty->display("tiki.tpl");

}


mypage_init();

?>

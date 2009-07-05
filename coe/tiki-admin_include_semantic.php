<?php
// $Id: /cvsroot/tikiwiki/tiki/tiki-admin_include_blogs.php,v 1.20.2.1 2007-10-20 05:21:41 pkdille Exp $
// Copyright (c) 2002-2007, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER["SCRIPT_NAME"], basename(__FILE__)) !== false) {
    header("location: index.php");
    exit;
}
require_once 'lib/wiki/semanticlib.php';
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    check_ticket('admin-inc-semantic');
    if (isset($_POST['save'])) {
        $result = $semanticlib->replaceToken($_POST['token'], $_POST['newName'], $_POST['label'], $_POST['invert']);
        if ($result === true) {
            $_REQUEST['token'] = $_POST['newName'];
        } else {
            $smarty->assign('save_message', $result);
        }
    }
    if (isset($_POST['remove'])) {
        $list = array();
        if (isset($_POST['select'])) $list = (array)$_POST['select'];
        foreach($list as $token) $semanticlib->removeToken($token);
    }
    if (isset($_POST['removeclean'])) {
        $list = array();
        if (isset($_POST['select'])) $list = (array)$_POST['select'];
        foreach($list as $token) $semanticlib->removeToken($token, true);
    }
    if (isset($_POST['clean'])) {
        $list = array();
        if (isset($_POST['select'])) $list = (array)$_POST['select'];
        foreach($list as $token) $semanticlib->cleanToken($token);
    }
    if (isset($_POST['oldName'])) {
        $semanticlib->renameToken($_POST['oldName'], $_POST['token']);
    }
}
$smarty->assign('tokens', $semanticlib->getTokens());
$smarty->assign('new_tokens', $semanticlib->getNewTokens());
if (isset($_POST['select'])) {
    $smarty->assign('select', $_POST['select']);
}
if (isset($_REQUEST['token']) && $semanticlib->isValid($_REQUEST['token']) && (isset($_POST['create']) || false !== $semanticlib->getToken($_REQUEST['token']))) {
    $smarty->assign('selected_token', $_REQUEST['token']);
    $smarty->assign('selected_detail', $semanticlib->getToken($_REQUEST['token']));
}
if (isset($_REQUEST['rename'])) {
    $smarty->assign('rename', $_REQUEST['token']);
}
if (isset($_POST['list'])) {
    $lists = array();
    $list = array();
    if (isset($_POST['select'])) $list = (array)$_POST['select'];
    foreach($list as $token) {
        $lists[$token] = $semanticlib->getLinksUsing($token);
    }
    $smarty->assign('link_lists', $lists);
}
ask_ticket('admin-inc-semantic');

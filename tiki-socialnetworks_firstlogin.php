<?php

require_once ('tiki-setup.php');
$access->check_user($user);
	
if ($prefs['ajax_xajax'] == 'y') {
	global $ajaxlib;
	include_once ('lib/ajax/ajaxlib.php');
	include_once ('register_ajax.php');
	$ajaxlib->registerFunction('chkRegName');
	$ajaxlib->registerFunction('chkRegEmail');
	$ajaxlib->registerTemplate('tiki-register.tpl');
	$ajaxlib->processRequests();
}

$smarty->assign('msg', '');
$smarty->assign('alldone', false);

//groups choice
if (count($registrationlib->merged_prefs['choosable_groups'])) {
    $smarty->assign('listgroups', $registrationlib->merged_prefs['choosable_groups']);
    if (count($registrationlib->merged_prefs['choosable_groups']) == 1) {
        $smarty->assign_by_ref('theChoiceGroup', $registrationlib->merged_prefs['choosable_groups'][0]['groupName']);
    }
}

if (isset($_REQUEST["localinfosubmit"])) {
	if (empty($_REQUEST["name"]) || empty($_REQUEST["email"])) {
		$smarty->assign('msg', tra('Username and email are mandatory'));
	} elseif ($userlib->user_exists($_REQUEST["name"])) {
		$smarty->assign('msg', tra('User already exists'));
	} elseif (!preg_match('/^[_a-z0-9\.\-]+@[_a-z0-9\.\-]+\.[a-z]{2,4}$/i', $_REQUEST["email"])) {
		$smarty->assign('msg', tra('Email is invalid'));
	} else {
		$tikilib->set_user_preference($user, 'socialnetworks_user_firstlogin', 'n');
		$userlib->change_user_email($user, $_REQUEST["email"]);
		$userlib->change_login($user, $_REQUEST["name"]);
		$user = $_REQUEST["name"];
		$_SESSION[$user_cookie_site] = $user;
		if (isset($_REQUEST['chosenGroup']) && $userlib->get_registrationChoice($_REQUEST['chosenGroup']) == 'y') {
			$userlib->set_default_group($user, $_REQUEST['chosenGroup']);
		}
		$smarty->assign('alldone', true);
	}
}

if (isset($_REQUEST["linkaccount"])) {
	list($isvalid, $user, $error) = $userlib->validate_user($_REQUEST["userlogin"], $_REQUEST["userpass"]);
	if (!$isvalid) {
		$smarty->assign('msg', tra('Invalid username or password'));
	} else {
		$facebook_id = $tikilib->get_user_preference($user, 'facebook_id');
		// TODO set other social networking IDs
		$tikilib->set_user_preference($_REQUEST["userlogin"], 'socialnetworks_user_firstlogin', 'n');
		$tikilib->set_user_preference($_REQUEST["userlogin"], 'facebook_id', $facebook_id);
		$tikilib->set_user_preference($user, 'facebook_id', '');
		$userlib->remove_user($user);
		$user = $_REQUEST["userlogin"];
		$_SESSION[$user_cookie_site] = $user;
		$smarty->assign('alldone', true);
	}
}

$smarty->assign('mid','tiki-socialnetworks_firstlogin.tpl');
$smarty->display('tiki.tpl');
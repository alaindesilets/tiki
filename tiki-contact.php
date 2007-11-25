<?php

// $Header: /cvsroot/tikiwiki/tiki/tiki-contact.php,v 1.25.2.1 2007-11-25 21:35:24 sylvieg Exp $

// Copyright (c) 2002-2007, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

// Initialization
require_once ('tiki-setup.php');

include_once ('lib/messu/messulib.php');
include_once ('lib/userprefs/scrambleEmail.php');


if ($prefs['feature_contact'] != 'y') {
	$smarty->assign('msg', tra('This feature is disabled').': feature_contact');
	$smarty->display('error.tpl');
	die;
}
if ($prefs['contact_anon'] != 'y') {
  $access->check_user($user);
}

$smarty->assign('mid', 'tiki-contact.tpl');

$email = $userlib->get_admin_email();
$email = scrambleEmail($email, $tikilib->get_user_preference('admin', "email is public"));

$smarty->assign('email', $email);

if ($user == '' and $prefs['contact_anon'] == 'y') {
  $user = 'anonymous';
	$smarty->assign('sent', 0);
	if (isset($_REQUEST['send'])) {
		check_ticket('contact');
		$smarty->assign('sent', 1);
		$message = '';
		// Validation:
		// must have a subject or body non-empty (or both)
		if (empty($_REQUEST['subject']) && empty($_REQUEST['body'])) {
			$smarty->assign('message', tra('ERROR: you must include a subject or a message at least'));
			$smarty->display("tiki.tpl");
			die;
		}
		$messulib->post_message($prefs['contact_user'], $user, $_REQUEST['to'],
			'', $_REQUEST['subject'], $_REQUEST['body'], $_REQUEST['priority']);
		$message = tra('Message sent to'). ':' . $prefs['contact_user'] . '<br />';
		$smarty->assign('message', $message);
	}
}


if ($user and $prefs['feature_messages'] == 'y' and $tiki_p_messages == 'y') {
	$smarty->assign('sent', 0);

	if (isset($_REQUEST['send'])) {
		check_ticket('contact');
		$smarty->assign('sent', 1);

		$message = '';

		// Validation:
		// must have a subject or body non-empty (or both)
		if (empty($_REQUEST['subject']) && empty($_REQUEST['body'])) {
			$smarty->assign('message', tra('ERROR: Either the subject or body must be non-empty'));

			$smarty->display("tiki.tpl");
			die;
		}

		$message = tra('Message sent to'). ':' . $prefs['contact_user'] . '<br />';
		$messulib->post_message($prefs['contact_user'], $user, $_REQUEST['to'],
			'', $_REQUEST['subject'], $_REQUEST['body'], $_REQUEST['priority']);

		$smarty->assign('message', $message);
	}
}

$smarty->assign('priority', 3);
ask_ticket('contact');

$smarty->display("tiki.tpl");

?>

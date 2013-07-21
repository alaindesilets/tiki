<?php
// (c) Copyright 2002-2009 by authors of the Tiki Wiki/CMS/Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

require_once ('tiki-setup.php');
require_once ('lib/ajax/ajaxlib.php');
function AJAXCheckUserName($name) {
	global $userlib;
	$objResponse = new xajaxResponse();
$objResponse->addAlert('---');
	if (empty($name)) {
		$objResponse->addAssign("checkfield", "innerHTML", tra("empty"));
	} else if ($userlib->user_exists($name)) {
		$objResponse->addAssign("checkfield", "innerHTML", tra('User already exists'));
	} else {
		$objResponse->addAssign("checkfield", "innerHTML", tra('Valid') . ' ' . tra('user'));
	}
	return $objResponse;
}
function AJAXCheckMail($mail) {
	$objResponse = new xajaxResponse();
	if (empty($mail)) {
		$objResponse->addAssign("checkmail", "innerHTML", tra("empty"));
	} else if (!eregi("^[_a-z0-9\.\-]+@[_a-z0-9\.\-]+\.[a-z]{2,4}$", $mail)) {
		$objResponse->addAssign("checkmail", "innerHTML", tra('This is not a valid mail adress'));
	} else {
		$objResponse->addAssign("checkmail", "innerHTML", tra('Valid') . ' ' . tra('mail adress'));
	}
	return $objResponse;
}
// xajax
$ajaxlib->setRequestURI('tiki-register_ajax.php');
$ajaxlib->registerFunction('AJAXCheckUserName');
$ajaxlib->registerFunction('AJAXCheckMail');
$ajaxlib->processRequests();
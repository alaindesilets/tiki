<?php

// $Header: /cvsroot/tikiwiki/tiki/tiki-adminusers.php,v 1.36 2004-07-11 15:52:58 redflo Exp $

// Copyright (c) 2002-2004, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

// Initialization
$tikifeedback = array();
require_once ('tiki-setup.php');
require_once ('lib/userslib/userslib_admin.php');

if ($user != 'admin') {
	if ($tiki_p_admin != 'y') {
		$smarty->assign('msg', tra("You dont have permission to use this feature"));
		$smarty->display("error.tpl");
		die;
	}
}

function discardUser($u, $reason) {
	$u['reason'] = $reason;
	return $u;
}

function batchImportUsers() {
	global $userlib, $smarty;

	$fname = $_FILES['csvlist']['tmp_name'];
	$fhandle = fopen($fname, "r");
	$fields = fgetcsv($fhandle, 1000);
	if (!$fields[0]) {
		$smarty->assign('msg', tra("The file is not a CSV file or has not a correct syntax"));
		$smarty->display("error.tpl");
		die;
	}
	while (!feof($fhandle)) {
		$data = fgetcsv($fhandle, 1000);
		$temp_max = count($fields);
		for ($i = 0; $i < $temp_max; $i++) {
			@$ar[$fields[$i]] = $data[$i];
		}
		$userrecs[] = $ar;
	}
	fclose ($fhandle);
	if (!is_array($userrecs)) {
		$smarty->assign('msg', tra("No records were found. Check the file please!"));
		$smarty->display("error.tpl");
		die;
	}
	$added = 0;
	foreach ($userrecs as $u) {
		if (empty($u['login'])) {
			$discarded[] = discardUser($u, tra("User login is required"));
		} elseif (empty($u['password'])) {
			$discarded[] = discardUser($u, tra("Password is required"));
		} elseif (empty($u['email'])) {
			$discarded[] = discardUser($u, tra("Email is required"));
		} elseif ($userlib->user_exists($u['login'])and (!$_REQUEST['overwrite'])) {
			$discarded[] = discardUser($u, tra("User is duplicated"));
		} else {
			if (!$userlib->user_exists($u['login'])) {
				$userslibadmin->add_user($u['login'], $u['password'], $u['email']);
			}

			$userlib->set_user_fields($u);

			if (@$u['groups']) {
				$grps = explode(",", $u['groups']);

				foreach ($grps as $grp) {
					if ($userlib->group_exists($grp)) {
						$userlib->assign_user_to_group($u['login'], $grp);
					}
				}
			}
			$added++;
		}
	}
	$smarty->assign('added', $added);
	if (@is_array($discarded)) {
		$smarty->assign('discarded', count($discarded));
	}
	@$smarty->assign('discardlist', $discarded);
}

$cookietab = "1";

// Process the form to add a user here
if (isset($_REQUEST["newuser"])) {
	check_ticket('admin-users');
	// if no user data entered, check if it's a batch upload  
	if ((!$_REQUEST["name"]) and (is_uploaded_file($_FILES['csvlist']['tmp_name']))) {
		batchImportUsers();
	} else {
		// Check if the user already exists
		if ($_REQUEST["pass"] != $_REQUEST["pass2"]) {
			$tikifeedback[] = array('num'=>1,'mes'=>tra("The passwords don't match"));
		} else {
			if ($userlib->user_exists($_REQUEST["name"])) {
				$tikifeedback[] = array('num'=>1,'mes'=>sprintf(tra("User %s already exists"),$_REQUEST["name"]));
			} else {
				if ($userslibadmin->add_user($_REQUEST["name"], $_REQUEST["pass"], $_REQUEST["email"])) {
					$tikifeedback[] = array('num'=>0,'mes'=>sprintf(tra("New %s created with %s %s."),tra("user"),tra("username"),$_REQUEST["name"]));
					$cookietab = '1';
					$_REQUEST['find'] = $_REQUEST["name"];
				} else {
					$tikifeedback[] = array('num'=>1,'mes'=>sprintf(tra("Impossible to create new %s with %s %s."),tra("user"),tra("username"),$_REQUEST["name"]));
				}
			}
		}
		if (isset($tikifeedback[0]['msg'])) {
			$logslib->add_log('adminusers','',$tikifeedback[0]['msg']);
		}
	}
} elseif (isset($_REQUEST["action"])) {
	if ($_REQUEST["action"] == 'delete') {
		$area = 'deluser';
		if (isset($_POST['daconfirm']) and isset($_SESSION["ticket_$area"])) {
			key_check($area);
			$userslibadmin->remove_user($_REQUEST["user"]);
			$tikifeedback[] = array('num'=>0,'mes'=>sprintf(tra("%s %s successfully deleted."),tra("user"),$_REQUEST["user"]));
		} else {
			key_get($area);
		}
	}
	if ($_REQUEST["action"] == 'removegroup') {
		$area = 'deluserfromgroup';
		if (isset($_POST['daconfirm']) and isset($_SESSION["ticket_$area"])) {
			key_check($area);
			$userslibadmin->remove_user_from_group($_REQUEST["user"], $_REQUEST["group"]);
			$tikifeedback[] = array('num'=>0,'mes'=>sprintf(tra("%s %s removed from %s %s."),tra("user"),$_REQUEST["user"],tra("group"),$_REQUEST["group"]));
		} else {
			key_get($area);
		}
	}
	$_REQUEST["user"] = '';
	if (isset($tikifeedback[0]['msg'])) {
		$logslib->add_log('adminusers','',$tikifeedback[0]['msg']);
	}					
}

if (!isset($_REQUEST["sort_mode"])) {
	$sort_mode = 'login_asc';
} else {
	$sort_mode = $_REQUEST["sort_mode"];
}
$smarty->assign_by_ref('sort_mode', $sort_mode);

if (!isset($_REQUEST["numrows"])) {
	$numrows = $maxRecords;
} else {
	$numrows = $_REQUEST["numrows"];
}
$smarty->assign_by_ref('numrows', $numrows);

if (!isset($_REQUEST["offset"])) {
	$offset = 0;
} else {
	$offset = $_REQUEST["offset"];
}
$smarty->assign_by_ref('offset', $offset);


if (isset($_REQUEST["initial"])) {
	$initial = $_REQUEST["initial"];
} else {
	$initial = '';
}
$smarty->assign('initial', $initial);
$smarty->assign('initials', split(' ','a b c d e f g h i j k l m n o p q r s t u v w x y z'));

if (isset($_REQUEST["find"])) {
	$find = $_REQUEST["find"];
} else {
	$find = '';
}
$smarty->assign('find', $find);

$users = $userlib->get_users($offset, $numrows, $sort_mode, $find, $initial);
$smarty->assign_by_ref('users', $users["data"]);
$cant_pages = ceil($users["cant"] / $numrows);
$smarty->assign_by_ref('cant_pages', $cant_pages);
$smarty->assign('actual_page', 1 + ($offset / $numrows));

if ($users["cant"] > ($offset + $numrows)) {
	$smarty->assign('next_offset', $offset + $numrows);
} else {
	$smarty->assign('next_offset', -1);
}
if ($offset > 0) {
	$smarty->assign('prev_offset', $offset - $numrows);
} else {
	$smarty->assign('prev_offset', -1);
}

list($username,$usermail,$usersTrackerId,$chlogin) = array('','','',false);
if (isset($_REQUEST["user"]) and $_REQUEST["user"]) {
	if (ereg("^[a-zA-Z]",$_REQUEST["user"])) {
		$_REQUEST["user"] = $userlib->get_user_id($_REQUEST["user"]);
	}
	$userinfo = $userlib->get_userid_info($_REQUEST["user"]);
	if (isset($_POST["edituser"]) and isset($_POST['name']) and isset($_POST['email'])) {
		//var_dump($_POST);die;
		if ($_POST['name']) {
			if ($userinfo['login'] != $_POST['name']) {
				if ($userlib->user_exists($_POST['name'])) {
					$smarty->assign('msg', tra("User already exists"));
			  	$smarty->display("error.tpl");
					die;
				}
				$chlogin = true;
			}
		}
		if (isset($_POST['pass']) &&  $_POST["pass"]) {
			if ($_POST["pass"] != $_POST["pass2"]) {
				$smarty->assign('msg', tra("The passwords dont match"));
				$smarty->display("error.tpl");
				die;
			} 
			if (strlen($_POST["pass"])<$min_pass_length) {
				$smarty->assign('msg',tra("Password should be at least").' '.$min_pass_length.' '.tra("characters long"));
				$smarty->display("error.tpl");
				die; 	
			} 
			if ($pass_chr_num == 'y') {
				if (!preg_match_all("/[0-9]+/",$_POST["pass"],$foo) || !preg_match_all("/[A-Za-z]+/",$_POST["pass1"],$foo)) {
					$smarty->assign('msg',tra("Password must contain both letters and numbers"));
					$smarty->display("error.tpl");
					die; 	
				}
			}
			if ($userlib->change_user_password($_POST['name'],$_POST["pass"])) {
				$tikifeedback[] = array('num'=>0,'mes'=>sprintf(tra("%s modified successfully."),tra("password")));
				$logslib->add_log('adminusers','','changed password for '.$_POST['name']);
			} else {
				$tikifeedback[] = array('num'=>0,'mes'=>sprintf(tra("%s modification failed."),tra("password")));
			}
		}
		if ($userinfo['email'] != $_POST['email']) {
			if ($userlib->change_user_email($_POST['name'],$_POST['email'],'')) {
				$tikifeedback[] = array('num'=>0,'mes'=>sprintf(tra("%s changed from %s to %s"),tra("email"),$userinfo['email'],$_POST["email"]));
				$logslib->add_log('adminusers','','changed email for '.$_POST['name'].' from '.$userinfo['email'].' to '.$_POST["email"]);
				$userinfo['email'] = $_POST['email'];
			} else {
				$tikifeedback[] = array('num'=>1,'mes'=>sprintf(tra("Impossible to change %s from %s to %s"),tra("email"),$userinfo['email'],$_POST["email"]));
			}
		}
		if ($chlogin) {
			if ($userlib->change_login($userinfo['login'],$_POST['name'])) {
				$tikifeedback[] = array('num'=>0,'mes'=>sprintf(tra("%s changed from %s to %s"),tra("login"),$userinfo['login'],$_POST["name"]));
				$logslib->add_log('adminusers','','changed login for '.$_POST['name'].' from '.$userinfo['login'].' to '.$_POST["name"]);
				$userinfo['login'] = $_POST['name'];
			} else {
				$tikifeedback[] = array('num'=>1,'mes'=>sprintf(tra("Impossible to change %s from %s to %s"),tra("login"),$userinfo['email'],$_POST["email"]));
			}
		}
		setcookie("activeTabs".urlencode(substr($_SERVER["REQUEST_URI"],1)),"tab1");
	}
	if ($userTracker == 'y') {
		$re = $userlib->get_usertracker($_REQUEST["user"]);
		if ($re['usersTrackerId']) {
			include_once('lib/trackers/trackerlib.php');
			$userstrackerid = $re["usersTrackerId"];
			$smarty->assign('userstrackerid',$userstrackerid);
			$usersFields = $trklib->list_tracker_fields($usersTrackerId, 0, -1, 'position_asc', '');
			$smarty->assign_by_ref('usersFields', $usersFields['data']);
			if (isset($re["usersFieldId"]) and $re["usersFieldId"]) {
				$usersfieldid = $re["usersFieldId"];
				$smarty->assign('usersfieldid',$usersfieldid);
				$usersitemid = $trklib->get_item_id($userstrackerid,$usersfieldid,$re["user"]);
				$smarty->assign('usersitemid',$usersitemid);
			}
		}
	}
	$cookietab = "2";
} else {
	$userinfo['login'] = '';
	$userinfo['email'] = '';
	$userinfo['created'] = date('U');
	$userinfo['registrationDate'] = '';
	$userinfo['lastLogin'] = '';
	$cookietab = "1";
	$_REQUEST["user"] = 0;
}
if (isset($_REQUEST['add'])) {
	$cookietab = "2";
}

$smarty->assign('userinfo', $userinfo);
$smarty->assign('userId', $_REQUEST["user"]);
$smarty->assign('username', $username);
$smarty->assign('usermail', $usermail);

$smarty->assign_by_ref('tikifeedback', $tikifeedback);

setcookie('tab',$cookietab);
$smarty->assign('cookietab',$cookietab);

ask_ticket('admin-users');

$smarty->assign('uses_tabs', 'y');

$smarty->assign('mid', 'tiki-adminusers.tpl');
$smarty->display("tiki.tpl");
?>

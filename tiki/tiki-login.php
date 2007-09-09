<?php

// $Header: /cvsroot/tikiwiki/tiki/tiki-login.php,v 1.84 2007-09-09 17:25:37 lphuberdeau Exp $

// Copyright (c) 2002-2007, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

# $Header: /cvsroot/tikiwiki/tiki/tiki-login.php,v 1.84 2007-09-09 17:25:37 lphuberdeau Exp $

// Initialization
$bypass_siteclose_check = 'y';
require_once('tiki-setup.php');

if ( ! (isset($_REQUEST['user']) or isset($_REQUEST['username'])) ) {
	header('Location: '.$base_url.'tiki-login_scr.php');
	die;
}
// Alert user if cookies are switched off
if ( ini_get('session.use_cookies') == 1 && ! isset($_COOKIE['PHPSESSID']) ) {
	header('Location: '.$base_url.'tiki-error.php?error='.urlencode(tra('You have to enable cookies to be able to login to this site')));
	die;
}

// Redirect to HTTPS if we are not in HTTPS but we require HTTPS login
if ( ! $https_mode && $https_login == 'required' ) {
	header('location: '.$base_url_https.$login_url);
	exit;
}
// Redirect to HTTP if we are in HTTPS but we doesn't allow HTTPS login
if ( $https_mode && $https_login == 'disabled' ) {
	header('location: '.$base_url_http.$login_url);
	exit;
}

// Remember where user is logging in from and send them back later; using session variable for those of us who use WebISO services
// Note that loginfrom will always be a complete URL (http://...)
if ( ! isset($_SESSION['loginfrom']) ) {
	$_SESSION['loginfrom'] = ( isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : $tikiIndex );
	if ( ! ereg('^http', $_SESSION['loginfrom']) ) {
		if ( $_SESSION['loginfrom']{0} == '/' ) $_SESSION['loginfrom'] = $url_scheme.'://'.$url_host.(($url_port!='')?":$url_port":'').$_SESSION['loginfrom'];
		else $_SESSION['loginfrom'] = $base_url.$_SESSION['loginfrom'];
	}
}

if ( $tiki_p_admin == 'y' ) {
	if ( isset($_REQUEST['su']) ) {
		if ( $userlib->user_exists($_REQUEST['username']) ) {
			$_SESSION[$user_cookie_site] = $_REQUEST['username'];
			$smarty->assign_by_ref('user', $_REQUEST['username']);
		}

		header('location: '.$_SESSION['loginfrom']);
		// Unset session variable for the next su
		unset($_SESSION['loginfrom']);
		exit;
	}
}

$user = isset($_REQUEST['user']) ? $_REQUEST['user'] : false;
$pass = isset($_REQUEST['pass']) ? $_REQUEST['pass'] : false;
$challenge = isset($_REQUEST['challenge']) ? $_REQUEST['challenge'] : false;
$response = isset($_REQUEST['response']) ? $_REQUEST['response'] : false;
$isvalid = false;
$isdue = false;
$isEmailDue = false;

// admin is always local
if ( $user == 'admin' ) $feature_intertiki = 'n';

// Determine the intertiki domain
if ( $feature_intertiki == 'y' ) {
	if ( ! empty($feature_intertiki_mymaster) ) $_REQUEST['intertiki'] = $feature_intertiki_mymaster;
	elseif ( strstr($user, '@') ) {
		list($user, $intertiki_domain) = explode('@', $user);
		$_REQUEST['intertiki'] = $intertiki_domain;
	}
} else unset($_REQUEST['intertiki']);

// Go through the intertiki process
if ( isset($_REQUEST['intertiki']) and in_array($_REQUEST['intertiki'], array_keys($interlist)) ) {

    include_once('XML/RPC.php');

    function intervalidate($remote,$user,$pass,$get_info = false) {
	global $tiki_key;
	$remote['path'] = preg_replace("/^\/?/","/",$remote['path']);
	$client = new XML_RPC_Client($remote['path'], $remote['host'], $remote['port']);
	$client->setDebug(0);
	$msg = new XML_RPC_Message(
				   'intertiki.validate',
				   array(
					 new XML_RPC_Value($tiki_key, 'string'),
					 new XML_RPC_Value($user, 'string'),
					 new XML_RPC_Value($pass, 'string'),
					 new XML_RPC_Value($get_info, 'boolean')
					 ));
	$result = $client->send($msg);
	return $result;
    }

    $rpcauth = intervalidate($interlist[$_REQUEST['intertiki']],$user,$pass,!empty($feature_intertiki_mymaster)? true : false);

    if (!$rpcauth) {
	$logslib->add_log('login','intertiki : '.$user.'@'.$_REQUEST['intertiki'].': Failed');
	$smarty->assign('msg',tra('Unable to contact remote server.'));
	$smarty->display('error.tpl');
	exit;
    } else {
	if ($faultCode = $rpcauth->faultCode()) {
	    if ($faultCode == 102) {
		$faultCode = 101; // disguise inexistent user
		$userlib->remove_user($user);
	    }

	    $user_msg = tra('XMLRPC Error: ') . $faultCode . ' - ' . tra($rpcauth->faultString());
	    $log_msg = tra('XMLRPC Error: ') . $rpcauth->faultCode() . ' - ' . tra($rpcauth->faultString());
	    $logslib->add_log('login','intertiki : '.$user.'@'.$_REQUEST['intertiki'].': '.$log_msg);
	    $smarty->assign('msg',$user_msg);
	    $smarty->display('error.tpl');
	    exit;
	} else {
	    $isvalid = true;
	    $isdue = false;
		$isEmailDue = false;

	    $logslib->add_log('login','intertiki : '.$user.'@'.$_REQUEST['intertiki']);

	    if (!empty($feature_intertiki_mymaster)) {

		// this is slave intertiki site
		$response_value = $rpcauth->value();
		$user_details = unserialize($response_value->scalarval());

		if (!$userlib->user_exists($user)) {
		    if ($userlib->add_user($user, '', $user_details['info']['email'])) {
		    	$userlib->set_user_fields($user_details['info']);
				} else {
					$logslib->add_log('login','intertiki : login creation failed');
					$smarty->assign('msg',tra('Unable to create login'));
					$smarty->display('error.tpl');
					die;
				}
		} else {
		    $userlib->set_user_fields($user_details['info']);
		    $userlib->update_lastlogin($user);
		}

		if ($feature_userPreferences == 'y' && $feature_intertiki_import_preferences == 'y') {
		    $userlib->set_user_preferences($user, $user_details['preferences']);
		}

		if ($feature_intertiki_import_groups == 'y') {
				if ($feature_intertiki_imported_groups) {
					$groups = preg_split('/\s*,\s*/',$feature_intertiki_imported_groups);
					foreach ($groups as $group) {
						if (in_array(trim($group),$user_details['groups'])) {
							$userlib->assign_user_to_group($user, trim($group));
						}
					}
				} else {
		    	$userlib->assign_user_to_groups($user, $user_details['groups']);
				}
		} else {
		    $groups = preg_split('/\s*,\s*/',$interlist[$feature_intertiki_mymaster]['groups']);
		    foreach ($groups as $group) {
			$userlib->assign_user_to_group($user, trim($group));
		    }
		}

	    } else {
		$user = $user.'@'.$_REQUEST['intertiki'];
		$feature_userPreferences = 'n';
		$smarty->assign('feature_userPreferences',$feature_userPreferences);
	    }

	}
    }
} else {

	// Verify user is valid
	list($isvalid, $user, $error) = $userlib->validate_user($user, $pass, $challenge, $response);

	// If the password is valid but it is due then force the user to change the password by
	// sending the user to the new password change screen without letting him use tiki
	// The user must re-nter the old password so no security risk here
	if ( $isvalid ) {
		$isdue = $userlib->is_due($user);
		if ( $user != 'admin' ) { // admin has not necessarely an email
			$isEmailDue = $userlib->is_email_due($user, 'email');

			// Update some user details from LDAP
			if ( is_array($user_ldap_attributes) ) {
				if ( $user_ldap_attributes['auth_ldap_nameattr'] != '' ) { 
					global $cachelib, $tikidomain;
					require_once('lib/cache/cachelib.php');
					$tikilib->set_user_preference($user, 'realName', $user_ldap_attributes['auth_ldap_nameattr']);
					// Erase cache to update displayed user info
					//   Do not just invalidate cache for 'user_details_'.$user and 'userslist',
					//   since userlink smarty modifier is also using cache with multiple possibilities of keys.
					$cachelib->erase_dir_content("temp/cache/$tikidomain");
				}
			}
		}
	}
}

if ( $isvalid ) {
	if ( $isdue ) {
		// Redirect the user to the screen where he must change his password.
		// Note that the user is not logged in he's just validated to change his password
		// The user must re-enter his old password so no security risk involved
		$url = 'tiki-change_password.php?user=' . urlencode($user). '&oldpass=' . urlencode($pass);
	} elseif ($isEmailDue) {
		$userlib->send_confirm_email($user);
		$smarty->assign('msg', tra('For security purposes we must periodically validate your email address to allow continued access to this site.').' '.tra('A validation email has been sent to you. Please open that email and follow the instructions to once again gain access to the site.').' '.tra('Thank you.'));
		$smarty->assign('user', '');
		unset($user);
		$smarty->assign('do_not_show_login_box', 'y');
		$smarty->assign('mid', 'tiki-information.tpl');
		$smarty->display("tiki.tpl");
		die;
	} else {
		// User is valid and not due to change pass.. start session
		$_SESSION[$user_cookie_site] = $user;
		if( isset( $_SESSION['openid_url'] ) )
			$userlib->assign_openid( $user, $_SESSION['openid_url'] );

		$smarty->assign_by_ref('user', $user);
		$url = $_SESSION['loginfrom'];
		$logslib->add_log('login','logged from '.$url);

		// Special '?page=...' case. Accept only some values to avoid security problems
		switch ( $_REQUEST['page'] ) {
		case 'tikiIndex':
			$url = ${$_REQUEST['page']};
			break;
		default:
			// Go to the group page ?
			if ( $useGroupHome == 'y' ) {
				$url_vars = parse_url($url);
				// Go to the group page only if the loginfrom is the default page
				if ( $limitedGoGroupHome == 'n' || $url == $tikiIndex || $url_vars['path'] == $tikiIndex || basename($url_vars['path']) == $tikiIndex ) {
					$groupHome = $userlib->get_user_default_homepage($user);
					if ( $groupHome != '' ) $url = ( preg_match('/^(\/|https?:)/', $groupHome) ) ? $groupHome : 'tiki-index.php?page='.$groupHome;
				}
				unset($url_vars);
			}
			unset($url_vars);
			// Unset session variable in case user su's
			unset($_SESSION['loginfrom']);
	
			// No sense in sending user to registration page or no page at all
			// This happens if the user has just registered and it's first login
			if ( $url == '' || ereg('(tiki-register|tiki-login_validate|tiki-login_scr)\.php', $url) ) $url = $tikiIndex;
	
			// Now if the remember me feature is on and the user checked the rememberme checkbox then ...
			if ( $rememberme != 'disabled' ) {
				if ( isset($_REQUEST['rme']) && $_REQUEST['rme'] == 'on' ) {
					$hash = $userlib->create_user_cookie($_REQUEST['user']);
					$time = substr($hash,strpos($hash,'.')+1);
					setcookie($user_cookie_site, $hash.'.'.$user, $time, $cookie_path, $cookie_domain);
					$logslib->add_log('login',"got a cookie for $remembertime seconds");
				}
			}
		}
	}
} else {
	if ( $error == PASSWORD_INCORRECT && $unsuccessful_logins >= 0 ) {
 		if ( ($nb_bad_logins = $userlib->unsuccessful_logins($user)) >= $unsuccessful_logins ) {
			$msg = sprintf(tra('More than %d unsuccessful login attempts have been made.'), $unsuccessful_logins);
			$smarty->assign('msg', $msg);
			$userlib->send_confirm_email($user, 'unsuccessful_logins');
			$smarty->assign('msg', $msg.' '.tra('An email has been sent to you with the instructions to follow.'));
			$smarty->assign('user', '');
			unset($user);
			$smarty->assign('mid', 'tiki-information.tpl');
			$smarty->display("tiki.tpl");
			die;
		}
		$userlib->set_unsuccessful_logins($user, $nb_bad_logins + 1);
	}
	unset($user);
	unset($isvalid);

	switch ( $error ) {
	case PASSWORD_INCORRECT: $error = tra('Invalid password'); break;
	case USER_NOT_FOUND: $error = tra('Invalid username'); break;
	case ACCOUNT_DISABLED: $error = tra('Account disabled'); break;
	case USER_AMBIGOUS: $error = tra('You must use the right case for your user name'); break;
	case USER_NOT_VALIDATED: $error = tra('You are not yet validated'); break;
	default: $error = tra('Invalid username or password');
	}
	$url = 'tiki-error.php?error='.urlencode($error);

	// on a login error wait this long in seconds. slows down automated login attacks.
	// regular users mistyping on login will experience the delay, too, but wrong logins
	// shouldn't occur that often.
	sleep(5);
}

if ( isset($user) and $feature_score == 'y' ) $tikilib->score_event($user, 'login');


// RFC 2616 defines that the 'Location' HTTP headerconsists of an absolute URI
if ( ! eregi('^https?\:', $url) ) $url = ( ereg('^/', $url) ? $url_scheme.'://'.$url_host.(($url_port!='')?":$url_port":'') : $base_url ).$url;

// Force HTTP mode if needed
if ( $stay_in_ssl_mode != 'y' || ! $https_mode ) $url = str_replace('https://', 'http://', $url);

if ( SID ) $url .= '?'.SID;
header('Location: '.$url);
exit;
?>

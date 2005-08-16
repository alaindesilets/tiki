<?php
// Initialization
require_once('tiki-setup.php');
require_once('lib/tikilib.php'); # httpScheme()
include_once('lib/registration/registrationlib.php');
include_once('lib/notifications/notificationlib.php');
include_once('lib/webmail/tikimaillib.php');
include_once('lib/userprefs/userprefslib.php');

// Permission: needs p_register
if($allowRegister != 'y') {
  header("location: index.php");
  exit;
  die;
}

$smarty->assign('showmsg','n');
// novalidation is set to yes if a user confirms his email is correct after tiki fails to validate it
if (!isset($_REQUEST['novalidation'])) {
	$novalidation = '';
} else {
	$novalidation = $_REQUEST['novalidation'];
}

//get custom fields
$customfields = array();
$customfields = $userprefslib->get_userprefs('CustomFields');
$smarty->assign_by_ref('customfields', $customfields);
		

if(isset($_REQUEST["register"])) {
  check_ticket('register');
  if($novalidation != 'yes' and ($_REQUEST["pass"] <> $_REQUEST["passAgain"])) {
    $smarty->assign('msg',tra("The passwords don't match"));
    $smarty->display("error.tpl");
    die;
  }
list($cant, $u) = $userlib->other_user_exists_case_insensitive($_REQUEST["name"]);
  if($cant > 0) {
    $smarty->assign('msg',tra("User already exists").": ".$u);
    $smarty->display("error.tpl");
    die;
  }
  
  if($rnd_num_reg == 'y') {
  	if($novalidation != 'yes' and(!isset($_SESSION['random_number']) || $_SESSION['random_number']!=$_REQUEST['regcode'])) {
    $smarty->assign('msg',tra("Wrong registration code"));
    $smarty->display("error.tpl");
    die;	
  	}
  }
  
  // VALIDATE NAME HERE
  if(strtolower($_REQUEST["name"])=='admin') {
    $smarty->assign('msg',tra("Invalid username"));
    $smarty->display("error.tpl");
    die;
  }
  
  if(strlen($_REQUEST["name"])>37) {
    $smarty->assign('msg',tra("Username is too long"));
    $smarty->display("error.tpl");
    die;
  }
  
  if(strstr($_REQUEST["name"],' ')) {
    $smarty->assign('msg',tra("Username cannot contain whitespace"));
    $smarty->display("error.tpl");
    die; 	
  }
  
  //Validate password here
  if(strlen($_REQUEST["pass"])<$min_pass_length) {
    $smarty->assign('msg',tra("Password should be at least").' '.$min_pass_length.' '.tra("characters long"));
    $smarty->display("error.tpl");
    die; 	
  }
  
  // Check this code
  if($pass_chr_num == 'y') {
    if(!preg_match_all("/[0-9]+/",$_REQUEST["pass"],$foo) || !preg_match_all("/[A-Za-z]+/",$_REQUEST["pass"],$foo)) {
      $smarty->assign('msg',tra("Password must contain both letters and numbers"));
      $smarty->display("error.tpl");
      die; 	
    }
  }
  
  if(!preg_match_all("/[A-Z0-9a-z\_\-]+/",$_REQUEST["name"],$matches)) {
    $smarty->assign('msg',tra("Invalid username"));
    $smarty->display("error.tpl");
    die;
  }
  
  // Check the mode
  if($useRegisterPasscode == 'y') {
    if(($_REQUEST["passcode"]!=$tikilib->get_preference("registerPasscode",md5($tikilib->genPass()))))
    {
      $smarty->assign('msg',tra("Wrong passcode you need to know the passcode to register in this site"));
      $smarty->display("error.tpl");
      die;
    }
  }
  

    $email_valid = 'yes';
    if($validateUsers=='y') {
      $ret = $registrationlib->SnowCheckMail($_REQUEST["email"],$sender_email,$novalidation);
      if(!$ret[0]) {
      	if($ret[1] == 'not_recognized') {
			$smarty->assign('notrecognized','y');
			$smarty->assign('email',$_REQUEST['email']);
			$smarty->assign('login',$_REQUEST['name']);
			$smarty->assign('password',$_REQUEST['pass']);
			$email_valid = 'no';
      	} else {
//			$smarty->assign('msg',"$ret[1]");
	        $smarty->assign('msg',tra("Invalid email address. You must enter a valid email address"));
	        $smarty->display("error.tpl");
	        $email_valid = 'no';
	        die;
      	}
      }
    }

  if($email_valid != 'no') {
		if($validateUsers == 'y') {
			//$apass = addslashes(substr(md5($tikilib->genPass()),0,25));
			$apass = addslashes(md5($tikilib->genPass()));
			$foo = parse_url($_SERVER["REQUEST_URI"]);
			$foo1=str_replace("tiki-register","tiki-login_validate",$foo["path"]);
			$machine =$tikilib->httpPrefix().$foo1;
			$userlib->add_user($_REQUEST["name"],$apass,$_REQUEST["email"],$_REQUEST["pass"]);
			
			
			$logslib->add_log('register','created account '.$_REQUEST["name"]);
			$smarty->assign('mail_machine',$machine);
			$smarty->assign('mail_site',$_SERVER["SERVER_NAME"]);
			$smarty->assign('mail_user',$_REQUEST["name"]);
			$smarty->assign('mail_apass',$apass);
			$smarty->assign('mail_email',$_REQUEST['email']);
			include_once("lib/notifications/notificationemaillib.php");
			if (isset($validateRegistration) and $validateRegistration == 'y') {
				$smarty->assign('msg',$smarty->fetch('mail/user_validation_waiting_msg.tpl'));
				if ($default_sender_email == NULL or !$default_sender_email) {
					include_once('lib/messu/messulib.php');
					$mail_data = $smarty->fetch('mail/moderate_validation_mail.tpl');
					$mail_subject = $smarty->fetch('mail/moderate_validation_mail_subject.tpl');
					$messulib->post_message($contact_user,$contact_user,$contact_user,'',$mail_subject,$mail_data,5);
				} else {
					$mail_data = $smarty->fetch('mail/moderate_validation_mail.tpl');
					$mail = new TikiMail();
					$mail->setText($mail_data);
					$mail_data = $smarty->fetch('mail/moderate_validation_mail_subject.tpl');
					$mail->setSubject($mail_data);
					if (!$mail->send(array($default_sender_email)))
						$smarty->assign('msg', tra("The registration mail can't be sent. Contact the administrator"));
				}
			} else {
				$mail_data = $smarty->fetch('mail/user_validation_mail.tpl');
				$mail = new TikiMail();
				$mail->setText($mail_data);
				$mail_data = $smarty->fetch('mail/user_validation_mail_subject.tpl');
				$mail->setSubject($mail_data);
				if (!$mail->send(array($_REQUEST["email"])))
					$smarty->assign('msg', tra("The registration mail can't be sent. Contact the administrator"));
				else
					$smarty->assign('msg',$smarty->fetch('mail/user_validation_msg.tpl'));
			}
			$smarty->assign('showmsg','y');
		} else {
			$userlib->add_user($_REQUEST["name"],$_REQUEST["pass"],$_REQUEST["email"],'');
			$logslib->add_log('register','created account '.$_REQUEST["name"]);

			$smarty->assign('msg',$smarty->fetch('mail/user_welcome_msg.tpl'));
			$smarty->assign('showmsg','y');
		}

		// Custom fields
		foreach ($customfields as $custpref=>$prefvalue ) {
		    //print $_REQUEST[$customfields[$custpref]['prefName']];
		    $tikilib->set_user_preference($_REQUEST["name"], $customfields[$custpref]['prefName'], $_REQUEST[$customfields[$custpref]['prefName']]);
		}

		$emails = $notificationlib->get_mail_events('user_registers','*');
		if (count($emails)) {
			include_once("lib/notifications/notificationemaillib.php");
			$smarty->assign('mail_user',$_REQUEST["name"]);
			$smarty->assign('mail_date',date("U"));
			$smarty->assign('mail_site',$_SERVER["SERVER_NAME"]);
			sendEmailNotification($emails, "email", "new_user_notification_subject.tpl", null, "new_user_notification.tpl");
		}

	}

}


ask_ticket('register');

$smarty->assign('mid','tiki-register.tpl');
$smarty->display("tiki.tpl");
?>

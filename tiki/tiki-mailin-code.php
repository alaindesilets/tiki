<?php

// Copyright (c) 2002-2004, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER["SCRIPT_NAME"],"tiki-mailin-code.php")!=FALSE) {
  //smarty is not there - we need setup
  require_once('tiki-setup.php');
  $smarty->assign('msg',tra("This script cannot be called directly"));
  $smarty->display("error.tpl");
  die;
}

include_once ('lib/mailin/mailinlib.php');

require_once ("lib/webmail/pop3.php");
include_once ("lib/webmail/class.rc4crypt.php");

include_once ("lib/mail/mimelib.php");
include_once ("lib/webmail/tikimaillib.php");
/*
That parsing is now integrated in demime
function mailin_parse_output(&$obj, &$parts, $i) {
  if (!empty($obj->parts)) {
  	$temp_max = count($obj->parts);
    for ($i = 0; $i < $temp_max; $i++)
      mailin_parse_output($obj->parts[$i], $parts, $i);
  } else {
    $ctype = $obj->ctype_primary . '/' . $obj->ctype_secondary;

    switch ($ctype) {
    case 'text/plain':
      if (!empty($obj->disposition)AND $obj->disposition == 'attachment') {
        $names = split(';', $obj->headers["content-disposition"]);

        $names = split('=', $names[1]);
        $aux['name'] = $names[1];
        $aux['content-type'] = $obj->headers["content-type"];
        $aux['part'] = $i;
        $parts['attachments'][] = $aux;
      } else {
        $parts['text'][] = $obj->body;
      }

      break;

    case 'text/html':
      if (!empty($obj->disposition)AND $obj->disposition == 'attachment') {
        $names = split(';', $obj->headers["content-disposition"]);

        $names = split('=', $names[1]);
        $aux['name'] = $names[1];
        $aux['content-type'] = $obj->headers["content-type"];
        $aux['part'] = $i;
        $parts['attachments'][] = $aux;
      } else {
        $parts['html'][] = $obj->body;
      }

      break;

    default:
      $names = split(';', $obj->headers["content-disposition"]);

      $names = split('=', $names[1]);
      $aux['name'] = $names[1];
      $aux['content-type'] = $obj->headers["content-type"];
      $aux['part'] = $i;
      $parts['attachments'][] = $aux;
    }
  }
}
*/
// The mailin script is used to get / set wiki pages using an email account

// Get a list of ACTIVE emails accounts configured for mailin procedures
$accs = $mailinlib->list_active_mailin_accounts(0, -1, 'account_desc', '');

//print ('<a href="tiki-admin_mailin.php">Admin</a><br /><br />');
$content = '<br /><br />';

// foreach account
foreach ($accs['data'] as $acc) {
  $content .= "<b>Processing account</b><br />";
  $content .= "Account :" . $acc['account'] . "<br />";
  $content .= "Type    :" . $acc['type'] . "<br />";
  $content .= "--------------------------<br />";
  $pop3 = new POP3($acc["pop"], $acc["username"], $acc["pass"]);
  $pop3->Open();
  $s = $pop3->Stats();
  $mailsum = $s["message"];

  for ($i = 1; $i <= $mailsum; $i++) {
    $aux = $pop3->ListMessage($i);

    $aux["msgid"] = $i;
    $aux["realmsgid"] = $pop3->GetMessageID($i);
    $message = $pop3->GetMessage($i);
    $content .= "Reading a request.<br />From: " . $aux["sender"]["email"] . "<br />Subject: " . $aux["subject"] . "<br />";

    $content .= "sender email: " . $aux["sender"]["email"] . "<br />";
    $aux["sender"]["user"] = $userlib->get_user_by_email($aux["sender"]["email"]);
    $content .= "sender user: " .  $aux["sender"]["user"] . "<br />";

    $cantUseMailIn = $acc["anonymous"]=='n' && empty($aux["sender"]["user"]);
    if($cantUseMailIn) {
      $content .= "Anonymous user acces denied, sending auto-reply to email address:&nbsp;" .  $aux["sender"]["email"] . "<br />";
      $mail = new TikiMail();
      $mail->setFrom($acc["account"]);
      $mail->setSubject(tra('Tiki mail-in auto-reply'));
      $mail->setSMTPParams($acc["smtp"], $acc["smtpPort"], '', $acc["useAuth"], $acc["username"], $acc["pass"]);
      $mail->setText("Sorry, you can't use this feature.");
      $res = $mail->send(array($aux["sender"]["email"]), 'mail');
      $content .= "Response sent<br />";
    } else {
      if (empty($aux["sender"]["user"]))
        $aux["sender"]["user"] = $aux["sender"]["email"];
  
      if (empty($aux["sender"]["name"]))
        $aux["sender"]["name"] = $aux["sender"]["email"];
  
      // Now determine account type
      if ($acc['type'] == 'article-put') {
        // This is used to CREATE articles
        $title = trim($aux['subject']);
  
        $full = $message['full'];
  
        $output = mime::decode($full);
        //mailin_parse_output($output, $parts, 0);
  
        if (isset($output['text'][0])) {
          $msgbody = $output["text"][0];
        }
        
        $heading = $msgbody;
        $topicId = $acc['article_topicId'];
        $user = $aux['sender']['user'];
        $authorName = $user;
        $body = '';
        $publishDate = date('U');
        $expireDate = mktime (0,0,0,date("m"),  date("d"),  date("Y")+1);
        $subId = 0;
        $type = $acc['article_type'];
        $useImage = 'n';
        $image_x = '';
        $image_y = '';
        $imgname = '';
        $imgsize = '';
        $imgtype = '';
        $imgdata = '';
       	$topline = '';
		$subtitle = '';
		$linkto = '';
		$image_caption = '';
		$lang = '';
		$rating = 7;
		$isfloat = 'n';
        
		global $artlib;
		if (!is_object($artlib)) {
			include_once('lib/articles/artlib.php');
		}
		$subid = $artlib->replace_submission($title, $authorName, $topicId, $useImage, $imgname, $imgsize, $imgtype, $imgdata, $heading, 
											$body, $publishDate, $expireDate, $user, $subId, $image_x, $image_y, $type, 
											$topline, $subtitle, $linkto, $image_caption, $lang, $rating, $isfloat);

		global $tiki_p_autoapprove_submission;
		if ($tiki_p_autoapprove_submission == 'y') {
			$artlib->approve_submission($subid);
			$content .= "Article: $title has been submitted<br />";
		} else {
			$content .= "Article: $title has been created<br />";
		}

      }
  
      if ($acc['type'] == 'wiki-get') {
        // A wiki-get account sends a copy of the page to the sender
        // and also sends the source of the page
        $page = trim($aux['subject']);
  
        $mail = new TikiMail();
        $mail->setFrom($acc["account"]);
        $mail->setSubject($page);
  
        if ($tikilib->page_exists($page)) {
          $info = $tikilib->get_page_info($page);
  
          $data = $tikilib->parse_data($info["data"]);
          // Now we should attach the source here
          $mail->addAttachment($info['data'], 'source.txt', 'plain/txt');
        } else {
          $data = 'Page not found';
        }
  
        $mail->setSMTPParams($acc["smtp"], $acc["smtpPort"], '', $acc["useAuth"], $acc["username"], $acc["pass"]);
        $mail->setHTML($data, strip_tags($data));
        $res = $mail->send(array($aux["sender"]["email"]), 'mail');
        $content .= "Response sent<br />";
      // Send the email
      }
  
      if ($acc['type'] == 'wiki-put') {
        // This is used to UPDATE wiki pages
        $page = trim($aux['subject']);
  
        $full = $message["full"];
  
        $output = mime::decode($full);
//        mailin_parse_output($output, $parts, 0);
  
        if (isset($output["text"][0])) {
          $body = $output["text"][0];
				} elseif (isset($output['parts'][0]["text"][0])) {
          $body = $output['parts'][0]["text"][0];
				} else {
					$body = '';
				}
  
        if (!empty($body)) {
          if (!$tikilib->page_exists($page)) {
            $content .= "Page: $page has been created<br />";
  
            $tikilib->create_page($page,
              0, $body, date('U'), "Created from " . $acc["account"], $aux["sender"]["user"], '0.0.0.0', '');
          } else {
            $tikilib->update_page($page, $body, "Created from " . $acc["account"], $aux["sender"]["user"],
              '0.0.0.0', '');
  
            $content .= "Page: $page has been updated";
          }
        }
      }
  
      if ($acc['type'] == 'wiki-append') {
        // This is used to UPDATE wiki pages
        $page = trim($aux['subject']);
  
        $full = $message["full"];
  
        $output = mime::decode($full);
        //mailin_parse_output($output, $parts, 0);
  
        if (isset($output["text"][0]))
          $body = $output["text"][0];
  
        if (isset($body)) {
          if (!$tikilib->page_exists($page)) {
            $content .= "Page: $page has been created<br />";
  
            $tikilib->create_page($page,
              0, $body, date('U'), "Created from " . $acc["account"], $aux["sender"]["user"], '0.0.0.0', '');
          } else {
            $info = $tikilib->get_page_info($page);
  
            $tikilib->update_page($page, $info['data'] . $body,
              "Created from " . $acc["account"], $aux["sender"]["user"], '0.0.0.0', '');
            $content .= "Page: $page has been updated";
          }
        }
      }
  
      if ($acc['type'] == 'wiki') {
        // This is used to GET/SET wiki pages depending on the body
        $p_page = trim($aux['subject']);
  
        $parts = explode(':', $p_page);
  
        if (!isset($parts[1])) {
          $parts[1] = $parts[0];
  
          $parts[0] = 'GET';
        }
  
        $method = $parts[0];
        $page = $parts[1];
        $full = $message["full"];
  
        $output = mime::decode($full);
        //mailin_parse_output($output, $parts, 0);
  
        if (isset($output["text"][0]))
          $body = $output["text"][0];
  
        if ($method == 'PUT') {
          if (!$tikilib->page_exists($page)) {
            $content .= "Page: $page has been created<br />";
  
            $tikilib->create_page($page,
              0, $body, date('U'), "Created from " . $acc["account"], $aux["sender"]["user"], '0.0.0.0', '');
          } else {
            $tikilib->update_page($page, $body, "Created from " . $acc["account"], $aux["sender"]["user"],
              '0.0.0.0', '');
  
            $content .= "Page: $page has been updated";
          }
        } elseif ($method == 'GET') {
          $mail = new TikiMail();
  
          $mail->setFrom($acc["account"]);
          $mail->setSubject($page);
  
          if ($tikilib->page_exists($page)) {
            $info = $tikilib->get_page_info($page);
  
            $data = $tikilib->parse_data($info["data"]);
            // Now we should attach the source here
            $mail->addAttachment($data, $page . '.html', 'plain/html');
  
            $mail->setSMTPParams($acc["smtp"], $acc["smtpPort"], '', $acc["useAuth"], $acc["username"], $acc["pass"]);
            $mail->setHTML($info['data'], strip_tags($data));
            $res = $mail->send(array($aux["sender"]["email"]), 'mail');
            $content .= "Response sent<br />";
          } else {
            $data = 'Page not found';
          }
        } elseif ($method == 'APPEND' || $method == 'PREPEND') {
          if (!$tikilib->page_exists($page)) {
            $content .= "Page: $page has been created<br />";
  
            $tikilib->create_page($page,
              0, $body, date('U'), "Created from " . $acc["account"], $aux["sender"]["user"], '0.0.0.0', '');
          } else {
            $info = $tikilib->get_page_info($page);
  
            $tikilib->update_page($page, ($method=='APPEND' ? $info['data'] . $body : $body . $info['data']),
              "Created from " . $acc["account"], $aux["sender"]["user"], '0.0.0.0', '');
            $content .= "Page: $page has been updated";
          }
        } else {
          $mail = new TikiMail();
  
          $mail->setFrom($acc["account"]);
          $mail->setSubject(tra('Tiki mail-in instructions'));
          $mail->setSMTPParams($acc["smtp"], $acc["smtpPort"], '', $acc["useAuth"], $acc["username"], $acc["pass"]);
          $mail->setText("Use the subject to indicate the operation to apply:\nGET:WikiName to get a wiki page\nPUT:WikiName to update/create a wiki page (use the body for the page data)\nAPPEND:WikiName to append data to a Wiki page (use the body for the data to add)");
          $res = $mail->send(array($aux["sender"]["email"]), 'mail');
        }
      }
    }//end if($cantUseMailIn)
    // Remove the email from the pop3 server
    //$pop3->DeleteMessage($i);
  }//end for ($i = 1; $i <= $mailsum; $i++)

  $pop3->close();
}//end foreach ($accs['data'] as $acc) {

?>

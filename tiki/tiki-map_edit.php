<?php

// $Header: /cvsroot/tikiwiki/tiki/tiki-map_edit.php,v 1.18 2005-01-05 19:22:42 jburleyebuilt Exp $

// Copyright (c) 2002-2005, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

// Initialization
require_once ('tiki-setup.php');

if(!isset($feature_maps) or $feature_maps != 'y') {
  $smarty->assign('msg',tra("Feature disabled"));
  $smarty->display("error.tpl");
  die;
}

if($tiki_p_map_view != 'y') {
  $smarty->assign('msg',tra("You do not have permissions to view the maps"));
  $smarty->display("error.tpl");
  die;
}

if (!isset($_REQUEST["mode"])) {
	$mode = 'listing';
} else {
	$mode = $_REQUEST['mode'];
}

// Validate to prevent editing any file
if (isset($_REQUEST["mapfile"])) {
	if (strstr($_REQUEST["mapfile"], '..')) {
		$smarty->assign('msg', tra("You do not have permission to do that"));
		$smarty->display('error.tpl');
		die;
	}
}
if (!isset($map_path) or !$map_path) {
	$smarty->assign('msg', tra("Maps feature is not correctly setup : Maps path is missing."));
	$smarty->display('error.tpl');
	die;
}

if (!is_dir($map_path)) {
	$smarty->assign('msg', tra("Please create a directory named $map_path to hold your map files."));
	$smarty->display('error.tpl');
	die;							
}

$smarty->assign('tiki_p_map_create', $tiki_p_map_create);

if (isset($_REQUEST["create"]) && ($tiki_p_map_create == 'y')) {
	$newmapfile = $map_path.$_REQUEST["newmapfile"];

	if (!preg_match('/\.map$/i', $newmapfile)) {
		$smarty->assign('msg', tra("mapfile name incorrect"));

		$smarty->display("error.tpl");
		die;
	}
  ini_set("display_errors","0");
	$fp = @fopen($newmapfile, "r");
  ini_set("display_errors","1");
	if ($fp) {
		$smarty->assign('msg', tra("This mapfile already exists"));

		$smarty->display("error.tpl");
		fclose ($fp);
		die;
	}
  ini_set("display_errors","0");
	$fp = fopen($newmapfile, "w");
  ini_set("display_errors","1");
	if (!$fp) {
		$smarty->assign('msg', tra("You do not have permission to write to the mapfile"));

		$smarty->display("error.tpl");
		die;
	}

	fclose ($fp);
}

$smarty->assign('tiki_p_map_delete', $tiki_p_map_delete);
if ((isset($_REQUEST["delete"])) && ($tiki_p_map_delete == 'y')) {
	$area = 'delmap';
	if ($feature_ticketlib2 != 'y' or (isset($_POST['daconfirm']) and isset($_SESSION["ticket_$area"]))) {
		key_check($area);
		if(!unlink($map_path.$_REQUEST["mapfile"])) {
			$smarty->assign('msg', tra("You do not have permission to delete the mapfile"));
			$smarty->display("error.tpl");  
			die;
		}
		$mode='listing';
	} else {
		key_get($area);
	}
}

if (isset($_REQUEST["save"])) {
if ($tiki_p_map_edit != 'y') {
	$smarty->assign('msg', tra("You do not have permission to use this feature"));
	$smarty->display("error.tpl");
	die;
}

  ini_set("display_errors","0");
	$fp = fopen($map_path.$_REQUEST["mapfile"], "w");
  ini_set("display_errors","1");
	if (!$fp) {
		$smarty->assign('msg', tra("You do not have permission to write to the mapfile"));

		$smarty->display("error.tpl");
		die;
	}

	fwrite($fp, $_REQUEST["pagedata"]);
	fclose ($fp);
	
	if ($feature_user_watches == 'y') {
	  $nots = $tikilib->get_event_watches('map_changed', $_REQUEST["mapfile"]);

	  foreach ($nots as $not) {

		     $smarty->assign('mail_site', $_SERVER["SERVER_NAME"]);

		     $smarty->assign('mail_page', $_REQUEST["mapfile"]);
		     $smarty->assign('mail_date', date("U"));
		     $smarty->assign('mail_user', $user);
		     $smarty->assign('mail_hash', $not['hash']);
		     $foo = parse_url($_SERVER["REQUEST_URI"]);
		     $machine = httpPrefix(). $foo["path"];
		     $smarty->assign('mail_machine', $machine);
		     $parts = explode('/', $foo['path']);

		     if (count($parts) > 1)
			      unset ($parts[count($parts) - 1]);

		     $smarty->assign('mail_machine_raw', httpPrefix(). implode('/', $parts));
		     $mail_data = $smarty->fetch('mail/user_watch_map_changed.tpl');
		     @mail($not['email'], tra('Map'). ' ' . $_REQUEST["mapfile"] . ' ' . tra('changed'), $mail_data, "From: ".$sender_email."\r\nContent-type: text/plain;charset=utf-8\r\n");
	  }
	}
	
}

if ((isset($_REQUEST["mapfile"])) && ($mode=='editing')) {
if ($tiki_p_map_edit != 'y') {
	$smarty->assign('msg', tra("You do not have permission to use this feature"));
	$smarty->display("error.tpl");
	die;
}
 $mapfile = $map_path .$_REQUEST["mapfile"];
  ini_set("display_errors","0"); 
	$fp = fopen($mapfile, "r");
  ini_set("display_errors","1");
	if (!$fp) {
		$smarty->assign('msg', tra("You do not have permission to read the mapfile"));
		$smarty->display("error.tpl");
		die;
	}

	$pagedata = fread($fp, filesize($mapfile));
	fclose ($fp);
	$smarty->assign('pagedata', $pagedata);
	$smarty->assign('mapfile', $_REQUEST["mapfile"]);
}

$smarty->assign('mode', $mode);

// Get mapfiles from the mapfiles directory
$files = array();
$h = opendir($map_path);

while (($file = readdir($h)) !== false) {
	if (preg_match('/\.map$/i', $file)) {
		$files[] = $file;
	}
}

closedir ($h);

sort ($files);
$smarty->assign('files', $files);
$smarty->assign('tiki_p_map_edit', $tiki_p_map_edit);

// Watches
if($feature_user_watches == 'y') {
	if($user && isset($_REQUEST['watch_event'])) {
	  if($_REQUEST['watch_action']=='add') {
	    $tikilib->add_user_watch($user,$_REQUEST['watch_event'],$_REQUEST['watch_object'],'Map',$_REQUEST['watch_object'],"tiki-map.phtml?mapfile=".$_REQUEST['watch_object']);
	  } else {
	    $tikilib->remove_user_watch($user,$_REQUEST['watch_event'],$_REQUEST['watch_object']);
	  }
	}

 $user_watching_map = array();
 foreach ($files as $key => $value) {
	  $user_watching_map[$key]='n';
	  if($user && $watch = $tikilib->get_user_event_watches($user,'map_changed',$value)) { 
		  $user_watching_map[$key]='y';
	  }
	}
	$smarty->assign('user_watching_map',$user_watching_map);
}	


$foo = parse_url($_SERVER["REQUEST_URI"]);
$foo1 = str_replace("tiki-map_edit.php", "tiki-map.phtml", $foo["path"]);
$smarty->assign('url_browse', httpPrefix(). $foo1);


include_once("textareasize.php");

include_once ('lib/quicktags/quicktagslib.php');
$quicktags = $quicktagslib->list_quicktags(0,-1,'taglabel_desc','','maps');
$smarty->assign_by_ref('quicktags', $quicktags["data"]);
$smarty->assign('quicktagscant', $quicktags["cant"]);

ask_ticket('edit-map');

// Get templates from the templates/modules directori
$smarty->assign('mid', 'map/tiki-map_edit.tpl');
$smarty->display("tiki.tpl");

?>

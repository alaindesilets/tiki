<?php

// $Header: /cvsroot/tikiwiki/tiki/tiki-mods.php,v 1.15 2007-03-17 21:56:33 niclone Exp $

// Copyright (c) 2002-2007, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

// Initialization
require_once ('tiki-setup.php');
include('lib/mods/modslib.php');

if ($tiki_p_admin != 'y') {
	$smarty->assign('msg', tra("You do not have permission to use this feature"));
	$smarty->display("error.tpl");
	die;
}

if (!is_dir($mods_dir)) {
	@mkdir($mods_dir,02777);
}

if (!is_writable($mods_dir)) {
	$smarty->assign('msg', tra("You need to run setup.sh :<br />./setup.sh \$APACHEUSER all<br />Common Apache users are www-data, apache or nobody"));
	$smarty->display("error.tpl");
	die;
}

if (!is_writable('tiki-index.php')) {
	$iswritable = false;
} else {
	$iswritable = true;
}
$smarty->assign('iswritable', $iswritable);

if (!is_dir($mods_dir."/Packages")) {
	mkdir($mods_dir."/Packages",02777);
}
if (!is_dir($mods_dir."/Installed")) {
	mkdir($mods_dir."/Installed",02777);
}
if (!is_dir($mods_dir."/Cache")) {
	mkdir($mods_dir."/Cache",02777);
}

$feedback=array();
function tikimods_feedback_listener($num, $err) {
    global $feedback;
    $feedback[]=array('num'=>$num, 'mes'=>$err);
}
$modslib->add_feedback_listener('tikimods_feedback_listener');

if (isset($_REQUEST['find']) and trim($_REQUEST['find'])) {
	$findarg = '&amp;find='. urlencode($_REQUEST['find']);
	$find = $_REQUEST['find'];
} else {
	$findarg = $find = '';
}
$smarty->assign('findarg', $findarg);
$smarty->assign('find', $find);

if (isset($_REQUEST['type']) and trim($_REQUEST['type'])) {
	$typearg = '&amp;type='. urlencode($_REQUEST['type']);
	$type = $_REQUEST['type'];
} else {
	$type = $typearg = '';
}
$smarty->assign('typearg', $typearg);
$smarty->assign('type', $type);

if ($feature_mods_provider == 'y') {
	if (!is_dir($mods_dir."/Dist")) {
	  mkdir($mods_dir."/Dist",02777);
	}
	if (!is_file($mods_dir."/Packages/00_list.public.txt")) {
		touch($mods_dir."/Packages/00_list.public.txt");
	}

	$public = $modslib->read_list($mods_dir."/Packages/00_list.public.txt",'remote',$type,$find,false);

	if (isset($_REQUEST['republish'])) {
		$modslib->unpublish($mods_dir,array($_REQUEST['republish']));
		$modslib->publish($mods_dir,array($_REQUEST['republish']));
	} elseif (isset($_REQUEST['republishall'])) {
		$items=$modslib->read_list($mods_dir."/Packages/00_list.txt",'local',$type,$find,true);
		$modslib->unpublish($mods_dir, $items);
		$modslib->publish($mods_dir, $items);
	} elseif (isset($_REQUEST['publish'])) {
		$modslib->publish($mods_dir,array($_REQUEST['publish']));
	} elseif (isset($_REQUEST['publishall'])) {
		$modslib->publish($mods_dir, $modslib->read_list($mods_dir."/Packages/00_list.txt",'local',$type,$find,true));
	} elseif (isset($_REQUEST['unpublish'])) {
		$modslib->unpublish($mods_dir,array($_REQUEST['unpublish']));
	} elseif (isset($_REQUEST['unpublishall'])) {
		$items=$modslib->read_list($mods_dir."/Packages/00_list.public.txt",'public',$type,$find,true);
		$modslib->unpublish($mods_dir,$items);
	}
	$smarty->assign('public', $public);
}

if (isset($_REQUEST['dl'])) {
        if(!function_exists("gzinflate")) {
	    $smarty->assign('msg',tra("Your PHP installation does not have zlib enabled."));
	    $smarty->display('error.tpl');
	    die;
	}
	$modslib->dl_remote($mods_server,$_REQUEST['dl'],$mods_dir);
	$modslib->rebuild_list($mods_dir."/Packages");
}

if (!is_file($mods_dir."/Packages/00_list.txt") or isset($_REQUEST['rebuild'])) {
	$modslib->rebuild_list($mods_dir."/Packages");
	$modslib->rebuild_list($mods_dir."/Installed");
}

if ($mods_server) {
	if (!is_file($mods_dir."/Packages/00_list.". urlencode($mods_server) .".txt")) {
		touch($mods_dir."/Packages/00_list.". urlencode($mods_server) .".txt");
		$_REQUEST['reload'] = true;
	}
	if (isset($_REQUEST['reload'])) {
		$modslib->refresh_remote($mods_server."/Packages/00_list.public.txt",$mods_dir."/Packages/00_list.". urlencode($mods_server). ".txt");
	}
}

if (isset($_REQUEST['package'])) {
	$packtype = substr($_REQUEST['package'],0,strpos($_REQUEST['package'],'-'));
	$package = substr($_REQUEST['package'],strpos($_REQUEST['package'],'-')+1);	
	$smarty->assign('packtype', $packtype);
	$smarty->assign('package', $package);
}

if (isset($_REQUEST['action']) and isset($package) and $iswritable) {
	if ($_REQUEST['action'] == 'configuration') {
		$mod = new TikiModInfo($packtype, $package);
		$mod->writeconf($mods_dir, $_REQUEST['conf']);
		$_REQUEST['action'] = 'upgrade';
	}
	if ($_REQUEST['action'] == 'remove') {
		$deps=$modslib->find_deps_remove($mods_dir, $mods_server, array($packtype.'-'.$package));
		$smarty->assign('installask', $deps);
	} elseif (($_REQUEST['action'] == 'install') || ($_REQUEST['action'] == 'upgrade')) {
		$deps=$modslib->find_deps($mods_dir, $mods_server, array($packtype.'-'.$package));
		$smarty->assign('installask', $deps);
	}
} elseif (isset($_REQUEST['button-install'])) {
	$deps=$modslib->find_deps($mods_dir, $mods_server, $_REQUEST['install-wants']);
	$modslib->install_with_deps($mods_dir, $mods_server, $deps);
} elseif (isset($_REQUEST['button-remove'])) {
	$deps=$modslib->find_deps_remove($mods_dir, $mods_server, $_REQUEST['install-wants']);
	$modslib->remove_with_deps($mods_dir, $mods_server, $deps);
}

$local = $modslib->read_list($mods_dir."/Packages/00_list.txt",'local',$type,$find,false);
$smarty->assign('local', $local);

$remote = $modslib->read_list($mods_dir."/Packages/00_list.". urlencode($mods_server).".txt",'remote',$type,$find,false);
$smarty->assign('remote', $remote);

$installed = $modslib->read_list($mods_dir."/Installed/00_list.txt",'installed',$type,$find,false);
$smarty->assign('installed', $installed);
//var_dump($local);
// var_dump($remote);
// var_dump($installed);

if ($feature_mods_provider == 'y') {
	$public = $modslib->read_list($mods_dir."/Packages/00_list.public.txt",'public',$type,$find,false);
	$smarty->assign('public', $public);
	$dist = $modslib->scan_dist($mods_dir."/Dist");
	$smarty->assign('dist', $dist);
}

$types = $modslib->types;
$display = array();

if ($type) {
        if (!isset($local[$type])) $local[$type] = array();
	if (!isset($remote[$type])) $remote[$type] = array();

	$display[$type] = array_merge($local[$type],$remote[$type]);
} else {
	foreach ($types as $t=>$tt) {
		if (isset($local[$t])) {
			if (isset($remote[$t])) {
				$display[$t] = array_merge($local[$t],$remote[$t]);
			} else {
				$display[$t] = $local[$t];
			}
		} elseif (isset($remote[$t])) {
			$display[$t] = $remote[$t];
		}
	}
}
$smarty->assign('display', $display);

if (isset($_REQUEST['focus'])) {
	$focus = $_REQUEST['focus'];
	$more = new TikiModInfo($focus);
	$err=$more->readinfo($mods_dir.'/Packages/'.$focus.'.info.txt');
	if ($err !== false) die($err);
} else {
	$focus = false;
	$more = array();
}

$smarty->assign('focus', $focus);
$smarty->assign('more', $more);
$smarty->assign('tikifeedback', $feedback);
$smarty->assign('types', $types);

$smarty->assign('mid', 'tiki-mods.tpl');
$smarty->display("tiki.tpl");

?>

<?php

// $Header: /cvsroot/tikiwiki/tiki/lib/setup/absolute_urls.php,v 1.2 2007-10-10 13:30:52 sept_7 Exp $
// Copyright (c) 2002-2005, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for
// details.

//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER['SCRIPT_NAME'],'tiki-setup.php')!=FALSE) {
  header('location: index.php');
  exit;
}

/* Automatically set params used for absolute URLs - BEGIN */

$tmp = dirname(str_replace(dirname(dirname(dirname(__FILE__))),'',$_SERVER['SCRIPT_FILENAME']));
if ($tmp != '/') {
	$dir_level = substr_count($tmp,"/");
} else {
	$dir_level = 0;
}                                                                               
unset($tmp);

$tikiroot = dirname($_SERVER['PHP_SELF']);
$tikipath = dirname($_SERVER['SCRIPT_FILENAME']);

if ($dir_level > 0) {
	$tikiroot = preg_replace('#(/[^/]+){'.$dir_level.'}$#','',$tikiroot);
	$tikipath = preg_replace('#(/[^/]+){'.$dir_level.'}$#','',$tikipath);
	chdir(join('../',array_fill(0,$dir_level+1,'')));
}

if ( substr($tikiroot,-1,1) != '/' ) $tikiroot .= '/';
if ( substr($tikipath,-1,1) != '/' ) $tikipath .= '/';

if ( $https_port == 443 ) $https_port = '';
if ( $http_port == 80 ) $http_port = '';

// Detect if we are in HTTPS / SSL mode.
//
// Since $_SERVER['HTTPS'] will not be set on some installation, we may need to check port also.
//
// 'force_nocheck' option is used to set all absolute URI to https, but without checking if we are in https
//    This is useful in certain cases.
//    For example, this allow to have full HTTPS when using an entrance proxy that will use HTTPS connection with the client browser, but use an HTTP only connection to the server that hosts tikiwiki.
// 
$https_mode = false;
if ( ( isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on' )
	|| ( $https_port == '' && $_SERVER['SERVER_PORT'] == 443 )
	|| ( $https_port > 0 && $_SERVER['SERVER_PORT'] == $https_port )
	|| $https_login == 'force_nocheck'
) $https_mode = true;

$url_scheme = $https_mode ? 'https' : 'http';
$url_host = (isset($_SERVER['SERVER_NAME'])) ? $_SERVER['SERVER_NAME']  : $_SERVER['HTTP_HOST'];
$url_port = $https_mode ? $https_port : $http_port;
$url_path = $tikiroot;
$base_host = $url_scheme.'://'.$url_host.(($url_port!='')?":$url_port":'');
$base_url = $url_scheme.'://'.$url_host.(($url_port!='')?":$url_port":'').$url_path;
$base_url_http = 'http://'.$url_host.(($http_port!='')?":$http_port":'').$url_path;
$base_url_https = 'https://'.$url_host.(($https_port!='')?":$https_port":'').$url_path;

// SSL options

if ( isset($_REQUEST['stay_in_ssl_mode']) ) {
	// We stay in HTTPS / SSL mode if 'stay_in_ssl_mode' has an 'y' or 'on' value
	$stay_in_ssl_mode = ( $_REQUEST['stay_in_ssl_mode'] == 'y' || $_REQUEST['stay_in_ssl_mode'] == 'on' ) ? 'y' : 'n';
} else {
	// Set default value of 'stay_in_ssl_mode' to the current mode state
	$stay_in_ssl_mode = $https_mode ? 'y' : 'n';
}

// Show the 'Stay in SSL mode' checkbox only if we are already in HTTPS
$show_stay_in_ssl_mode = $https_mode ? 'y' : 'n';

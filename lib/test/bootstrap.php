<?php

require_once(dirname(__FILE__) . '/TikiTestCase.php');

ini_set( 'display_errors', 'on' );
error_reporting( E_ALL & ~E_DEPRECATED);

ini_set( 'include_path', ini_get('include_path') . PATH_SEPARATOR . "." . PATH_SEPARATOR . "../core/lib" . PATH_SEPARATOR . "../.." . PATH_SEPARATOR . "core");

function tra( $string ) {
	return $string;
}

function __autoload( $name ) {
	$path = str_replace( '_', '/', $name );
	require_once( $path . '.php' );
}

$tikidomain = '';
$api_tiki = null;
require 'db/local.php';

if (extension_loaded("pdo") and $api_tiki == 'pdo' ) {
	require_once('db/tiki-db-pdo.php');
} else {
	require_once('db/tiki-db-adodb.php');
}

$db = TikiDb::get();
$db->setServerType( $db_tiki );

$pwd = getcwd();
chdir( dirname(__FILE__) . '/../..' );
require_once 'lib/cache/cachelib.php';
require_once 'lib/tikilib.php';
require_once 'lib/userslib.php';
$tikilib = new TikiLib;
$userlib = new UsersLib;
$_SESSION = array(
	'u_info' => array(
		'login' => null
	)
);
chdir($pwd);
require_once 'lib/setup/prefs.php';


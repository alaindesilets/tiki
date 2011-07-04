<?php

require_once('lib/language/CollectFiles.php');
require_once('lib/language/FileType.php');
require_once('lib/language/FileType/Php.php');
require_once('lib/language/FileType/Tpl.php');
require_once('lib/language/GetStrings.php');
require_once('lib/language/WriteFile.php');

require_once('lib/setup/timer.class.php');

$timer = new timer();
$timer->start();

$getStrings = new Language_GetStrings(new Language_CollectFiles, new Language_WriteFile);

if (isset($_GET['lang']) && !empty($_GET['lang'])) {
	$getStrings->setLanguages($_GET['lang']);
}

$getStrings->addFileType(new Language_FileType_Php);
$getStrings->addFileType(new Language_FileType_Tpl);

// skip the following directories 
$getStrings->collectFiles->setExcludeDirs(array(
	'./dump' , './img', './lang', './lib/adodb', './lib/ckeditor',
	'./lib/codemirror', './lib/core/Zend', './lib/ezcomponents',
	'./lib/htmlpurifier', './lib/jquery', './lib/jscalendar', './lib/pclzip',
	'./lib/pear', './lib/phpcas', './lib/smarty', './lib/test',	'./temp',
	'./temp/cache',	'./templates_c'
));

$getStrings->collectFiles->setIncludeFiles(array(
	'./lang/langmapping.php', './img/flags/flagnames.php'
));

$getStrings->run();

echo "\nTotal time spent: " . $timer->stop() . " seconds\n";
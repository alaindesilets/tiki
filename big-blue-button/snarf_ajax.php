<?php
// (c) Copyright 2002-2010 by authors of the Tiki Wiki/CMS/Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id: tiki-webmail_ajax.php 25467 2010-02-21 16:45:47Z jonnybradley $

require_once ('tiki-setup.php');
include_once('lib/wiki-plugins/wikiplugin_snarf.php');

echo wikiplugin_snarf('', $_REQUEST);

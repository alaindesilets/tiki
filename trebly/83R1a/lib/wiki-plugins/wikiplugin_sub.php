<?php
// (c) Copyright 2002-2011 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id: wikiplugin_sub.php 36213 2011-08-16 00:55:32Z marclaporte $

function wikiplugin_sub_info() {
	return array(
		'name' => tra( 'Subscript' ),
		'documentation' => 'PluginSub',
		'description' => tra('Apply subscript font to text'),
		'prefs' => array( 'wikiplugin_sub' ),
		'body' => tra('text'),
		'icon' => 'pics/icons/text_subscript.png',
		'tags' => array( 'basic' ),
		'params' => array(
		),
	);
}

function wikiplugin_sub($data, $params)
{
        global $tikilib;

        extract ($params,EXTR_SKIP);
	return "<sub>$data</sub>";
}

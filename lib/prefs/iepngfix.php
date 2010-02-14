<?php
// (c) Copyright 2002-2010 by authors of the Tiki Wiki/CMS/Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

function prefs_iepngfix_list() {
	return array(
		'iepngfix_selectors' => array(
			'name' => 'CSS selectors to be fixed',
			'type' => 'text',
			'size' => '30',
			'hint' => tra('Separate multiple elements with a comma (,)'),
		),
		'iepngfix_elements' => array(
			'name' => 'HTMLDomElements to be fixed',
			'type' => 'text',
			'size' => '30',
			'hint' => tra('Separate multiple elements with a comma (,)'),
		),
	);	
}

<?php
// (c) Copyright 2002-2011 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

function prefs_geo_list()
{
	return array(
		'geo_locate_wiki' => array(
			'name' => tra('Geolocate wiki pages'),
			'description' => tra('Provide controls to geolocate wiki pages from the edit functionality.'),
			'type' => 'flag',
			'default' => 'n',
		),
		'geo_locate_article' => array(
			'name' => tra('Geolocate articles'),
			'description' => tra('Provide controls to geolocate articles from the edit functionality.'),
			'type' => 'flag',
			'default' => 'n',
		),
		'geo_locate_blogpost' => array(
			'name' => tra('Geolocate blog posts'),
			'description' => tra('Provide controls to geolocate blog posts from the edit functionality.'),
			'type' => 'flag',
			'default' => 'n',
		),
		'geo_tilesets' => array(
			'name' => tra('Available tile layers on maps'),
			'description' => tra('Allows to replace the default OpenStreetMap tiles for tiles from other mapping services, such as Google, Yahoo or Bing.'),
			'hint' => tr('Valid options are: %0', implode(', ', array(
				'openstreetmap',
				'openaerialmap',
				'google_street',
				'google_satellite',
				'google_physical',
				'google_hybrid',
				/* Needs additional testing
				'visualearth_road',
				'visualearth_aerial',
				'visualearth_hybrid',
				'yahoo_street',
				'yahoo_satellite',
				'yahoo_hybrid',
				*/
			))),
			'type' => 'text',
			'filter' => 'word',
			'separator' => ',',
			'default' => array('openstreetmap'),
		),
	);
}


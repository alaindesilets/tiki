<?php

function prefs_session_list() {
	return array (
		'session_storage' => array(
			'name' => tra('Session storage location'),
			'description' => tra('Select where the session information should be stored. Memcache sessions require memcache to be configured.'),
			'type' => 'list',
			'perspective' => false,
			'options' => array(
				'default' => tra('Default (from php.ini)'),
				'db' => tra('Database'),
				'memcache' => tra('Memcache'),
			),
		),
		'session_lifetime' => array(
			'name' => tra('Session lifetime'),
			'description' => tra('Session lifetime'),
			'hint' => tra('Value provided in minutes'),
			'type' => 'text',
			'filter' => 'digits',
			'perspective' => false,
			'size' => '4',
		),
		'session_silent' => array(
			'name' => tra('Silent session'),
			'description' => tra('Do not automatically start sessions.'),
			'perspective' => false,
			'type' => 'flag',
		),
		'session_cookie_name' => array(
			'name' => tra('Session cookie name'),
			'description' => tra('Session cookie name used instead of the PHP default configuration.'),
			'type' => 'text',
			'perspective' => false,
			'size' => 10,
		),
	);
}

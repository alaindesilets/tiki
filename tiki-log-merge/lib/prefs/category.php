<?php

function prefs_category_list() {
	return array(
		'category_jail' => array(
			'name' => tra('Category Jail'),
			'description' => tra('Limits the visibility of objects to those in these categories. Used mainly for creating workspaces from perspectives.'),
			'separator' => ',',
			'type' => 'text',
			'filter' => 'int',
		),
		'category_defaults' => array(
			'name' => tra('Category Defaults'),
			'description' => tra('Force certain categories to be present. If none of the categories in a given set are provided, assign a category by default.'),
			'type' => 'textarea',
			'filter' => 'striptags',
			'hint' => tra('One per line. ex:1,4,6,7/4'),
			'size' => 5,
			'serialize' => 'prefs_category_serialize_defaults',
			'unserialize' => 'prefs_category_unserialize_defaults',
		),
		'category_i18n_sync' => array(
			'name' => tra('Syncronize multilingual categories'),
			'description' => tra('Make sure that the categories on the translations are synchronized when modified on any version.'),
			'type' => 'list',
			'dependencies' => array( 'feature_multilingual' ),
			'options' => array(
				'' => tra('None'),
				'whitelist' => tra('Only those specified'),
				'blacklist' => tra('All but those specified'),
			),
		),
		'category_i18n_synced' => array(
			'name' => tra('Synchronized categories'),
			'description' => tra('List of categories affected by the multilingual synchronization. Depending on the parent feature, this list will be used as a white list (only categories allows) or as a black list (all except thoses specified)'),
			'type' => 'text',
			'filter' => 'digits',
			'separator' => ',',
		),
	);
}

function prefs_category_serialize_defaults( $data ) {
	if( ! is_array( $data ) ) {
		$data = unserialize( $data );
	}

	$out = '';
	foreach( $data as $row ) {
		$out .= implode( ',', $row['categories'] ) . '/' . $row['default'] . "\n";
	}

	return trim( $out );
}

function prefs_category_unserialize_defaults( $string ) {
	$data = array();
	
	foreach( explode( "\n", $string ) as $row ) {
		if( preg_match('/^\s*(\d+\s*(,\s*\d+\s*)*)\/\s*(\d+)\s*$/', $row, $parts ) ) {
			$categories = explode( ',', $parts[1] );
			$categories = array_map( 'trim', $categories );
			$categories = array_filter( $categories );
			$default = $parts[3];

			$data[] = array(
				'categories' => $categories,
				'default' => $default,
			);
		}
	}

	if( count( $data ) ) {
		return $data;
	} else {
		return false;
	}
}


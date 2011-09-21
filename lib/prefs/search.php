<?php
// (c) Copyright 2002-2011 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

function prefs_search_list() {
	global $prefs;
	return array (
		'search_refresh_index_mode' => array(
			'name' => tra('Refresh mode'),
			'type' => 'list',
			'perspective' => false,
			'options' => array(
				'normal' => tra('Normal'),
				'random' => tra('Random'),
			),
			'default' => 'normal',
		),
		'search_refresh_rate' => array(
			'name' => tra('Refresh rate'),
			'hint' => tra('Use 0 for no refresh'),
			'type' => 'text',
			'size' => '4',
			'perspective' => false,
			'default' => '5',
		),
		'search_min_wordlength' => array(
			'name' => tra('Minimum length of search word'),
			'type' => 'text',
			'size' => '4',
			'perspective' => false,
			'default' => '3',
		),
		'search_max_syllwords' => array(
			'name' => tra('Max. number of words containing a syllable'),
			'type' => 'text',
			'size' => '4',
			'perspective' => false,
			'default' => '100',
		),
		'search_syll_age' => array(
			'name' => tra('Max. age in hours of syllable search cache'),
			'type' => 'text',
			'size' => '4',
			'perspective' => false,
			'default' => '48',
		),
		'search_lru_purge_rate' => array(
			'name' => tra('LRU list purging rate'),
			'type' => 'text',
			'size' => '4',
			'perspective' => false,
			'default' => '5',
		),
		'search_lru_length' => array(
			'name' => tra('LRU list length'),
			'type' => 'text',
			'size' => '4',
			'perspective' => false,
			'default' => '100',
		),
		'search_parsed_snippet' => array(
			'name' => tra('Parse the results'),
			'hint' => tra('May impact performance'),
			'type' => 'flag',
			'default' => 'y',
			'dbfeatures' => array('mysql_fulltext'),
		),
		'search_default_where' => array(
			'name' => tra('Default where'),
			'description' => tra('When object filter is not on, limit to search one type of object'),
			'type' => 'list',
			'options' => isset($prefs['feature_search_fulltext']) && $prefs['feature_search_fulltext'] === 'y' ?
					array(
						'' => tra('Entire site'),
						'wikis' => tra('Wiki Pages'),
						'trackers' => tra('Trackers'),
					) : array(
						'' => tra('Entire site'),
						'wiki page' => tra('Wiki Pages'),
						'blog post' => tra('Blog Posts'),
						'article' => tra('Articles'),
						'file' => tra('Files'),
						'forum post' => tra('Forums'),
						'trackeritem' => tra('Tracker Items'),
						'sheet' => tra('Spreadsheets'),
					),
			'default' => '',
		),
		'search_default_interface_language' => array(
			'name' => tra('Restrict search language by default'),
			'description' => tra('If enabled, only search content in the interface language, by default.'),
			'type' => 'flag',
			'default' => 'n',
		),
		'search_autocomplete' => array(
			'name' => tra('Autocomplete on page names'),
			'type' => 'flag',
			'dependencies' => array('feature_jquery_autocomplete', 'javascript_enabled'),
			'default' => 'n',
		),
		'search_forum_deepindexing' => array(
			'name' => tra('Index forum replies together with root post'),
			'description' => tra('If enabled, forum replies will be indexed together with the root post as a single document instead of being separately indexed'),
			'type' => 'flag',
			'default' => 'y',
		), 
	);
}

<?php
  // $header: $
//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}

/*
PhpLayers in tikiwiki !

That smarty function is mostly intended to be used in .tpl files
syntax: {phplayers [type=tree|phptree|plain|hort|vert] [id=1] [file=/path/to/menufile]}

*/
function smarty_function_phplayers($params, &$smarty) {
	if (empty($params)) return '';

	global $prefs, $tikiphplayers;
	include_once('lib/phplayers_tiki/tiki-phplayers.php');

	if ($prefs['feature_phplayers'] != 'y') {
		return tra("phplayers are not available on this site");
	}

	if (empty($params['type'])) {
		$params['type'] = 'tree';
	}
	if (!isset($params['sectionLevel'])) {
		$params['sectionLevel'] = '';
	}
	if (!isset($params['translate'])) {
		$params['translate'] = 'y';
	}

	$use_items_icons = false;
	if (!empty($params['id'])) {
		$params['output'] = $tikiphplayers->mkMenuEntry(
			$params['id'],
			$params['curOption'],
			$params['sectionLevel'],
			$params['translate'],
			$use_items_icons // Passed by reference to change the value
		);
	}
	if (!isset($params['file'])) {
		$params['file'] = '';
	}

	$return = $tikiphplayers->mkMenu($params['output'], 'usermenu'.$params['id'], $params['type'], $params['file'], $params['curOption']);
	if ( $use_items_icons ) $return = str_replace('class="mdkverbar"', 'class="mdkverbar mdkverbar-with-icons"', $return);

	return '<div role="navigation">' . $return . '</div>';
}

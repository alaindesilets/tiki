<?php

function smarty_function_preference( $params, $smarty ) {
	global $prefslib, $prefs; require_once 'lib/prefslib.php';
	if( ! isset( $params['name'] ) ) {
		return tra( 'Preference name not specified.' );
	}

	$source = null;
	if( isset( $params['source'] ) ) {
		$source = $params['source'];
	}
	$get_pages = isset( $params['get_pages']) && $params['get_pages'] != 'n' ? true : false;

	if( $info = $prefslib->getPreference( $params['name'], true, $source, $get_pages ) ) {
		if( isset($params['label']) ) {
			$info['name'] = $params['label'];
		}
		if (isset($params['default'])) {// use for site_language
			$info['value'] = $params['default'];
		}

		if ($get_pages) {
			if (count($info['pages']) > 0) {
			$pages_string = tra(' (found in ');
			foreach($info['pages'] as $pg) {
				$pages_string .= '<a class="lm_result" href="tiki-admin.php?page='.$pg.'">' . $pg . '</a>, ';
			}
			$pages_string = substr($pages_string, 0, strlen($pages_string) - 2);
			$pages_string .= ')';
			} else {
				$pages_string = tra('Not found');
			}
		} else {
			$pages_string = '';
		}
		$info['pages'] = $pages_string;

		$smarty->assign( 'p', $info );

		if( isset( $params['mode'] ) && $params['mode'] == 'invert' ) {
			$smarty->assign( 'mode', 'invert' );
		} else {
			$smarty->assign( 'mode', 'normal' );
		}
		
		return $smarty->fetch( 'prefs/' . $info['type'] . '.tpl' );
	} else {
		return tr( 'Preference %0 is not defined.', $params['name'] );
	}
}

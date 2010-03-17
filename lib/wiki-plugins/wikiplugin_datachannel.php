<?php
// (c) Copyright 2002-2010 by authors of the Tiki Wiki/CMS/Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

function wikiplugin_datachannel_info()
{
	return array(
		'name' => tra('Data Channel'),
		'description' => tra('Displays a form to trigger data channels.'),
		'prefs' => array('wikiplugin_datachannel'),
		'body' => tra('List of fields to display. One field per line. Comma delimited: fieldname,label'),
		'extraparams' => true,
		'params' => array(
			'channel' => array(
				'required' => true,
				'name' => tra('Channel Name'),
				'description' => tra('Name of the channel as registered by the administrator.'),
			),
			'returnURI' => array(
				'required' => false,
				'name' => tra('Return URI'),
				'description' => tra('URI to go to after data channel has run. Defaults to current page.'),
				'filter' => 'pagename',
			),
			'buttonLabel' => array(
				'required' => false,
				'name' => tra('Button Label'),
				'description' => tra('Label for the submit button. Default: "Go".'),
			),
			'class' => array(
				'required' => false,
				'name' => tra('Class'),
				'description' => tra('CSS class for this form'),
			),
			'debug' => array(
				'required' => false,
				'name' => tra('Debug'),
				'description' => '(y | n) '.tra('Be careful, if debug is on, the page will not be refreshed and previous modules can be obsolete'),
				'default' => 'n',
				'filter' => 'word',
			),
		),
	);
}

function wikiplugin_datachannel( $data, $params )
{
	static $execution = 0;
	global $prefs, $smarty;
	$executionId = 'datachannel-exec-' . ++$execution;

	$fields = array();
	$lines = explode( "\n", $data );
	$lines = array_map( 'trim', $lines );
	$lines = array_filter( $lines );

	foreach( $lines as $line ) {
		$parts = explode( ',', $line, 2 );

		if( count($parts) == 2 ) {
			$fields[ $parts[0] ] = $parts[1];
		}
	}

	require_once 'lib/profilelib/profilelib.php';
	require_once 'lib/profilelib/channellib.php';
	require_once 'lib/profilelib/installlib.php';

	$groups = Perms::get()->getGroups();

	$config = Tiki_Profile_ChannelList::fromConfiguration( $prefs['profile_channels'] );
	if( $config->canExecuteChannels( array( $params['channel'] ), $groups ) ) {
		if( $_SERVER['REQUEST_METHOD'] == 'POST' 
			&& isset( $_POST['datachannel_execution'] ) 
			&& $_POST['datachannel_execution'] == $executionId ) {

			$input = array_intersect_key( $_POST, $fields );
			$static = $params;
			unset( $static['channel'] );

			$userInput = array_merge( $input, $static );

			Tiki_Profile::useUnicityPrefix(uniqid());
			$installer = new Tiki_Profile_Installer;
			//TODO: What is the following line for? Future feature to limit capabilities of data channels?
			//$installer->limitGlobalPreferences( array() );

			$profiles = $config->getProfiles( array( $params['channel'] ) );
			$profile = reset($profiles);

			$installer->setUserData( $userInput );
			if (empty($params['debug']) || $params['debug'] != 'y') {
				$installer->setDebug();
			}
			$installer->install( $profile );

			if (empty($params['returnURI'])) { $params['returnURI'] = $_SERVER['HTTP_REFERER']; }	// default to return to same page
			if (empty($params['debug']) || $params['debug'] != 'y') {
				header( 'Location: ' . $params['returnURI'] );
				die;
			}
			$smarty->assign('datachannel_feedbacks', array_merge($installer->getFeedback(), $profile->getFeedback()) );
		}
		$smarty->assign( 'datachannel_fields', $fields );
		$smarty->assign( 'datachannel_execution', $executionId );
		$smarty->assign( 'button_label', !empty($params['buttonLabel']) ? $params['buttonLabel'] : 'Go');
		$smarty->assign( 'form_class_attr', !empty($params['class']) ? ' class="' . $params['class'] . '"' : '');
		
		return '~np~' . $smarty->fetch( 'wiki-plugins/wikiplugin_datachannel.tpl' ) . '~/np~';
	}
}

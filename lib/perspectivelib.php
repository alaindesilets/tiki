<?php

class PerspectiveLib
{
	// Returns a string-indexed array containing the preferences for the given perspective as "pref_name" => "pref_value".
	function get_preferences( $perspectiveId ) {
		$result = TikiDb::get()->query( "SELECT pref, value FROM tiki_perspective_preferences WHERE perspectiveId = ?", array( $perspectiveId ) );

		$out = array();

		while( $row = $result->fetchRow() ) {
			$out[ $row['pref'] ] = $row['value'];
		}

		return $out;
	}

	// Adds or renames a perspective. If $perspectiveId exists, rename it to $name. Otherwise, create a new perspective with id $perspectiveId named $name.
	// Returns true if and only if the operation succeeds.
	function replace_perspective( $perspectiveId, $name ) {
		$db = TikiDb::get();

		if( $perspectiveId ) {
			$db->query( 'UPDATE tiki_perspectives SET name = ? WHERE perspectiveId = ?', 
				array( $name, $perspectiveId ) );

			return $perspectiveId;
		} else {
			$db->query( 'INSERT INTO tiki_perspectives ( name ) VALUES( ? )',
				array( $name ) );

			$max = $db->getOne( 'SELECT MAX(perspectiveId) FROM tiki_perspectives' );
			return $max;
		}
	}
	
	//Removes a perspective. 
	function remove_perspective ( $perspectiveId )
	{
		$db = TikiDb::get();
		
		if ( $perspectiveId )
		{
			$db->query( 'DELETE from tiki_perspectives WHERE WHERE perspectiveId = ?', array( $perspectiveId ) );
			$db->query( 'DELETE from tiki_perspective_preferences WHERE perspectiveId = ?', array( $perspectiveId ) );
		}
		
		return true;
	}

	// Replaces all preferences from $perspectiveId with those in the provided string-indexed array (in format "pref_name" => "pref_value").
	function replace_preferences( $perspectiveId, $preferences ) {
		$db = TikiDb::get();
		$db->query( 'DELETE FROM tiki_perspective_preferences WHERE perspectiveId = ?',
			array( $perspectiveId ) );

		foreach( $preferences as $pref => $value ) {
			$this->set_preference( $perspectiveId, $pref, $value );
		}
	}

	// Sets $preference's value for $perspectiveId to $value.
	function set_preference( $perspectiveId, $preference, $value ) {
		$db = TikiDb::get();

		$db->query( 'DELETE FROM tiki_perspective_preferences WHERE perspectiveId = ? AND pref = ?',
			array( $perspectiveId, $preference ) );
		$db->query( 'INSERT INTO tiki_perspective_preferences ( perspectiveId, pref, value ) VALUES( ?, ?, ? )',
			array( $perspectiveId, $preference, $value ) );
	}

	// Returns true if and only if a perspective with the given $perspectiveId exists.
	function perspective_exists( $perspectiveId ) {
		$db = TikiDb::get();

		$id = $db->getOne( 'SELECT perspectiveId FROM tiki_perspectives WHERE perspectiveId = ?',
			array( $perspectiveId ) );
		
		return ! empty( $id );
	}

	function list_perspectives() {
		$db = TikiDb::get();

		$list = $db->fetchAll( "SELECT perspectiveId, name FROM tiki_perspectives" );

		$list = Perms::filter( array( 'type' => 'perspective' ), 'object', $list, array( 'object' => 'perspectiveId' ), 'perspective_view' );
		return $list;
	}

	//Returns a list of perspectives with the given name, filtered by perms
	function get_perspectives_with_given_name ( $name ) {
	    $db = TikiDb::get();

	    $list = $db->query( "SELECT perspectiveId, name FROM tiki_perspectives WHERE name = ?", array ( $name ) );

	    $list = Perms::filter( array ( 'type' => 'perspective'), 'object', $list, array( 'object' => 'perspectiveId' ), 'perspective_view' );

	    return $list;
	}
}

global $perspectivelib;
$perspectivelib = new PerspectiveLib;

?>

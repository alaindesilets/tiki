<?php
// (c) Copyright 2002-2010 by authors of the Tiki Wiki/CMS/Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id: attributelib.php 25339 2010-02-18 08:28:32Z changi67 $

class RelationLib extends TikiDb_Bridge
{
	/**
	 * Obtains the list of relations with a given object as the source.
	 * Optionally, the relation searched for can be specified. If the 
	 * relation ends with a dot, it will be used as a wildcard.
	 */
	function get_relations_from( $type, $object, $relation = null ) {
		$cond = array( 'source_type = ?', 'source_itemId = ?' );
		$vars = array( $type, $object );

		$this->apply_relation_condition( $relation, $cond, $vars );

		return $this->fetchAll( 'SELECT `relationId`, `relation`, `target_type` `type`, `target_itemId` `itemId` FROM `tiki_object_relations` WHERE ' . implode( ' AND ', $cond ), $vars );
	}

	function get_relations_to( $type, $object, $relation = null ) {
		$cond = array( 'target_type = ?', 'target_itemId = ?' );
		$vars = array( $type, $object );

		$this->apply_relation_condition( $relation, $cond, $vars );

		return $this->fetchAll( 'SELECT `relationId`, `relation`, `source_type` `type`, `source_itemId` `itemId` FROM `tiki_object_relations` WHERE ' . implode( ' AND ', $cond ), $vars );
	}

	/**
	 * The relation must contain at least two dots and only lowercase letters.
	 */
	function add_relation( $relation, $src_type, $src_object, $target_type, $target_object ) {
		$relation = TikiFilter::get( 'attribute_type' )
			->filter( $relation );

		if( $relation ) {
			$data = array( $relation, $src_type, $src_object, $target_type, $target_object );

			$this->query( 'DELETE FROM `tiki_object_relations` WHERE `relation` = ? AND `source_type` = ? AND `source_itemId` = ? AND `target_type` = ? AND `target_itemId` = ?', $data );
			$this->query( 'INSERT INTO `tiki_object_relations` (`relation`, `source_type`, `source_itemId`, `target_type`, `target_itemId`) VALUES(?,?,?,?,?)', $data );

			return $this->lastInsertId();
		}
	}

	function get_relation( $id ) {
		$result = $this->fetchAll( 'SELECT * FROM `tiki_object_relations` WHERE `relationId` = ?', array( $id ) );
		return reset( $result );
	}

	function remove_relation( $id ) {
		$this->fetchAll( 'DELETE FROM `tiki_object_relations` WHERE `relationId` = ?', array( $id ) );
	}

	private function apply_relation_condition( $relation, & $cond, & $vars ) {
		$relation = TikiFilter::get( 'attribute_type' )
			->filter( $relation );

		if( $relation ) {
			if( substr( $relation, -1 ) == '.' ) {
				$relation .= '%';
			}

			$cond[] = 'relation LIKE ?';
			$vars[] = $relation;
		}
	}
}

global $relationlib;
$relationlib = new RelationLib;

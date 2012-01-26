<?php
// (c) Copyright 2002-2011 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id: AdvancedRatingSource.php 33195 2011-03-02 17:43:40Z changi67 $

class Search_GlobalSource_AdvancedRatingSource implements Search_GlobalSource_Interface
{
	private $ratinglib;
	private $fields = null;

	function __construct()
	{
		$this->ratinglib = TikiLib::lib('rating');
	}

	function getProvidedFields()
	{
		if (is_null($this->fields)) {
			$ratingconfiglib = TikiLib::lib('ratingconfig');

			$this->fields = array();
			foreach ($ratingconfiglib->get_configurations() as $config) {
				$this->fields[] = "adv_rating_{$config['ratingConfigId']}";
			}
		}

		return $this->fields;
	}

	function getGlobalFields()
	{
		return array();
	}

	function getData($objectType, $objectId, Search_Type_Factory_Interface $typeFactory, array $data = array())
	{
		$ratings = $this->ratinglib->obtain_ratings($objectType, $objectId);

		$data = array();

		foreach ($ratings as $id => $value) {
			$data["adv_rating_$id"] = $typeFactory->sortable($value);
		}

		return $data;
	}
}


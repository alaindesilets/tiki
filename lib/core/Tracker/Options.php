<?php
// (c) Copyright 2002-2013 by authors of the Tiki Wiki CMS Groupware Project
//
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

class Tracker_Options
{
	private $data = array();
	private $info;

	private function __construct()
	{
	}

	public static function fromSerialized($json, array $info)
	{
		$options = new Tracker_Options;
		$options->info = $info;
		$options->data = json_decode($json, true);

		return $options;
	}

	public static function fromString($string, array $info)
	{
		$options = new Tracker_Options;
		$options->info = $info;

		$parts = preg_split('/\s*,\s*/', trim($options));

		foreach ($parts as $key => $value) {
			if (empty($value)) {
				continue;
			}

			if ($field = $options->getParamDefinitionFromIndex($key)) {
				if ($field['count'] == '*') {
					// Count is last, always
					$options->setParam($field['key'], array_values(array_slice($parts, $key)));
					break;
				} elseif (isset($field['separator'])) {
					$options->setParam($field['key'], explode($field['separator'], $value));
				} else {
					$options->setParam($field['key'], $value);
				}
			}
		}

		return $options;
	}

	public function fromArray(array $rawData, array $typeInfo)
	{
		$options = new Tracker_Options;
		$options->info = $typeInfo;

		foreach ($rawData as $key => $value) {
			if ($def = $options->getParamDefinition($key)) {
				if (is_string($value)) {
					if (isset($def['count']) && $def['count'] == '*') {
						$value = explode(',', $value);
					} elseif (isset($def['separator'])) {
						$value = explode($def['separator'], $value);
					}
				}

				$options->setParam($key, $value);
			}
		}

		return $options;
	}

	public static function fromInput(JitFilter $input, array $typeInfo)
	{
		$options = new Tracker_Options;
		$options->info = $typeInfo;

		foreach ($typeInfo['params'] as $key => $info) {
			$filter = $info['filter'];

			if (isset($info['count']) && $info['count'] === '*') {
				$values = explode(',', $input->$key->none());
				$filter = TikiFilter::get($filter);
				$values = array_map(array($filter, 'filter'), $values);
				
				$options->setParam($key, $values);
			} elseif (isset($info['separator'])) {
				$input->replaceFilter($key, $filter);
				$values = $input->asArray($key, $info['separator']);

				$options->setParam($key, $values);
			} else {
				$options->setParam($key, $input->$key->$filter());
			}
		}

		return $options;
	}

	private function getParamDefinitionFromIndex($key)
	{
		foreach ($this->info['params'] as $paramKey => $info) {
			if (isset($info['legacy_index']) && $key == $info['legacy_index']) {
				return $this->getParamDefinition($paramKey);
			}
		}
	}

	private function getParamDefinition($key)
	{
		if (isset($this->info['params'][$key])) {
			$data = $this->info['params'][$key];
			$data['key'] = $key;

			return $data;
		}
	}

	private function setParam($key, $value)
	{
		$this->data[$key] = $value;
	}

	function getParam($key, $default = false)
	{
		if (isset($this->data[$key])) {
			return $this->data[$key];
		} elseif($default === false && $def = $this->getParamDefinition($key)) {
			if (isset($def['default'])) {
				return $def['default'];
			}
		}
	}

	function getParamFromIndex($index, $default = false)
	{
		if ($field = $this->getParamDefinitionFromIndex($index)) {
			return $this->getParam($field[$key], $default);
		} else {
			return $default;
		}
	}

	function getAllParameters()
	{
		$out = array();

		foreach (array_keys($this->info['params']) as $key) {
			$out[$key] = $this->getParam($key);
		}

		return $out;
	}

	function serialize()
	{
		return json_encode($this->data);
	}

	function buildOptionsArray()
	{
		$out = array();
		foreach ($this->info as $key => $info) {
			$value = $this->getParam($key);
			if (isset($info['count']) && $info['count'] == '*') {
				$values = $value;
			} elseif (isset($info['separator'])) {
				$values = array(implode($info['separator'], $value));
			} else {
				$values = array($value);
			}

			foreach ($values as $v) {
				$out[] = $v;
			}
		}
		
		return $v;
	}
}

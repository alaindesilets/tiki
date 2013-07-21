<?php
// (c) Copyright 2002-2011 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

/**
 * Handler class for GroupSelector
 * 
 * Letter key: ~g~
 *
 */
class Tracker_Field_GroupSelector extends Tracker_Field_Abstract
{
	public static function getTypes()
	{
		return array(
			'g' => array(
				'name' => tr('Group Selector'),
				'description' => tr('Allows a selection from a specified list of user groups.'),
				'params' => array(
					'autoassign' => array(
						'name' => tr('Auto-Assign'),
						'description' => tr('Determines if any group should be automatically assigned to the field.'),
						'filter' => 'int',
						'options' => array(
							0 => tr('None'),
							1 => tr('Creator'),
							2 => tr('Modifier'),
						),
					),
					'groupId' => array(
						'name' => tr('Group Filter'),
						'description' => tr('Limit listed groups to those including the specified group.'),
						'filter' => 'int',
					),
				),
			),
		);
	}

	function getFieldData(array $requestData = array())
	{
		global $tiki_p_admin_trackers, $group;
		
		$ins_id = $this->getInsertId();

		$data = array();
		
		$groupId = $this->getOption(1);
		if (empty($groupId)) {
			$data['list'] = TikiLib::lib('user')->list_all_groups();
		} else {
			$group_info = TikiLib::lib('user')->get_groupId_info($groupId);
			$data['list'] =	TikiLib::lib('user')->get_including_groups($group_info['groupName']);
		}

		if ( isset($requestData[$ins_id])) {
			if ($this->getOption(0) < 1 || $tiki_p_admin_trackers === 'y') {
				$data['value'] = in_array($requestData[$ins_id], $data['list'])? $requestData[$ins_id]: '';
			} else {
				if ($this->getOption(0) == 2) {
					$data['defvalue'] = $group;
					$data['value'] = $group;
				} elseif ($this->getOption(0) == 1) {
					$data['value'] = $group;
				} else {
					$data['value'] = '';
				}
			}
		} else {
			$data['defvalue'] = $group;
			$data['value'] = $this->getValue();		
		}
		
		return $data;
	}
	
	function renderInput($context = array())
	{
		return $this->renderTemplate('trackerinput/groupselector.tpl', $context);
	}

	function handleSave($value, $oldValue)
	{
		global $prefs;

		if ($this->getOption(0) && is_null($oldValue)) {
			$definition = $this->getTrackerDefinition();
			if ($prefs['groupTracker'] == 'y' && $definition->isEnabled('autoCreateGroup')) {
				$value = TikiLib::lib('trk')->groupName($definition->getInformation(), $this->getItemId());
			}
		}

		return array(
			'value' => $value,
		);
	}
}

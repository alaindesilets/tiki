<?php
// (c) Copyright 2002-2011 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

class Services_Tracker_Controller
{
	private $utilities;

	function setUp()
	{
		global $prefs;
		$this->utilities = new Services_Tracker_Utilities;

		if ($prefs['feature_trackers'] != 'y') {
			throw new Services_Exception_Disabled('feature_trackers');
		}
	}

	function action_add_field($input)
	{
		if (! Perms::get()->admin_trackers) {
			throw new Services_Exception(tr('Reserved to tracker administrators'), 403);
		}

		$trklib = TikiLib::lib('trk');
		$trackerId = $input->trackerId->int();
		$definition = Tracker_Definition::get($trackerId);

		if (! $definition) {
			throw new Services_Exception(tr('Tracker does not exist'), 404);
		}

		$name = $input->name->text();
		$permName = $input->permName->word();
		$type = $input->type->text();
		$description = $input->description->text();
		$wikiparse = $input->description_parse->int();
		$adminOnly = $input->adminOnly->int();
		$fieldId = 0;

		$types = $this->utilities->getFieldTypes();

		if (empty($type)) {
			$type = 't';
		}

		if (! isset($types[$type])) {
			throw new Services_Exception(tr('Type does not exist'), 400);
		}

		if ($input->type->word()) {
			if (empty($name)) {
				throw new Services_Exception_MissingValue('name');
			}

			if ($definition->getFieldFromName($name)) {
				throw new Services_Exception_DuplicateValue('name', $name);
			}

			if ($definition->getFieldFromPermName($permName)) {
				throw new Services_Exception_DuplicateValue('permName', $permName);
			}

			$fieldId = $this->utilities->createField(array(
				'trackerId' => $trackerId,
				'name' => $name,
				'permName' => $permName,
				'type' => $type,
				'description' => $description,
				'descriptionIsParsed' => $wikiparse,
				'isHidden' => $adminOnly ? 'y' : 'n',
			));

			if ($input->submit_and_edit->none() || $input->next->word() === 'edit') {
				return array(
					'FORWARD' => array(
						'action' => 'edit_field',
						'fieldId' => $fieldId,
						'trackerId' => $trackerId,
					),
				);
			}
		}

		return array(
			'trackerId' => $trackerId,
			'fieldId' => $fieldId,
			'name' => $name,
			'permName' => $permName,
			'type' => $type,
			'types' => $types,
			'description' => $description,
			'descriptionIsParsed' => $wikiparse,
		);
	}

	function action_list_fields($input)
	{
		$trackerId = $input->trackerId->int();
		$perms = Perms::get('tracker', $trackerId);

		if (! $perms->view_trackers) {
			throw new Services_Exception(tr('Not allowed to view the tracker'), 403);
		}

		$definition = Tracker_Definition::get($trackerId);

		if (! $definition) {
			throw new Services_Exception(tr('Tracker does not exist'), 404);
		}

		return array(
			'fields' => $definition->getFields(),
			'types' => $this->utilities->getFieldTypes(),
		);
	}

	function action_save_fields($input)
	{
		if (! Perms::get()->admin_trackers) {
			throw new Services_Exception(tr('Reserved to tracker administrators'), 403);
		}

		$trackerId = $input->trackerId->int();
		$definition = Tracker_Definition::get($trackerId);

		if (! $definition) {
			throw new Services_Exception(tr('Tracker does not exist'), 404);
		}

		$fields = array();
		foreach ($input->field as $key => $value) {
			$fieldId = (int) $key;
			$fields[$fieldId] = array(
				'position' => $value->position->int(),
				'isTblVisible' => $value->isTblVisible->int() ? 'y' : 'n',
				'isMain' => $value->isMain->int() ? 'y' : 'n',
				'isSearchable' => $value->isSearchable->int() ? 'y' : 'n',
				'isPublic' => $value->isPublic->int() ? 'y' : 'n',
				'isMandatory' => $value->isMandatory->int() ? 'y' : 'n',
			);

			$this->utilities->updateField($trackerId, $fieldId, $fields[$fieldId]);
		}

		return array(
			'fields' => $fields,
		);
	}

	function action_edit_field($input)
	{
		if (! Perms::get()->admin_trackers) {
			throw new Services_Exception(tr('Reserved to tracker administrators'), 403);
		}

		$trackerId = $input->trackerId->int();
		$fieldId = $input->fieldId->int();
		$definition = Tracker_Definition::get($trackerId);

		if (! $definition) {
			throw new Services_Exception(tr('Tracker does not exist'), 404);
		}

		$field = $definition->getField($fieldId);
		if (! $field) {
			throw new Services_Exception(tr('Tracker field not found in specified tracker'), 404);
		}

		$types = $this->utilities->getFieldTypes();
		$typeInfo = $types[$field['type']];

		$permName = $input->permName->word();
		if ($field['permName'] != $permName) {
			if ($definition->getFieldFromPermName($permName)) {
				throw new Services_Exception_DuplicateValue('permName', $permName);
			}
		}

		if ($input->name->text()) {
			$input->replaceFilters(array(
				'visible_by' => 'groupname',
				'editable_by' => 'groupname',
			));
			$visibleBy = $input->asArray('visible_by', ',');
			$editableBy = $input->asArray('editable_by', ',');
			$this->utilities->updateField($trackerId, $fieldId, array(
				'name' => $input->name->text(),
				'description' => $input->description->text(),
				'descriptionIsParsed' => $input->description_parse->int() ? 'y' : 'n',
				'options' => $this->utilities->buildOptions($input->option, $typeInfo),
				'validation' => $input->validation_type->word(),
				'validationParam' => $input->validation_parameter->none(),
				'validationMessage' => $input->validation_message->text(),
				'isMultilingual' => $input->multilingual->int() ? 'y' : 'n',
				'visibleBy' => array_filter(array_map('trim', $visibleBy)),
				'editableBy' => array_filter(array_map('trim', $editableBy)),
				'isHidden' => $input->visibility->alpha(),
				'errorMsg' => $input->error_message->text(),
				'permName' => $permName,
			));
		}

		return array(
			'field' => $field,
			'info' => $typeInfo,
			'options' => $this->utilities->parseOptions($field['options_array'], $typeInfo),
			'validation_types' => array(
				'' => tr('None'),
				'captcha' => tr('Captcha'),
				'distinct' => tr('Distinct'),
				'pagename' => tr('Page Name'),
				'password' => tr('Password'),
				'regex' => tr('Regular Expression (Pattern)'),
				'username' => tr('User Name'),
			),
		);
	}

	function action_remove_fields($input)
	{
		if (! Perms::get()->admin_trackers) {
			throw new Services_Exception(tr('Reserved to tracker administrators'), 403);
		}
		
		$trackerId = $input->trackerId->int();
		$fields = $input->fields->int();

		$definition = Tracker_Definition::get($trackerId);

		if (! $definition) {
			throw new Services_Exception(tr('Tracker not found'), 404);
		}

		foreach ($fields as $fieldId) {
			if (! $definition->getField($fieldId)) {
				throw new Services_Exception(tr('Field does not exist in tracker'), 404);
			}
		}

		if ($input->confirm->int()) {
			$trklib = TikiLib::lib('trk');
			foreach ($fields as $fieldId) {
				$trklib->remove_tracker_field($fieldId, $trackerId);
			}

			return array(
				'status' => 'DONE',
				'trackerId' => $trackerId,
				'fields' => $fields,
			);
		} else {
			return array(
				'trackerId' => $trackerId,
				'fields' => $fields,
			);
		}
	}

	function action_export_fields($input)
	{
		if (! Perms::get()->admin_trackers) {
			throw new Services_Exception(tr('Reserved to tracker administrators'), 403);
		}
		
		$trackerId = $input->trackerId->int();
		$fields = $input->fields->int();

		$definition = Tracker_Definition::get($trackerId);

		if (! $definition) {
			throw new Services_Exception(tr('Tracker not found'), 404);
		}

		if ($fields) {
			$fields = $this->utilities->getFieldsFromIds($definition, $fields);
		} else {
			$fields = $definition->getFields();
		}

		$data = "";
		foreach ($fields as $field) {
			$data .= $this->utilities->exportField($field);
		}

		return array(
			'trackerId' => $trackerId,
			'fields' => $fields,
			'export' => $data,
		);
	}

	function action_import_fields($input)
	{
		if (! Perms::get()->admin_trackers) {
			throw new Services_Exception(tr('Reserved to tracker administrators'), 403);
		}

		$trackerId = $input->trackerId->int();
		$definition = Tracker_Definition::get($trackerId);

		if (! $definition) {
			throw new Services_Exception(tr('Tracker not found'), 404);
		}
		
		$raw = $input->raw->none();
		$preserve = $input->preserve_ids->int();

		$data = TikiLib::lib('tiki')->read_raw($raw);

		if (! $data) {
			throw new Services_Exception(tr('Invalid data provided'), 400);
		}

		$factory = new Tracker_Field_Factory($definition);
		foreach ($data as $info) {
			$this->utilities->importField($trackerId, new JitFilter($info), $preserve);
		}

		return array(
			'trackerId' => $trackerId,
		);
	}

	function action_list_trackers($input)
	{
		if (! Perms::get()->admin_trackers) {
			throw new Services_Exception(tr('Reserved to tracker administrators'), 403);
		}

		$trklib = TikiLib::lib('trk');
		return $trklib->list_trackers();
	}

	function action_list_items($input)
	{
		// TODO : Eventually, this method should filter according to the actual permissions, but because
		//        it is only to be used for tracker sync at this time, admin privileges are just fine.

		if (! Perms::get()->admin_trackers) {
			throw new Services_Exception(tr('Reserved to tracker administrators'), 403);
		}

		$trackerId = $input->trackerId->int();
		$offset = $input->offset->int();
		$maxRecords = $input->maxRecords->int();
		$status = $input->status->word();
		$format = $input->format->word();
		$modifiedSince = $input->modifiedSince->int();
		
		$definition = Tracker_Definition::get($trackerId);

		if (! $definition) {
			throw new Services_Exception(tr('Tracker does not exist'), 404);
		}

		$items = $this->utilities->getItems(array(
			'trackerId' => $trackerId,
			'status' => $status,
			'modifiedSince' => $modifiedSince,
		), $maxRecords, $offset);

		if ($format !== 'raw') {
			foreach ($items as & $item) {
				$item = $this->utilities->processValues($definition, $item);
			}
		}

		return array(
			'trackerId' => $trackerId,
			'offset' => $offset,
			'maxRecords' => $maxRecords,
			'result' => $items,
		);
	}

	function action_insert_item($input)
	{
		$trackerId = $input->trackerId->int();
		$definition = Tracker_Definition::get($trackerId);

		if (! $definition) {
			throw new Services_Exception(tr('Tracker does not exist'), 404);
		}

		// TODO : Eventually, this method should check the track permissions
		if (! Perms::get()->admin_trackers) {
			throw new Services_Exception(tr('Reserved to tracker administrators'), 403);
		}

		$itemId = $this->utilities->insertItem($definition, array(
			'status' => $input->status->word(),
			'fields' => $input->fields->none(),
		));
		TikiLib::lib('unifiedsearch')->processUpdateQueue();

		return array(
			'trackerId' => $trackerId,
			'itemId' => $itemId,
		);
	}

	function action_update_item($input)
	{
		$trackerId = $input->trackerId->int();
		$definition = Tracker_Definition::get($trackerId);

		if (! $definition) {
			throw new Services_Exception(tr('Tracker does not exist'), 404);
		}

		// TODO : Eventually, this method should check the track permissions
		if (! Perms::get()->admin_trackers) {
			throw new Services_Exception(tr('Reserved to tracker administrators'), 403);
		}

		if (! $itemId = $input->itemId->int()) {
			throw new Services_Exception_MissingValue('itemId');
		}

		$this->utilities->updateItem($definition, array(
			'itemId' => $itemId,
			'status' => $input->status->word(),
			'fields' => $input->fields->none(),
		));
		TikiLib::lib('unifiedsearch')->processUpdateQueue();

		return array(
			'trackerId' => $trackerId,
			'itemId' => $itemId,
		);
	}
}


<?php
// (c) Copyright 2002-2011 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

class Tracker_Field_Files extends Tracker_Field_Abstract
{
	public static function getTypes()
	{
		return array(
			'FG' => array(
				'name' => tr('Files'),
				'description' => tr('Attached and upload files stored in the file galleries to the tracker item.'),
				'params' => array(
					'galleryId' => array(
						'name' => tr('Gallery ID'),
						'description' => tr('File gallery to upload new files into.'),
						'filter' => 'int',
					),
					'filter' => array(
						'name' => tr('Mime Type Filter'),
						'description' => tr('Mask for accepted mime types in the field'),
						'filter' => 'text',
					),
					'count' => array(
						'name' => tr('File Count'),
						'description' => tr('Maximum amount of files to be attached on the field.'),
						'filter' => 'int',
					),
				),
			),
		);
	}

	public static function build($type, $trackerDefinition, $fieldInfo, $itemData)
	{
		return new self($fieldInfo, $itemData, $trackerDefinition);
	}

	function getFieldData(array $requestData = array())
	{
		$galleryId = (int) $this->getOption(0);
		$count = (int) $this->getOption(2);

		$value = '';
		$ins_id = $this->getInsertId();
		if (isset($requestData[$ins_id])) {
			// Incoming data from form

			// Get the list of selected file IDs from the text field
			$value = $requestData[$ins_id];
			$fileIds = explode(',', $value);

			// Add manually uploaded files (non-HTML5 browsers only)
			foreach (array_keys($_FILES[$ins_id]['name']) as $index) {
				$fileIds[] = $this->handleUpload($galleryId, array(
					'name' => $_FILES[$ins_id]['name'][$index],
					'type' => $_FILES[$ins_id]['type'][$index],
					'size' => $_FILES[$ins_id]['size'][$index],
					'tmp_name' => $_FILES[$ins_id]['tmp_name'][$index],
				));
			}

			// Remove missed uploads
			$fileIds = array_filter($fileIds);

			// Keep only the first files if a limit is applied
			if ($count) {
				$fileIds = array_slice($fileIds, 0, $count);
			}

			// Obtain the info for display and filter by type if specified
			$fileInfo = $this->getFileInfo($fileIds);
			$fileInfo = array_filter($fileInfo, array($this, 'filterFile'));

			// Rebuild the database value
			$value = implode(',', array_keys($fileInfo));
		} else {
			$value = $this->getValue();

			// Obtain the information from the database for display
			$fileIds = array_filter(explode(',', $value));
			$fileInfo = $this->getFileInfo($fileIds);
		}

		$perms = Perms::get('file gallery', $galleryId);

		return array(
			'galleryId' => $galleryId,
			'canUpload' => $perms->upload_files,
			'limit' => $count,
			'files' => $fileInfo,
			'value' => $value,
			'filter' => $this->getOption(1),
		);
	}

	function renderInput($context = array())
	{
		return $this->renderTemplate('trackerinput/files.tpl', $context);
	}

	function renderOutput($context = array())
	{
		return $this->renderTemplate('trackeroutput/files.tpl', $context);
	}

	function handleSave($value, $oldValue)
	{
		$new = array_diff(explode(',', $value), explode(',', $oldValue));
		$remove = array_diff(explode(',', $oldValue), explode(',', $value));

		$itemId = $this->getItemId();

		$relationlib = TikiLib::lib('relation');
		$relations = $relationlib->get_relations_from('trackeritem', $itemId, 'tiki.file.attach');
		foreach ($relations as $existing) {
			if ($existing['type'] != 'file') {
				continue;
			}

			if (in_array($existing['itemId'])) {
				$relationlib->remove_relation($existing['relationId']);
			}
		}

		foreach ($new as $fileId) {
			$relationlib->add_relation('tiki.file.attach', 'trackeritem', $itemId, 'file', $fileId);
		}

		return array(
			'value' => $value,
		);
	}

	function watchCompare($old, $new)
	{
	}

	function filterFile($info)
	{
		$filter = $this->getOption(1);

		if (! $filter) {
			return true;
		}

		$parts = explode('*', $filter);
		$parts = array_map('preg_quote', $parts, array_fill(0, count($parts), '/'));

		$body = implode('[\w-]+', $parts);

		// Force begin, ignore end which may contain charsets or other attributes
		return preg_match("/^$body/", $info['filetype']);
	}

	private function getFileInfo($ids)
	{
		$db = TikiDb::get();
		$table = $db->table('tiki_files');

		$data = $table->fetchAll(array('fileId', 'name', 'filetype'), array(
			'fileId' => $table->in($ids),
		));

		$out = array();
		foreach ($data as $info) {
			$out[$info['fileId']] = $info;
		}

		return $out;
	}

	private function handleUpload($galleryId, $file)
	{
		if (! is_uploaded_file($file['tmp_name'])) {
			return false;
		}

		$filegallib = TikiLib::lib('filegal');
		$gal_info = $filegallib->get_file_gallery_info($galleryId);

		if (! $gal_info) {
			return false;
		}

		$perms = Perms::get('file gallery', $galleryId);
		if (! $perms->upload_files) {
			return false;
		}

		return $filegallib->upload_single_file($gal_info, $file['name'], $file['size'], $file['type'], file_get_contents($file['tmp_name']));
	}
}


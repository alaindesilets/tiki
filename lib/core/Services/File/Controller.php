<?php

class Services_File_Controller
{
	function action_upload($input) {
		$gal_info = $this->checkTargetGallery($input);

		$size = $input->size->int();
		$name = $input->name->text();
		$type = $input->type->text();
		$data = $input->data->none();

		$data = base64_decode($data);

		if (function_exists('finfo_buffer')) {
			$finfo = new finfo(FILEINFO_MIME);
			$type = $finfo->buffer($data);
		}

		$fileId = $this->uploadFile($gal_info, $name, $size, $type, $data);

		return array(
			'size' => $size,
			'name' => $name,
			'type' => $type,
			'fileId' => $fileId,
			'galleryId' => $galleryId,
			'md5sum' => md5($data),
		);
	}

	function action_remote($input)
	{
		$gal_info = $this->checkTargetGallery($input);
		
		$filegallib = TikiLib::lib('filegal');
		$info = $filegallib->get_info_from_url($input->url->url());

		if (! $info) {
			throw new Services_Exception(tr('Data could not be obtained.'), 412);
		}

		$fileId = $this->uploadFile($gal_info, $info['name'], $info['size'], $info['type'], $info['data']);

		return array(
			'size' => $info['size'],
			'name' => $info['name'],
			'type' => $info['type'],
			'fileId' => $fileId,
			'galleryId' => $gal_info['galleryId'],
			'md5sum' => md5($info['data']),
		);
	}

	private function checkTargetGallery($input)
	{
		$galleryId = $input->galleryId->int();

		if (! $gal_info = $this->getGallery($galleryId)) {
			throw new Services_Exception(tr('Requested gallery does not exist.'), 404);
		}

		$perms = Perms::get('file gallery', $galleryId);
		if (! $perms->upload_files) {
			throw new Services_Exception(tr('Permission denied.'), 403);
		}

		return $gal_info;
	}

	private function getGallery($galleryId)
	{
		$filegallib = TikiLib::lib('filegal');
		return $filegallib->get_file_gallery_info($galleryId);
	}

	private function uploadFile($gal_info, $name, $size, $type, $data)
	{
		$filegallib = TikiLib::lib('filegal');
		return $filegallib->upload_single_file($gal_info, $name, $size, $type, $data);
	}
}


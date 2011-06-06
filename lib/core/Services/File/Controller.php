<?php

class Services_File_Controller
{
	function action_upload($input) {
		$galleryId = $input->galleryId->int();

		if (! $gal_info = $this->getGallery($galleryId)) {
			throw new Services_Exception(tr('Requested gallery does not exist.'), 404);
		}

		$perms = Perms::get('file gallery', $galleryId);
		if (! $perms->upload_files) {
			throw new Services_Exception(tr('Permission denied.'), 403);
		}

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

	private function getGallery($galleryId)
	{
		$filegallib = TikiLib::lib('filegal');
		return $filegallib->get_file_gallery_info($galleryId);
	}

	private function uploadFile($gal_info, $name, $size, $type, $data)
	{
		global $prefs, $user;

		$filegallib = TikiLib::lib('filegal');
		$savedir = $filegallib->get_gallery_save_dir($gal_info['galleryId'], $galInfo);
		$fhash = '';

		if ($savedir) {
			$fhash = $filegallib->find_unique_name($savedir, $name);
			file_put_contents($savedir . $fhash, $data);
			$data = null;
		}

		return $filegallib->insert_file($gal_info['galleryId'], $name, '', $name, $data, $size, $type, $user, $fhash, '');
	}
}


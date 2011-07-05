<?php
// (c) Copyright 2002-2011 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

class Language_GetStrings
{
	/**
	 * Array of file types objects.
	 * 
	 * @var array
	 */
	protected $fileTypes = array();
	
	/**
	 * Array of valid extensions. Extracted
	 * from $this->fileTypes.
	 * 
	 * @var array
	 */
	protected $extensions = array();
	
	/**
	 * List of languages whose language.php
	 * files will be updated. If empty all
	 * language.php files are updated.
	 * 
	 * @var array
	 */
	protected $languages = array();
	
	/**
	 * @var Language_CollectFiles
	 */
	public $collectFiles;
	
	/**
	 * @var Language_WriteFile
	 */
	public $writeFile;
	
	/**
	 * Whether file paths where the string was found
	 * is included or not in langauge.php files. Default
	 * is false.
	 * 
	 * @var bool
	 */
	protected $outputFiles = false;
	
	/**
	 * Class construct.
	 * 
	 * The following are valid $options:
	 *   - 'outputFiles' => true: will write to language.php file the path
	 *     to the files where the string was found. Default is false.
	 *   - 'lang' => 'langCode' or 'lang' => array(list of lang codes):
	 *     language code or list of language codes whose language.php will be
	 *     updated. If empty, all language.php files are updated.
	 * 
	 * @param Language_CollectFiles $collectFiles
	 * @param Language_WriteFile $writeFile
	 * @param array $options list of options to control object behavior (see above)
	 * @return null
	 */
	public function __construct(Language_CollectFiles $collectFiles, Language_WriteFile $writeFile, array $options = null)
	{
		$this->collectFiles = $collectFiles;
		$this->writeFile = $writeFile;
		
		if (isset($options['outputFiles']) && $options['outputFiles'] == true) {
			$this->outputFiles = true;
		}
		
		if (isset($options['lang'])) {
			$this->setLanguages($options['lang']);
		}
	}
	
	/**
	 * Getter for $this->extensions
	 * @return array
	 */
	public function getExtensions()
	{
		return $this->extensions;
	}
	
	/**
	 * Getter for $this->fileTypes
	 * @return array
	 */
	public function getFileTypes()
	{
		return $this->fileTypes;
	}
	
	/**
	 * Add a file type object to $this->fileTypes
	 * and update $this->extensions.
	 * 
	 * @param FileType $fileType
	 * @return null
	 * @throws Language_Exception if type being added already exists
	 */
	public function addFileType(Language_FileType $fileType)
	{	
		if (in_array($fileType, $this->fileTypes)) {
			$className = get_class($fileType);
			throw new Language_Exception("Type $className already added.");
		}
		
		$this->fileTypes[] = $fileType;
		$this->extensions = array_merge($this->extensions, $fileType->getExtensions());
	}
	
	/**
	 * Setter method $this->languages
	 * property.
	 *  
	 * @param array|string $languages
	 * @return null
	 */
	public function setLanguages($languages)
	{
		if (is_string($languages)) {
			$languages = array($languages);
		}
		
		foreach ($languages as $lang) {
			if (!file_exists(__DIR__ . '/../../lang/' . $lang)) {
				throw new Language_Exception('Invalid language code.');
			}
		}

		$this->languages = $languages;
	}
	
	/**
	 * Getter method for $this->languages.
	 * 
	 * @return array
	 */
	public function getLanguages()
	{
		return $this->languages;
	}
	
	/**
	 * Get English strings from a given file.
	 * 
	 * @param string $filePath path to file
	 * @return array collected strings
	 */
	public function collectStrings($filePath)
	{
		if (empty($this->fileTypes)) {
			throw new Language_Exception('No Language_FileType found.');
		}
		
		$strings = array();
		$fileExtension = strrchr($filePath, '.');
		
		if (!$fileExtension || $fileExtension == '.') {
			throw new Language_Exception('Could not determine file extension.');
		}
		
		foreach ($this->fileTypes as $fileType) {
			if (in_array($fileExtension, $fileType->getExtensions())) {
				$file = file_get_contents($filePath);
				
				foreach ($fileType->getCleanupRegexes() as $regex => $replacement) {
					$file = preg_replace($regex, $replacement, $file);
				}
				
				foreach ($fileType->getRegexes() as $regex) {
					$matches = array();
					preg_match_all($regex, $file, $matches);
					$strings = array_merge($strings, $matches[1]);
				}
				
				break;
			}
		}
		
		return array_values(array_unique($strings));
	}

	/**
	 * Loop through a list of files and
	 * calls $this->collectStrings() for each
	 * file. Return a list of translatable strings
	 * found.
	 * 
	 * @param array $files
	 * @return array $strings translatable strings found in scanned files
	 */
	public function scanFiles($files)
	{
		$strings = array();
		
		// strings collected per file
		$filesStrings = array();
		
		if (!empty($files)) {
			foreach ($files as $file) {
				$filesStrings[$file] = $this->collectStrings($file);
			}
		}

		// join strings collected per file into a single array
		// and remove duplicated strings
		foreach ($filesStrings as $file => $fileStrings) {
			foreach ($fileStrings as $str) {
				if (!isset($strings[$str])) {
					$string = new stdClass;
					$string->name = $str;
					
					if ($this->outputFiles) {
						// $string->files is an array with all the files where the string was found
						$string->files = array($file);
					}
					
					$strings[$str] = $string;
				} else {
					if ($this->outputFiles) {
						$strings[$str]->files[] = $file;
					}
				}
			}
		}
				
		return $strings;
	}
	
	public function writeToFiles($strings)
	{
		$languages = $this->languages;
		
		// if $this->languages is empty use all available languages
		if (empty($languages)) {
			$dirs = dir(__DIR__ . '/../../lang');
			
			while (false !== ($entry = $dirs->read())) {
				if ($entry == '.' || $entry == '..') {
					continue;
				}
				
				$path = $dirs->path . '/' . $entry;
				if (is_dir($path) && file_exists($path . '/language.php')) {
					$languages[] = $entry;
				}
			}
		}

		foreach ($languages as $lang) {
			$langPath = __DIR__ . '/../../lang/' . $lang . '/language.php';
			$this->writeFile->writeStringsToFile($strings, $langPath, $this->outputFiles);
		}
	}
	
	public function run()
	{
		if (empty($this->fileTypes)) {
			throw new Language_Exception('No Language_FileType found.');
		}
		
		$this->collectFiles->setExtensions($this->extensions);
		$files = $this->collectFiles->run('.');
		$strings = $this->scanFiles($files);
		$this->writeToFiles($strings);
	}
}
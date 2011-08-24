<?php
// (c) Copyright 2002-2011 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

class Search_Formatter_Plugin_SmartyTemplate implements Search_Formatter_Plugin_Interface
{
	private $templateFile;
	private $changeDelimiters;
	private $data = array();
	private $fields = array();

	function __construct($templateFile, $changeDelimiters = false)
	{
		$this->templateFile = $templateFile;
		$this->changeDelimiters = (bool) $changeDelimiters;
	}

	function setData(array $data)
	{
		$this->data = $data;
	}

	function getFields()
	{
		return $this->fields;
	}

	function setFields(array $fields)
	{
		$this->fields = $fields;
	}

	function getFormat()
	{
		return self::FORMAT_HTML;
	}

	function prepareEntry($entry)
	{
		return $entry->getPlainValues();
	}

	function renderEntries($entries, $count, $offset, $maxRecords, $pagination = '')
	{
		$smarty = new Smarty;
		$smarty->security = true;
		$smarty->compile_dir = dirname(__FILE__) . '/../../../../../templates_c';
		$smarty->template_dir = dirname($this->templateFile);
		$smarty->plugins_dir = array(	// the directory order must be like this to overload a plugin
			TIKI_SMARTY_DIR,
			SMARTY_DIR.'plugins'
		);

		$smarty->enableSecurity('Tiki_Security_Policy');

		if( $this->changeDelimiters ) {
			$smarty->left_delimiter = '{{';
			$smarty->right_delimiter = '}}';
		}

		foreach ($this->data as $key => $value) {
			$smarty->assign($key, $value);
		}

		$smarty->assign('results', $entries);
		$smarty->assign('count', $count);
		$smarty->assign('offset', $offset);
		$smarty->assign('offsetplusone', $offset + 1);
		$smarty->assign('offsetplusmaxRecords', $offset + $maxRecords);
		$smarty->assign('maxRecords', $maxRecords);
		$smarty->assign('pagination', $pagination);

		return $smarty->fetch($this->templateFile);
	}
}


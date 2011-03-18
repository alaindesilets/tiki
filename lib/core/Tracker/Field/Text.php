<?php

/**
 * Handler class for Text
 * 
 * Letter key: ~t~
 *
 */
class Tracker_Field_Text extends Tracker_Field_Abstract
{
	function getFieldData(array $requestData = array())
	{
		$data = $this->processMultilingual($requestData, $this->getInsertId());

		return $data;
	}

	function renderInput($context = array())
	{
		return $this->renderTemplate('trackerinput/text.tpl', $context);
	}

	function renderInnerOutput($context = array())
	{
		$pre = '';
		$post = '';

		if ($this->getOption(2)) {
			$pre = '<span class="formunit">' . $this->getOption(2) . '</span>';
		}

		if ($this->getOption(3)) {
			$pre = '<span class="formunit">' . $this->getOption(3) . '</span>';
		}

		return $pre . parent::renderInnerOutput($context) . $post;
	}

	protected function processMultilingual($requestData, $id_string) {
		global $prefs, $language;

		if (!isset($requestData[$id_string])) {
			$requestData[$id_string] = $this->getValue();
		}
		
		if (is_array($requestData[$id_string])) {
			$thisVal = $requestData[$id_string][$language];
		} else {
			$thisVal = $requestData[$id_string];
		}

		$data = array(
			'value' => $thisVal,
			'pvalue' => TikiLib::lib('tiki')->parse_data(htmlspecialchars($thisVal)),
			'lingualvalue' => array(),
			'lingualpvalue' => array(),
		);

		if ($this->getConfiguration("isMultilingual") == 'y') {
			if (! is_array($requestData[$id_string])) {
				$out = array();
				foreach($prefs['available_languages'] as $num => $tmplang) {	// TODO add a limit on number of langs - 40+ makes this blow up
					if (!isset($out[$tmplang])) {	// Case convert normal -> multilingual
						$out[$tmplang] = $this->getValue($data['value'], $tmplang);
					}
				}

				$requestData[$id_string] = $out;
			}

			foreach($prefs['available_languages'] as $num => $tmplang) {	// TODO add a limit on number of langs - 40+ makes this blow up
				if (!isset($requestData[$id_string][$tmplang])) {	// Case convert normal -> multilingual
					$requestData[$id_string][$tmplang] = $this->getValue($data['value'], $tmplang);
				}

				$data['lingualvalue'][$num]['lang'] = $tmplang;
				$data['lingualvalue'][$num]['value'] = $requestData[$id_string][$tmplang];
				$data['lingualpvalue'][$num]['lang'] = $tmplang;
				$data['lingualpvalue'][$num]['value'] = TikiLib::lib('tiki')->parse_data(htmlspecialchars($requestData[$id_string][$tmplang]));

				if ($prefs['language'] == $tmplang) {
					$data['value'] = $data['lingualvalue'][$num]['value'];
					$data['pvalue'] = $data['lingualpvalue'][$num]['value'];
				}
			}
		}

		return $data;
	}
}


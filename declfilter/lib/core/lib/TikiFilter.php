<?php

require_once 'Zend/Filter/Interface.php';

class TikiFilter
{
	/**
	 * Provides a filter instance based on the input. Either a filter
	 * can be passed or a name.
	 * 
	 * @param mixed
	 * @return Zend_Filter_Interface
	 */
	public static function get( $filter )
	{
		if( $filter instanceof Zend_Filter_Interface ) {
			return $filter;
		}

		switch( $filter )
		{
		case 'alpha':
			require_once 'Zend/Filter/Alpha.php';
			return new Zend_Filter_Alpha;
		case 'alnum':
			require_once 'Zend/Filter/Alnum.php';
			return new Zend_Filter_Alnum;
		case 'digits':
			require_once 'Zend/Filter/Digits.php';
			return new Zend_Filter_Digits;
		case 'username':
		case 'groupname':
			// Use striptags
		case 'striptags':
			require_once 'Zend/Filter/StripTags.php';
			return new Zend_Filter_StripTags;
		case 'word':
			require_once 'TikiFilter/Word.php';
			return new TikiFilter_Word;
		case 'xss':
			require_once 'TikiFilter/PreventXss.php';
			return new TikiFilter_PreventXss;
		default:
			trigger_error( 'Filter not found: ' . $filter, E_USER_WARNING );
			require_once 'TikiFilter/PreventXss.php';
			return new TikiFilter_PreventXss;
		}
	}
}

?>

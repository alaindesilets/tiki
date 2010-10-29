<?php

class Search_Type_Factory_Lucene implements Search_Type_Factory_Interface
{
	function plaintext($value)
	{
		return new Search_Type_WikiText($value);
	}

	function wikitext($value)
	{
		return new Search_Type_WikiText($value);
	}

	function timestamp($value)
	{
		return new Search_Type_Whole($value);
	}

	function identifier($value)
	{
		return new Search_Type_Whole($value);
	}

	function multivalue($values)
	{
		return new Search_Type_MultivalueText((array) $values);
	}
}


<?php
// (c) Copyright 2002-2011 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id: UnsetRule.php 34150 2011-04-27 14:11:19Z lphuberdeau $

abstract class DeclFilter_UnsetRule implements DeclFilter_Rule
{
	function apply( array &$data, $key )
	{
		unset($data[$key]);
	}
}
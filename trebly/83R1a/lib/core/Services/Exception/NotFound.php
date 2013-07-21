<?php
// (c) Copyright 2002-2011 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id: NotFound.php 37024 2011-09-07 18:53:56Z lphuberdeau $

class Services_Exception_NotFound extends Services_Exception
{
	function __construct()
	{
		parent::__construct(tr('Not found'), 404);
	}
}

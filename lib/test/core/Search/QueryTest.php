<?php

class Search_QueryTest extends PHPUnit_Framework_TestCase
{
	function testQueryGlobalText()
	{
		$index = new Search_Index_Memory;
		$query = new Search_Query('hello');

		$query->search($index);
		
		$expr = new Search_Expr_And(array(
			new Search_Expr_Token('hello', 'wikitext', 'global'),
		));

		$this->assertEquals($expr, $index->getLastQuery());
	}

	function testCompositeQuery()
	{
		$index = new Search_Index_Memory;
		$query = new Search_Query('hello world');

		$query->search($index);
		
		$expr = new Search_Expr_And(array(
			new Search_Expr_Or(array(
				new Search_Expr_Token('hello', 'wikitext', 'global'),
				new Search_Expr_Token('world', 'wikitext', 'global'),
			)),
		));

		$this->assertEquals($expr, $index->getLastQuery());
	}

	function testFilterType()
	{
		$index = new Search_Index_Memory;
		$query = new Search_Query('hello');
		$query->filterType('wiki page');

		$query->search($index);
		
		$expr = new Search_Expr_And(array(
			new Search_Expr_Token('hello', 'wikitext', 'global'),
			new Search_Expr_Token('wiki page', 'identifier', 'object_type'),
		));

		$this->assertEquals($expr, $index->getLastQuery());
	}

	function testFilterCategory()
	{
		$index = new Search_Index_Memory;
		$query = new Search_Query;
		$query->filterCategory('1 and 2');

		$query->search($index);

		$expr = new Search_Expr_And(array(
			$expr = new Search_Expr_And(array(
				new Search_Expr_Token('1', 'multivalue', 'categories'),
				new Search_Expr_Token('2', 'multivalue', 'categories'),
			)),
		));

		$this->assertEquals($expr, $index->getLastQuery());
	}

	function testFilterLanguage()
	{
		$index = new Search_Index_Memory;
		$query = new Search_Query;
		$query->filterLanguage('en or fr');

		$query->search($index);

		$expr = new Search_Expr_And(array(
			$expr = new Search_Expr_Or(array(
				new Search_Expr_Token('en', 'identifier', 'language'),
				new Search_Expr_Token('fr', 'identifier', 'language'),
			)),
		));

		$this->assertEquals($expr, $index->getLastQuery());
	}

	function testDefaultSearchOrder()
	{
		$index = new Search_Index_Memory;
		$query = new Search_Query;

		$query->search($index);

		$this->assertEquals(Search_Query_Order::searchResult(), $index->getLastOrder());
	}

	function testSpecifiedOrder()
	{
		$index = new Search_Index_Memory;
		$query = new Search_Query;

		$query->setOrder(Search_Query_Order::recentChanges());

		$query->search($index);

		$this->assertEquals(Search_Query_Order::recentChanges(), $index->getLastOrder());
	}

	function testOrderFromString()
	{
		$index = new Search_Index_Memory;
		$query = new Search_Query;

		$query->setOrder('title_asc');

		$query->search($index);

		$this->assertEquals(new Search_Query_Order('title', 'text', 'asc'), $index->getLastOrder());
	}

	function testFilterBasedOnPermissions()
	{
		$index = new Search_Index_Memory;
		$query = new Search_Query;
		$query->filterPermissions(array('Registered', 'Editor', 'Project Lead ABC'));

		$query->search($index);

		$expr = new Search_Expr_And(array(
			$expr = new Search_Expr_Or(array(
				new Search_Expr_Token('Registered', 'multivalue', 'allowed_groups'),
				new Search_Expr_Token('Editor', 'multivalue', 'allowed_groups'),
				new Search_Expr_Token('Project Lead ABC', 'multivalue', 'allowed_groups'),
			)),
		));

		$this->assertEquals($expr, $index->getLastQuery());
	}

	function testDefaultPagination()
	{
		$index = new Search_Index_Memory;
		$query = new Search_Query;

		$query->search($index);

		$this->assertEquals(0, $index->getLastStart());
		$this->assertEquals(50, $index->getLastCount());
	}

	function testSpecifiedRange()
	{
		$index = new Search_Index_Memory;
		$query = new Search_Query;
		$query->setRange(60, 30);

		$query->search($index);

		$this->assertEquals(60, $index->getLastStart());
		$this->assertEquals(30, $index->getLastCount());
	}
}


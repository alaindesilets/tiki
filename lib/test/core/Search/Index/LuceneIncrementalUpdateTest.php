<?php

/**
 * @group unit
 */
class Search_Index_LuceneIncrementalUpdateTest extends PHPUnit_Framework_TestCase
{
	private $dir;
	private $index;

	function setUp()
	{
		$this->dir = dirname(__FILE__) . '/test_index';
		$this->tearDown();

		$index = new Search_Index_Lucene($this->dir);
		$this->addDocument($index, 'wiki page', 'HomePage', 'Hello World');
		$this->addDocument($index, 'wiki page', 'SomePage', 'No content yet.');
	}

	function tearDown()
	{
		$dir = escapeshellarg($this->dir);
		`rm -Rf $dir`;
	}

	function testAddNewDocument()
	{
		$index = new Search_Index_Lucene($this->dir);
		$index->invalidateMultiple(array(
			array('object_type' => 'wiki page', 'object_id' => 'NewPage'),
		));
		$this->addDocument($index, 'wiki page', 'NewPage', 'Testing out');

		$this->assertResultFound('out', $index);
		$this->assertResultFound('content', $index);
		$this->assertResultFound('world', $index);
	}

	function testReplaceDocument()
	{
		$index = new Search_Index_Lucene($this->dir);
		$index->invalidateMultiple(array(
			array('object_type' => 'wiki page', 'object_id' => 'SomePage'),
		));
		$this->addDocument($index, 'wiki page', 'SomePage', 'Foobar');

		$this->assertResultFound('foobar', $index);
		$this->assertResultFound('content', $index, 0);
	}

	private function assertResultFound($word, $index, $count = 1)
	{
		$query = new Search_Query($word);
		$result = $query->search($index);

		$this->assertEquals($count, count($result));
	}

	private function addDocument($index, $type, $id, $data)
	{
		$typeFactory = $index->getTypeFactory();

		$index->addDocument(array(
			'object_type' => $typeFactory->identifier($type),
			'object_id' => $typeFactory->identifier($id),
			'data' => $typeFactory->wikitext($data),
		));
	}
}


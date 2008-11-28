<?php

class TikiFilter_MapTest extends PHPUnit_Framework_TestCase
{
	private $array;

	function testDirect()
	{
		$this->assertTrue( TikiFilter::get( 'digits' ) instanceof Zend_Filter_Digits );
		$this->assertTrue( TikiFilter::get( 'alpha' ) instanceof Zend_Filter_Alpha );
		$this->assertTrue( TikiFilter::get( 'alnum' ) instanceof Zend_Filter_Alnum );
		$this->assertTrue( TikiFilter::get( 'striptags' ) instanceof Zend_Filter_StripTags );
		$this->assertTrue( TikiFilter::get( 'xss' ) instanceof TikiFilter_PreventXss );
		$this->assertTrue( TikiFilter::get( 'word' ) instanceof TikiFilter_Word );
	}

	function testKnown()
	{
		$this->assertTrue( TikiFilter::get( new Zend_Filter_Alnum ) instanceof Zend_Filter_Alnum );
	}

	/**
	 * Triggered errors become exceptions...
	 * @expectedException Exception
	 */
	function testUnknown()
	{
		$this->assertTrue( TikiFilter::get( 'does_not_exist' ) instanceof TikiFilter_PreventXss );
	}

	function testComposed()
	{
		$filter = new JitFilter( array( 'foo' => 'test123' ) );
		$filter->replaceFilter( 'foo', 'digits' );

		$this->assertEquals( '123', $filter['foo'] );
	}

	function testDefault()
	{
		$filter = new JitFilter( array( 'foo' => 'test123' ) );
		$filter->setDefaultFilter( 'digits' );

		$this->assertEquals( '123', $filter['foo'] );
	}
}

?>

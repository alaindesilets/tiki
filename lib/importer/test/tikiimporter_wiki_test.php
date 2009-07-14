<?php

require_once(dirname(__FILE__) . '/../../core/test/TikiTestCase.php');
require_once(dirname(__FILE__) . '/../tikiimporter_wiki.php');
require_once(dirname(__FILE__) . '/../tikiimporter_wiki_mediawiki.php');

class TikiImporter_Wiki_Test extends TikiTestCase
{
    public function testImportShouldCallMethodsToStartImportProcess()
    {
        $obj = $this->getMock('TikiImporter_Wiki', array('validateInput', 'parseData', 'insertData'));
        $obj->expects($this->once())->method('validateInput');
        $obj->expects($this->once())->method('parseData');
        $obj->expects($this->once())->method('insertData');

        $obj->import();
   }

    public function testImportShouldSetInstanceProperties()
    {
        $obj = $this->getMock('TikiImporter_Wiki', array('validateInput', 'parseData', 'insertData'));
        $_POST['alreadyExistentPageName'] = 'override';
        $_POST['wikiRevisions'] = 100;

        $obj->import();

        $this->assertEquals(100, $obj->revisionsNumber);
        $this->assertEquals('override', $obj->alreadyExistentPageName);

        unset($_POST['alreadyExistentPageName']);
        unset($_POST['wikiRevisions']);
        $obj->import();

        $this->assertEquals(0, $obj->revisionsNumber);
        $this->assertEquals('doNotImport', $obj->alreadyExistentPageName);
    }

    public function testImportShouldReturnNumberOfPagesImported()
    {
        $expectedResult = array('importedPages' => 10, 'totalPages' => '13');
        $obj = $this->getMock('TikiImporter_Wiki', array('validateInput', 'parseData', 'insertData'));
        $obj->expects($this->once())->method('validateInput'); 
        $obj->expects($this->once())->method('parseData');
        $obj->expects($this->once())->method('insertData')->will($this->returnValue($expectedResult));

        $importFeedback = $obj->import();

        $this->assertEquals($expectedResult, $importFeedback);
    }

    public function testInsertDataCallInsertPageFourTimes()
    {
        $obj = $this->getMock('TikiImporter_Wiki', array('insertPage'));
        $obj->expects($this->exactly(4))->method('insertPage');
        $parsedData = array(1, 2, 3, 4);
        $obj->insertData($parsedData);
    }

    public function testInsertDataCallInsertPageOnceWithProperParam()
    {
        $obj = $this->getMock('TikiImporter_Wiki', array('insertPage'));
        $obj->expects($this->once())->method('insertPage')->with('pageArray');
        $parsedData = array('pageArray');
        $obj->insertData($parsedData);
    }

    public function testInsertDataShouldNotCallInsertPage()
    {
        $obj = $this->getMock('TikiImporter_Wiki', array('insertPage'));
        $obj->expects($this->never())->method('insertPage');
        $parsedData = array();
        $obj->insertData($parsedData);
    }

    public function testInsertDataShouldReturnCountData()
    {
        $obj = $this->getMock('TikiImporter_Wiki', array('insertPage'));
        $obj->expects($this->exactly(6))->method('insertPage')->will($this->onConsecutiveCalls(true, true, false, true, false, true));

        $parsedData = array(1, 2, 3, 4, 5, 6);
        $countData = $obj->insertData($parsedData);
        $expectedResult = array('totalPages' => 6, 'importedPages' => 4);

        $this->assertEquals($expectedResult, $countData);
    }
}

class TikiImporter_Wiki_InsertPage_Test extends TikiTestCase
{

    protected function setUp()
    {
        require_once(dirname(__FILE__) . '/fixtures/mediawiki_page_as_array.php');
        global $tikilib;
        $tikilib = $this->getMock('TikiLib', array('create_page', 'update_page', 'page_exists', 'remove_all_versions'));
        $this->obj = new TikiImporter_Wiki_Mediawiki;
        $this->obj->revisionsNumber = 0;
    }

    public function testInsertPage()
    {
        global $tikilib, $page;

        $tikilib->expects($this->once())->method('page_exists')->with($page['name'])->will($this->returnValue(false));
        $tikilib->expects($this->once())->method('create_page')->with($page['name'], 0, $page['revisions'][0]['data'], $page['revisions'][0]['lastModif'], $page['revisions'][0]['comment'], $page['revisions'][0]['user'], $page['revisions'][0]['ip']);
        // TODO: how to test parameters for update_page for the 7 different calls
        $tikilib->expects($this->exactly(7))->method('update_page');

        // $page is set on mediawiki_page_as_array.php
        $this->assertTrue($this->obj->insertPage($page));
    }

    public function testInsertPageRevisionNumberDefinedToThree()
    {
        global $tikilib, $page;
        $tikilib->expects($this->once())->method('page_exists')->with($page['name'])->will($this->returnValue(false));
        $tikilib->expects($this->once())->method('create_page')->with($page['name'], 0, $page['revisions'][5]['data'], $page['revisions'][5]['lastModif'], $page['revisions'][5]['comment'], $page['revisions'][5]['user'], $page['revisions'][5]['ip']);
        // TODO: how to test parameters for update_page for the 2 different calls
        $tikilib->expects($this->exactly(2))->method('update_page')->with($page['name']);
        
        $this->obj->revisionsNumber = 3;
        $this->assertTrue($this->obj->insertPage($page));
    }

    public function testInsertPageRevisionNumberDefinedToTwo()
    {
        global $tikilib, $page;
        $tikilib->expects($this->once())->method('page_exists')->with($page['name'])->will($this->returnValue(false));
        $tikilib->expects($this->once())->method('create_page')->with($page['name'], 0, $page['revisions'][6]['data'], $page['revisions'][6]['lastModif'], $page['revisions'][6]['comment'], $page['revisions'][6]['user'], $page['revisions'][6]['ip']);
        $tikilib->expects($this->once())->method('update_page')->with($page['name'], $page['revisions'][7]['data'], $page['revisions'][7]['comment'], $page['revisions'][7]['user'], $page['revisions'][7]['ip'], '', $page['revisions'][7]['minor'], '', false, null, $page['revisions'][7]['lastModif']);
        $this->obj->revisionsNumber = 2;
        $this->assertTrue($this->obj->insertPage($page));
    }

    public function testInsertPageAlreadyExistentPageNameOverride()
    {
        global $tikilib, $page;
        $tikilib->expects($this->once())->method('page_exists')->with($page['name'])->will($this->returnValue(true));
        $tikilib->expects($this->once())->method('remove_all_versions')->with($page['name']);
        $tikilib->expects($this->once())->method('create_page');
        $tikilib->expects($this->exactly(7))->method('update_page');

        $this->obj->alreadyExistentPageName = 'override';
        $this->assertTrue($this->obj->insertPage($page));
    }

    public function testInsertPageAlreadyExistentPageNameAppendPrefix()
    {
        global $tikilib, $page;

        $newPageName = $this->obj->softwareName . '_' . $page['name'];

        $tikilib->expects($this->once())->method('page_exists')->with($page['name'])->will($this->returnValue(true));
        $tikilib->expects($this->once())->method('create_page')->with($newPageName);
        $tikilib->expects($this->exactly(7))->method('update_page')->with($newPageName);

        $this->obj->alreadyExistentPageName = 'appendPrefix';
        $this->assertTrue($this->obj->insertPage($page));
    }

    public function testInsertPageAlreadyExistentPageNameDoNotImport()
    {
        global $tikilib, $page;

        $tikilib->expects($this->once())->method('page_exists')->with($page['name'])->will($this->returnValue(true));
        $tikilib->expects($this->never())->method('create_page');
        $tikilib->expects($this->never())->method('update_page');

        $this->obj->alreadyExistentPageName = 'doNotImport';
        $this->assertFalse($this->obj->insertPage($page));
    }
}

?>

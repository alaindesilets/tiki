<?php

/**
 * TikiImporter
 * 
 * This file has the main class for the TikiImporter.
 * The TikiImporter was started as a Google Summer of Code project and
 * aim to provide a generic structure for importing content from other
 * softwares to TikiWiki
 * See http://dev.tikiwiki.org/gsoc2009rodrigo for more information
 * 
 * @author Rodrigo Sampaio Primo <rodrigo@utopia.org.br>
 * @package tikiimporter
 */

/**
 * TikiImporter is a generic class that should be extended
 * by any importer class. Each importer class must implement
 * the methods validateInput(), parseData() and import()
 * 
 */
class TikiImporter
{
	/**
	 * The name of the software to import from.
	 * Should be defined in child class
	 * @var string
	 */
    public $softwareName = '';
    
    /**
     * Options to the importer (i.e. the number of page
     * revisions to import in the case of a wiki software)
     * 
     * This array is used in tiki-importer.tpl to display to the user
     * the options related with the data import. Currently an importOptions
     * can be of the following types: checkbox, select, text 
     * 
     * @var array
     */
    static public $importOptions = array();

    /**
     * Abstract method to start the import process and
     * call all other functions for each step of the importation
     * (validateInput(), parseData(), insertData())
     *
     * @return array $importFeedback array with the number of pages imported etc
     */
    function import() {}

    /**
     * Abstract method to validate the input import data
     * 
     * Must be implemented by classes
     * that extends this one. 
     */
    function validateInput() {}
    
    /**
     * Abstract method to parse the input import data
     * 
     * Must be implemented by classes
     * that extends this one and should return
     * the data to be used by insertData. 
     */
    function parseData() {}

    /**
     * Abstract method to insert the imported content
     * into Tiki
     * 
     * Must be implemented by classes
     * that extends this one.
     * 
     * @param array $parsedData data ready to be inserted into Tiki
     */
    function insertData($parsedData) {}
    
    /**
     * Return a $importOptions array with the result of the concatenation of the $importOptions
     * property of all classes in the hierarchy. Should be called by the classes that
     * extend from this one, it doesn't make sense to call this method directly from this
     * class.
     * 
     * This method should be static but apparently only with PHP >= 5.3.0 is possible to get 
     * the name of the class the static method was called. For more information see
     * http://us2.php.net/manual/en/function.get-called-class.php
     * 
     * @return array $importOptions
     */
    function getOptions()
    {
        $class = get_class($this);
        $importOptions = array();
        
        do {
            $refClass = new ReflectionClass($class);
            $importOptions = array_merge($importOptions, $refClass->getStaticPropertyValue('importOptions', array()));
        } while ($class = get_parent_class($class));
        
        return $importOptions;
    }
}

?>

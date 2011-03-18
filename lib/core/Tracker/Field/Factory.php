<?php

class Tracker_Field_Factory
{
	private $trackerDefinition;
	private $itemData;

	function __construct($trackerDefinition, $itemData = array())
	{
		$this->trackerDefinition = $trackerDefinition;
		$this->itemData = $itemData;
	}

	function getHandler($field_info) {
		switch ($field_info['type']) {
			case 'A':
				return new Tracker_Field_File($field_info, $this->itemData, $this->trackerDefinition);
			case 'a':
				return new Tracker_Field_TextArea($field_info, $this->itemData, $this->trackerDefinition);
			case 'c':
				return new Tracker_Field_Checkbox($field_info, $this->itemData, $this->trackerDefinition);
			case 'd':
				return new Tracker_Field_Dropdown($field_info, $this->itemData, $this->trackerDefinition);
			case 'D':
				return new Tracker_Field_Dropdown($field_info, $this->itemData, $this->trackerDefinition, 'other');
			case 'e':
				return new Tracker_Field_Category($field_info, $this->itemData, $this->trackerDefinition);
			case 'f':
				return new Tracker_Field_DateTime($field_info, $this->itemData, $this->trackerDefinition);
			case 'G':
				return new Tracker_Field_Location($field_info, $this->itemData, $this->trackerDefinition);
			case 'g':
				return new Tracker_Field_GroupSelector($field_info, $this->itemData, $this->trackerDefinition);
			case 'i':
				return new Tracker_Field_Image($field_info, $this->itemData, $this->trackerDefinition);
			case 'I':
				return new Tracker_Field_Simple($field_info, $this->itemData, $this->trackerDefinition, 'ip');
			case 'L':
				return new Tracker_Field_Simple($field_info, $this->itemData, $this->trackerDefinition, 'url');
			case 'k':
				return new Tracker_Field_PageSelector($field_info, $this->itemData, $this->trackerDefinition);
			case 'l':
				return new Tracker_Field_ItemsList($field_info, $this->itemData, $this->trackerDefinition);
			case 'm':
				return new Tracker_Field_Simple($field_info, $this->itemData, $this->trackerDefinition, 'email');
			case 'N':
				return new Tracker_Field_InGroup($field_info, $this->itemData, $this->trackerDefinition);
			case 'n':
			case 'b':
				return new Tracker_Field_Numeric($field_info, $this->itemData, $this->trackerDefinition);
			case 'P':
				return new Tracker_Field_Ldap($field_info, $this->itemData, $this->trackerDefinition);
			case 'p':
				return new Tracker_Field_UserPreference($field_info, $this->itemData, $this->trackerDefinition);			
			case 'q':
				return new Tracker_Field_AutoIncrement($field_info, $this->itemData, $this->trackerDefinition);
			case 'r':
				return new Tracker_Field_ItemLink($field_info, $this->itemData, $this->trackerDefinition);
			case 'S':
				return new Tracker_Field_StaticText($field_info, $this->itemData, $this->trackerDefinition);
			case 't':
				return new Tracker_Field_Text($field_info, $this->itemData, $this->trackerDefinition);
			case 'u':
				return new Tracker_Field_UserSelector($field_info, $this->itemData, $this->trackerDefinition);
			case 'y':
				return new Tracker_Field_CountrySelector($field_info, $this->itemData, $this->trackerDefinition);
		}
	}
}


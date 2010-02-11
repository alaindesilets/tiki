<?php

// $Id$

// Wiki plugin to output superscript <sup>...</sup>
// based on sub plugin

function wikiplugin_sup_help() {
        return tra("Displays text in superscript.").":<br />~np~{SUP()}text{SUP}~/np~";
}

function wikiplugin_sup_info() {
	return array(
		'name' => tra( 'Superscript' ),
		'documentation' => 'PluginSup',		
		'description' => tra('Displays text in superscript (exponent).'),
		'prefs' => array( 'wikiplugin_sup' ),
		'body' => tra('text'),
		'icon' => 'pics/icons/text_superscript.png',
		'params' => array(
		),
	);
}

function wikiplugin_sup($data, $params)
{
        global $tikilib;

        extract ($params,EXTR_SKIP);
	return "<sup>$data</sup>";
}

<?php

// $Header: /cvsroot/tikiwiki/_mods/wiki-plugins/plazes/wiki-plugins/wikiplugin_plazeswhereis.php,v 1.1 2005-09-08 02:35:34 damosoft Exp $

// Wiki plugin to display your whereis page
// make sure you sign up and register for the whereis first ;)
//
// i.e. http://beta.plazes.com/whereis/Damian
//
// use with plazes : http://www.plazes.com

// Damian

function wikiplugin_plazeswhereis_help() {
        return tra("Displays your Plazes WhereIs page").":<br />~np~{PLAZESWHEREIS(name=your_name)/}~/np~";
}

function wikiplugin_plazeswhereis($data, $params) {
	
	extract ($params);

	if (!$name) {
		return "Plugin called without a name.";
	}

	$asetup = "<a href=\"http://beta.plazes.com/whereis/$name\">Whereis $name</a>";
	
	return $asetup;
}

?>

<?php

// $Id$
// Copyright (c) 2002-2007, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for
// details.

//this script may only be included - so its better to die if called directly.
$access->check_script($_SERVER["SCRIPT_NAME"],basename(__FILE__));

// Javascript auto-detection
//   (to be able to generate non-javascript code if there is no javascript, when noscript tag is not useful enough)
//   It uses cookies instead of session vars to keep the correct value after a session timeout

if ( isset($_COOKIE['javascript_enabled']) ) {
	// Update the pref with the cookie value
	$prefs['javascript_enabled'] = $_COOKIE['javascript_enabled'];
} else {
	// Set the cookie to 'n', through PHP / HTTP headers
	$prefs['javascript_enabled'] = 'n';
	setcookie('javascript_enabled', 'n');
}

if ( $prefs['javascript_enabled'] != 'y' ) {
	// Set the cookie to 'y', through javascript (will override the above cookie set to 'n' and sent by PHP / HTTP headers)
	$headerlib->add_js("setCookieBrowser('javascript_enabled','y');");

	$prefs['feature_tabs'] = 'n';
	$prefs['feature_jquery'] = 'n';
	$prefs['feature_mootools'] = 'n';
	$prefs['feature_shadowbox'] = 'n';
	$prefs['feature_wysiwyg'] = 'n';
	$prefs['feature_ajax'] = 'n';
	
} else {	// we have JavaScript

	/** Use custom.js in styles or options dir if there **/
	$custom_js = $tikilib->get_style_path($prefs['style'], $prefs['style_option'], 'custom.js');
	if (!empty($custom_js)) {
		$headerlib->add_jsfile($custom_js, 50);
	}
	
	/** PNG transparency fix for IE 5.5 & 6 **/
	if ($prefs['feature_ie56_correct_png'] == 'y' && (strpos($_SERVER['HTTP_USER_AGENT'], 'MSIE 6') !== false) || strpos($_SERVER['HTTP_USER_AGENT'], 'MSIE 5')) {
		$headerlib->add_js(<<<JS
function correctPNG() // correctly handle PNG transparency in Win IE 5.5 & 6.
{
	var arVersion = navigator.appVersion.split("MSIE");
	var version = parseFloat(arVersion[1]);
	if ((version >= 5.5) && (document.all && !this.op))
	{
		for(var i=0; i < document.images.length; i++)
		{
			var img = document.images[i];
			var imgName = img.src.toUpperCase();
			if (imgName.substring(imgName.length-3, imgName.length) == "PNG")
			{
				var imgID = (img.id) ? "id='" + img.id + "' " : "";
				var imgClass = (img.className) ? "class='" + img.className + "' " : "";
				var imgTitle = (img.title) ? "title='" + img.title + "' " : "title='" + img.alt + "' ";
				var imgStyle = "display:inline-block;" + img.style.cssText;
				if (img.align == "left") { imgStyle = "float:left;" + imgStyle; }
				if (img.align == "right") { imgStyle = "float:right;" + imgStyle; }
				if (img.parentElement.href) { imgStyle = "cursor:hand;" + imgStyle; }
				var strNewHTML = "<span " + imgID + imgClass + imgTitle
								+ " style=\"" + "width:" + img.width + "px; height:" + img.height + "px;" + imgStyle + ";"
								+ "filter:progid:DXImageTransform.Microsoft.AlphaImageLoader"
								+ "(src=\'" + img.src + "\', sizingMethod='scale');\"></span>";
				img.outerHTML = strNewHTML;
				i = i-1;
			}
		}
	}
}
if (this.ie56) {
	window.attachEvent("onload", correctPNG);
}
JS
		);
	}
}
if ($prefs['feature_ajax'] != 'y') {
	$prefs['feature_ajax_autosave'] = 'n';
}

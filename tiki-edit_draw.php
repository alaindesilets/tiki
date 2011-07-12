<?php
// (c) Copyright 2002-2011 by authors of the Tiki Wiki CMS Groupware Project
// 
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$
$section = "draw";
require_once ('tiki-setup.php');
require_once ('lib/svg-edit_tiki/draw.php');
include_once ('lib/filegals/filegallib.php');

$access->check_feature('feature_draw');
$access->check_feature('feature_file_galleries');

include_once ("categorize_list.php");
include_once ('tiki-section_options.php');

ask_ticket('draw');

if (empty($_REQUEST['fileId']) || !($fileInfo = $filegallib->get_file_info($_REQUEST['fileId']))) {
	$smarty->assign('msg', tra("Incorrect param"));
	$smarty->display('error.tpl');
	die;
}

$gal_info = $filegallib->get_file_gallery($fileInfo['galleryId']);

$tikilib->get_perm_object($fileInfo['galleryId'], 'file gallery', $gal_info, true);

if (!($tiki_p_admin_file_galleries == 'y' || $tiki_p_view_file_gallery == 'y')) {
	$smarty->assign('errortype', 401);
	$smarty->assign('msg', tra("You do not have permission to edit this file"));
	$smarty->display("error.tpl");
	die;
}

//Obtain fileId, DO NOT LET ANYTHING OTHER THAN NUMBERS BY (for injection free code)
if (is_numeric($_REQUEST['fileId']) == false) $_REQUEST['fileId'] = 0; 
if (is_numeric($_REQUEST['galleryId']) == false) $_REQUEST['galleryId'] = 0;

$fileId = htmlspecialchars($_REQUEST['fileId']);
$galleryId = htmlspecialchars($_REQUEST['galleryId']);

$label = htmlspecialchars($_REQUEST['label']);
$index = htmlspecialchars($_REQUEST['index']);
$page = htmlspecialchars($_REQUEST['page']);

$smarty->assign( "page", $page );
$smarty->assign( "isFromPage", isset($page) );

$backLocation = ($page ? "tiki-index.php?page=$page" : "tiki-list_file_gallery.php?galleryId=$galleryId");

$smarty->assign( "fileId", $fileId );
$smarty->assign( "galleryId", $galleryId );

$headerlib->add_jsfile("lib/svg-edit/embedapi.js");

if (
	isset($_REQUEST['label']) && 
	isset($_REQUEST['index']) &&
	isset($_REQUEST['page'])
) {
	$headerlib->add_jq_onready("	
		window.wikiTracking = {
			label: '$label',
			index: '$index',
			page: '$page',
			type: 'draw',
			content: ''
		};
	");
}

$headerlib->add_jq_onready("
	window.svgFileId = $fileId;
	var win = $(window);
	win
		.resize(function() {
			$('#svgedit')
				.height(win.height())
				.width(win.width());
		})
		.resize();
	
	$('body').css('overflow', 'hidden');
	
	window.svgCanvas = null;
	
	window.handleSvgDataUpdate = function(data, error) {
		if (error) {
			alert('error ' + error);
		} else {
			window.handleSvgDataNew(data, error);
		}			
	}

	window.handleSvgDataNew = function(data, error) {
		if (error) {
			alert('error ' + error);
		} else {
			$.post('tiki-batch_upload_files.php', {
				batch_upload: 'svg',
				galleryId: $galleryId,
				fileId: (window.svgFileId ? window.svgFileId : ''),
				name: 'New Svg Image',
				data: data
			}, function(id) {
				if (id) {
					alert('".tr("Saved file id:")." ' + id + '!');
					window.svgFileId = id;
				} else {
					alert('".tr("Saved file id")." ' + window.svgFileId + '!');
				}
				
				if (window.wikiTracking) {
					window.wikiTracking['params[id]'] = window.svgFileId;
					
					$.post('tiki-wikiplugin_edit.php', window.wikiTracking, function() {
						window.wikiTracking = null;
					});
				}
			});
		}			
	}
	
	window.saveSvg = function() {
		window.svgCanvas.getSvgString()(window.handleSvgDataNew);
		
		window.svgWindow.svgCanvas.undoMgr.resetUndoStack();
	};
	
	$('#svgedit').load(function() {
		var frame = window.svgFrame = document.getElementById('svgedit');
		window.svgCanvas = new embedded_svg_edit(frame);
		window.svgWindow = frame.contentWindow;
		
		// Hide main button, as we will be controlling new/load/save etc from the host document
		var doc;
		doc = frame.contentDocument;
		if (!doc)
		{
			doc = frame.contentWindow.document;
		}
		
		var mainButton = $(doc).find('#main_button').hide();
		
		$('#tiki-draw_save')
			//.prependTo($(doc).find('#editor_panel'))
			.click(function() {
				window.saveSvg();
			});
		
		var thisDoc = document;
		
		$('#svg-editHeaderRight')
			//.appendTo($(doc).find('#tools_top'))
			.click(function() {
				thisDoc.location = '$backLocation';
			});
		
		if (window.svgFileId) {
			$('<div />').load('tiki-download_file.php?fileId=$fileId&r=' + Math.floor(Math.random() * 9999999999), function(o) {
				window.svgCanvas.setSvgString(o);
			});
		}
		
		window.svgWindow.onbeforeunload = function() {};
		window.onbeforeunload = function() {
			if ( window.svgWindow.svgCanvas.undoMgr.getUndoStackSize() > 1 ) {
				return '".tra("There are unsaved changes, leave page?")."';
			}
		};
	});
");
// Display the template
$smarty->assign('mid', 'tiki-edit_draw.tpl');
// use tiki_full to include include CSS and JavaScript
$smarty->display("tiki_full.tpl");


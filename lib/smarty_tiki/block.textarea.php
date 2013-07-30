<?php
// (c) Copyright 2002-2013 by authors of the Tiki Wiki CMS Groupware Project
//
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.
// $Id$

/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 *
 * smarty_block_textarea : add a textarea to a template.
 *
 * special params:
 *    _toolbars: if set to 'y', display toolbars above the textarea
 *    _previewConfirmExit: if set to 'n' doesn't warn about lost edits after preview
 *    _simple: if set to 'y' does no wysiwyg, auto_save, lost edit warning etc
 *
 *    _wysiwyg: force wysiwyg editor
 *    _is_html: parse as html
 *
 * usage: {textarea id='my_area' name='my_area'}{tr}My Text{/tr}{/textarea}
 */

//this script may only be included - so its better to die if called directly.
if (strpos($_SERVER["SCRIPT_NAME"], basename(__FILE__)) !== false) {
	header("location: index.php");
	exit;
}

function smarty_block_textarea($params, $content, $smarty, $repeat)
{
    static $included=false;
	global $prefs, $headerlib, $smarty, $is_html;

	if ( $repeat ) {
		return;
	}
    if (!$included) {
        $headerlib->add_js(
            <<<JS
                function GetCurrentEditorAreaId(ob){
        var p;
        p=ob.parentNode;
        while(p.className != "edit-zone"){p=p.parentNode;}
        areaid=p.id.substring(10);
        //alert ("areaid="+areaid);
        return areaid;
    }
JS
        );
    }
	// some defaults
	$params['_toolbars'] = isset($params['_toolbars']) ? $params['_toolbars'] : 'y';
	if ($prefs['mobile_feature'] === 'y' && $prefs['mobile_mode'] === 'y') {
		$params['_toolbars'] = 'n';
	}
	if ( $prefs['javascript_enabled'] != 'y') {
		$params['_toolbars'] = 'n';
	}

	$params['_simple'] = isset($params['_simple']) ? $params['_simple'] : 'n';

	if (!isset($params['_wysiwyg'])) {
		if ($params['_simple'] === 'n') {
			// should not be set usually(?)
			include_once 'lib/setup/editmode.php';
			$params['_wysiwyg'] = $_SESSION['wysiwyg'];
		} else {
			$params['_wysiwyg'] = 'n';
		}
	}
	if ($is_html === null) {
		// sometimes $is_html has not been set, so take an educated guess
		if ($params['_wysiwyg'] === 'y' && $prefs['wysiwyg_htmltowiki'] !== 'y') {
			$is_html = true;
		}
	}

	$params['_is_html'] = isset($params['_is_html']) ? $params['_is_html'] : $is_html;

	$params['name'] = isset($params['name']) ? $params['name'] : 'edit';
	$params['id'] = isset($params['id']) ? $params['id'] : 'editwiki';
	$params['area_id'] = isset($params['area_id']) ? $params['area_id'] : $params['id'];	// legacy param for toolbars?
	$params['class'] = isset($params['class']) ? $params['class'] : 'wikiedit';
	$params['comments'] = isset($params['comments']) ? $params['comments'] : 'n';
	$params['autosave'] = isset($params['autosave']) ? $params['autosave'] : 'y';

	//codemirror integration
	if ($prefs['feature_syntax_highlighter'] === 'y') {
		$params['data-codemirror'] = isset($params['codemirror']) ? $params['codemirror'] : '';
		$params['data-syntax'] = isset($params['syntax']) ? $params['syntax'] : '';
	}
	//keep params html5 friendly
	unset($params['codemirror']);
	unset($params['syntax']);

	// mainly for modules admin - preview is for the module, not the custom module so don;t need to confirmExit
	$params['_previewConfirmExit'] = isset($params['_previewConfirmExit']) ? $params['_previewConfirmExit'] : 'y';

	if ( ! isset($params['section']) ) {
		global $section;
		$params['section'] = $section ? $section: 'wiki page';
	}
	if ( ! isset($params['style']) && ! isset($params['cols']) ) {
		$params['style'] = 'width:99%';
	}
	$html = '';
    if (!$included) $html .= '<input type="hidden" name="mode_wysiwyg" value="" /><input type="hidden" name="mode_normal" value="" />';

	$auto_save_referrer = '';
	$auto_save_warning = '';
	$as_id = $params['id'];

	$smarty->loadPlugin('smarty_block_remarksbox');
	$tmp_var = $smarty->getTemplateVars('page');
	$editWarning = $prefs['wiki_timeout_warning'] === 'y' && isset($tmp_var) && $tmp_var !== 'sandbox';
	if ($params['_simple'] === 'n' && $editWarning) {
		$remrepeat = false;
		$html .= smarty_block_remarksbox(
			array( 'type'=>'tip', 'title'=>tra('Tip')),
			tra('This edit session will expire in') .
			' <span id="edittimeout">' . (ini_get('session.gc_maxlifetime') / 60) .'</span> '. tra('minutes') . '. ' .
			tra('<strong>Preview</strong> (if available) or <strong>Save</strong> your work to restart the edit session timer'),
			$smarty,
			$remrepeat
		)."\n";
		if ($prefs['javascript_enabled'] === 'y') {
			$html = str_replace('<div class="clearfix rbox tip">', '<div class="clearfix rbox tip" style="display:none;">', $html);	// quickfix to stop this box appearing before doc.ready
		}
	}

	$params['switcheditor'] = isset($params['switcheditor']) ? $params['switcheditor'] : 'y';
	$smarty->assign('comments', $params['comments']);	// 3 probably removable assigns
	$smarty->assign('switcheditor', $params['switcheditor']);
	$smarty->assign('toolbar_section', $params['section']);

	if ($prefs['feature_ajax'] == 'y' && $prefs['ajax_autosave'] == 'y' && $params['_simple'] == 'n' && $params['autosave'] == 'y') {
		// retrieve autosaved content
		require_once("lib/ajax/autosave.php");
		$smarty->loadPlugin('smarty_block_self_link');
		$auto_save_referrer = TikiLib::lib('autosave')->ensureReferrer();
		if (empty($_REQUEST['autosave'])) {
			$_REQUEST['autosave'] = 'n';
		}
		if (TikiLib::lib('autosave')->has_autosave($as_id, $auto_save_referrer)) {
			//  and $params['preview'] == 0 -  why not?
			$auto_saved = str_replace("\n", "\r\n", TikiLib::lib('autosave')->get_autosave($as_id, $auto_save_referrer));
			if ( strcmp($auto_saved, $content) === 0 ) {
				$auto_saved = '';
			}
			if (empty($auto_saved) || (isset($_REQUEST['mode_wysiwyg']) && $_REQUEST['mode_wysiwyg'] === 'y')) {
				// switching modes, ignore auto save
				TikiLib::lib('autosave')->remove_save($as_id, $auto_save_referrer);
			} else {
				$msg = '<div class="mandatory_star"><span class="autosave_message">'.tra('There is an autosaved draft of your recent edits, to use it instead ').'</span>&nbsp;' .
							'<span class="autosave_message_2" style="display:none;">'.tra('If you want the original instead of the autosaved draft of your edits').'</span>' .
							smarty_block_self_link(array( '_ajax'=>'n', '_onclick' => 'toggle_autosaved(\''.$as_id.'\',\''.$auto_save_referrer.'\');return false;'), tra('click here'), $smarty)."</div>";
				$remrepeat = false;
				$auto_save_warning = smarty_block_remarksbox(array( 'type'=>'info', 'title'=>tra('AutoSave')), $msg, $smarty, $remrepeat)."\n";
			}
		}
		$headerlib->add_jq_onready("register_id('$as_id','" . addcslashes($auto_save_referrer, "'") . "');");
		$headerlib->add_js("var autoSaveId = '" . addcslashes($auto_save_referrer, "'") . "';");
	}

	if ( $params['_wysiwyg'] == 'y' && $params['_simple'] == 'n') {
		// TODO cope with wysiwyg and simple

		if ($prefs['feature_jison_wiki_parser'] == 'y') {
			global $wysiwyglib; include_once('lib/ckeditor_tiki/wysiwyglib.php');
			$html .= $wysiwyglib->setUpJisonEditor($params['_is_html'], $as_id, $params, $auto_save_referrer);
            if (!$included) $html .= '<input name="jisonWyisywg" type="hidden" value="true" />';
			$html .= '<div class="wikiedit ui-widget-content" name="'.$params['name'].'" id="'.$as_id.'">' . ($content) . '</div>';
		} else {
			// set up ckeditor
			if (!isset($params['name'])) {
				$params['name'] = 'edit';
			}

			global $wysiwyglib; include_once('lib/ckeditor_tiki/wysiwyglib.php');
			$ckoptions = $wysiwyglib->setUpEditor($params['_is_html'], $as_id, $params, $auto_save_referrer);

			if (!$included) {
				$html .= '<input type="hidden" name="wysiwyg" value="y" />';
			}
			$html .= '<textarea class="wikiedit" name="'.$params['name'].'" id="'.$as_id.'" style="visibility:hidden;';	// missing closing quotes, closed in condition

			if (empty($params['cols'])) {
				$html .= 'width:100%;'. (empty($params['rows']) ? 'height:500px;' : '') .'"';
			} else {
				$html .= '" cols="'.$params['cols'].'"';
			}
			if (!empty($params['rows'])) {
				$html .= ' rows="'.$params['rows'].'"';
			}
			$html .= '>'.htmlspecialchars($content).'</textarea>';

			$headerlib->add_jq_onready(
				'
CKEDITOR.replace( "'.$as_id.'",' . $ckoptions . ');
CKEDITOR.on("instanceReady", function(event) {
	if (typeof ajaxLoadingHide == "function") { ajaxLoadingHide(); }
	this.instances.'.$as_id.'.resetDirty();
});
',
				20
			);	// after dialog tools init (10)
		}

	} else {
		// end of if ( $params['_wysiwyg'] == 'y' && $params['_simple'] == 'n')

		// setup for wiki editor

		$params['rows'] = !empty($params['rows']) ? $params['rows'] : 20;
		$params['cols'] = !empty($params['cols']) ? $params['cols'] : 80;

		$textarea_attributes = '';
		foreach ($params as $k => $v) {
			if ( $k[0] != '_' && ! in_array($k, array('comments', 'switcheditor', 'section', 'area_id', 'autosave'))) {
				$textarea_attributes .= ' '.$k.'="'.$v.'"';
			}
		}
		if (empty($textarea_id)) {
			$smarty->assign('textarea_id', $params['id']);
		}
		$smarty->assign('textarea__toolbars', $params['_toolbars']);
		if ( $textarea_attributes != '' ) {
			$smarty->assign('textarea_attributes', $textarea_attributes);
		}
		$smarty->assignByRef('textareadata', $content);
		$html .= $smarty->fetch('wiki_edit.tpl');

        if (!$included)
            $html .= "\n".'<input type="hidden" name="wysiwyg" value="n" />';

	}	// wiki or wysiwyg

	$js_editconfirm = '';
	$js_editlock = '';

	if ($params['_simple'] == 'n' && $params['comments'] !== 'y') {
		// Display edit time out

		$js_editlock .= "
var editTimeoutSeconds = ".((int) ini_get('session.gc_maxlifetime')).";
var editTimeElapsedSoFar = 0;
var editTimeoutIntervalId;
var editTimerWarnings = 0;
var editTimeoutTipIsDisplayed = false;
var minutes;

// edit timeout warnings
function editTimerTick() {
	editTimeElapsedSoFar++;

	var seconds = editTimeoutSeconds - editTimeElapsedSoFar;
	var edittimeout = \$('#edittimeout');

	if ( edittimeout && seconds <= 300 ) {
		if ( ! editTimeoutTipIsDisplayed ) {
			edittimeout.parents('.rbox:first').fadeIn();
			editTimeoutTipIsDisplayed = true;
		}
		if ( seconds > 0 && seconds % 60 == 0 ) {
			minutes = seconds / 60;
			edittimeout.text( minutes );
		} else if ( seconds <= 0 ) {
			edittimeout.parents('.rbox-data:first').text('".addslashes(tra('Your edit session has expired'))."');
		}
	}

	if (editTimerWarnings == 0 && seconds <= 60 && editorDirty) {
		alert('".addslashes(tra('Your edit session will expire in:')).' 1 '.tra('minute').'. '.
				addslashes(tra('You must PREVIEW or SAVE your work now, to avoid losing your edits.'))."');
		editTimerWarnings++;
	} else if (seconds <= 0) {
		clearInterval(editTimeoutIntervalId);
		editTimeoutIntervalId = 0;
		window.status = '".addslashes(tra('Your edit session has expired'))."';
	} else if (seconds <= 300) {		// don't bother until 5 minutes to go
		window.status = '".addslashes(tra('Your edit session will expire in:'))."' + \" \" + minutes + ':' + ((seconds % 60 < 10) ? '0' : '') + (seconds % 60);
	}
}

\$('document').ready( function() {
	editTimeoutIntervalId = setInterval(editTimerTick, 1000);
	\$('#edittimeout').parents('.rbox:first').hide();
} );

// end edit timeout warnings

";

		$js_editconfirm .= "
\$(window).on('beforeunload', function(e) {
	if (window.needToConfirm) {
		if (typeof CKEDITOR === 'object') {
			for(var ed in CKEDITOR.instances ) {
				if (CKEDITOR.instances.hasOwnProperty(ed)) {
					if ( CKEDITOR.instances[ed].checkDirty()) {
						editorDirty = true;
					}
				}
			}
		}
		if (editorDirty) {
			var msg = '" . addslashes(tra('You are about to leave this page. Changes since your last save may be lost. Are you sure you want to exit this page?')) . "';
			if (e) {
				e.returnValue = msg;
			}
			return msg;
		}
	}
});


\$('document').ready( function() {
	// attach dirty function to all relevant inputs etc for wiki/newsletters, blog, article and trackers (trackers need {teaxtarea} implementing)
	if ('$as_id' === 'editwiki' || '$as_id' === 'blogedit' || '$as_id' === 'body' || '$as_id'.indexOf('area_') > -1) {
		\$(\$('#$as_id').prop('form')).find('input, textarea, select').change( function (event, data) {
			if ($(this).is('select') && '$as_id'.indexOf('area_') > -1 && data !== undefined) {	// tracker dynamic list selects get a change event on load
				return;
			}
			if (!editorDirty) { editorDirty = true; }
		});
	} else {	// modules admin exception, only attach to this textarea, although these should be using _simple mode
		\$('#$as_id').change( function () { if (!editorDirty) { editorDirty = true; } });
	}
});

needToConfirm = true;
editorDirty = ".(isset($_REQUEST["preview"]) && $params['_previewConfirmExit'] == 'y' ? 'true' : 'false').";
";

		if ($prefs['feature_wysiwyg'] == 'y' && $prefs['wysiwyg_optional'] == 'y') {
			$js_editconfirm .= '
function switchEditor(mode, form) {
	window.needToConfirm=false;
	var w;
	if (mode=="wysiwyg") {
		$(form).find("input[name=mode_wysiwyg]").val("y");
		$(form).find("input[name=wysiwyg]").val("y");
	} else {
		$(form).find("input[name=mode_normal]").val("y");
		$(form).find("input[name=wysiwyg]").val("n");
	}
	form.submit();
}';
		}

		if ( $prefs['feature_jquery_ui'] == 'y' && $params['_wysiwyg'] != 'y') {
			// show hidden parent before applying resizable
			$js_editconfirm .= "
	var hiddenParents = \$('#$as_id').parents('fieldset:hidden:last');

	if (hiddenParents.length) { hiddenParents.show(); }";

			if (!isset($_REQUEST['fullcalendar'])) {
				$js_editconfirm .= "
	if (typeof CodeMirror === 'undefined') { //so as not to conflict with CodeMirror resize
		\$('#$as_id')
			.resizable( {
				minWidth: \$('#$as_id').width(),
				minHeight: 50
		});
	}";
			}
			$js_editconfirm .= "
	if (hiddenParents.length) { hiddenParents.hide(); }
";
		}

		if ( $editWarning ) {
			$headerlib->add_js($js_editlock);
		}
		$headerlib->add_js($js_editconfirm);
	}	// end if ($params['_simple'] == 'n')
    $included=true;

	return $auto_save_warning.$html;
}

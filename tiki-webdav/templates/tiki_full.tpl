{* $Id$ *}<!DOCTYPE html 
	PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{if !empty($pageLang)}{$pageLang}{else}{$prefs.language}{/if}" lang="{if !empty($pageLang)}{$pageLang}{else}{$prefs.language}{/if}">
	<head>
{include file='header.tpl'}
	</head>
	<body{html_body_attributes}>

{* Index we display a wiki page here *}
{if $prefs.feature_bidi eq 'y'}
<div dir="rtl">
{/if}
{if $prefs.feature_ajax eq 'y'}
{include file='tiki-ajax_header.tpl'}
{/if}
<div id="main">
	<div id="tiki-center">
		{$mid_data}
		{show_help}
	</div>
</div>
			
{if $prefs.feature_bidi eq 'y'}
</div>
{/if}
{include file='footer.tpl'}
	</body>
</html>

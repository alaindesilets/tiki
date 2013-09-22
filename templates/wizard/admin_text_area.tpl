{* $Id$ *}

<h1>{tr}Set up your Text Area{/tr}</h1>

{tr}Set up your text area environment (Editing and Plugins){/tr}
<div style="float:left; width:60px"><img src="img/icons/large/editing48x48.png" alt="{tr}Set up your Text Area{/tr}"></div>
<div align="left" style="margin-top:1em;">
<fieldset>
	<legend>{tr}General settings{/tr}</legend>
	{preference name=feature_fullscreen}
	{if $isRTL eq false}
		{* Disable Codemirror for RTL languages. It doesn't work. *}
		{preference name=feature_syntax_highlighter}
		{preference name=feature_syntax_highlighter_theme}
	{/if}
	{tr}See also{/tr} <a href="tiki-admin.php?page=textarea&alt=Editing+and+Plugins#content1" target="_blank">{tr}Editing and plugins admin panel{/tr}</a>
</fieldset>
<fieldset>
	<legend>{tr}Plugin preferences{/tr}</legend>
	<img src="img/icons/large/plugins.png" style="float:right" />	
	{preference name=wikipluginprefs_pending_notification}
	<b>{tr}Some recommended plugins{/tr}:</b><br> 
	{preference name=wikiplugin_convene}
	{preference name=wikiplugin_slider}
	{preference name=wikiplugin_slideshow}
	{preference name=wikiplugin_wysiwyg}
	
	{tr}See also{/tr} <a href="tiki-admin.php?page=textarea&alt=Editing+and+Plugins#content2" target="_blank">{tr}Editing and plugins admin panel{/tr}</a>
	
</fieldset>

</div>

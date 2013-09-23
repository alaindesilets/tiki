{* $Id$ *}

<h1>{tr}Set up your Wysiwyg editor{/tr}</h1>
<div style="float:left; width:60px"><img src="img/icons/large/wysiwyg48x48.png" alt="{tr}Set up your Wysiwyg environment{/tr}" /></div>
{tr}You can choose to use by default the 'Compatible' Wiki mode (content in saved in wiki syntax), or the HTML mode{/tr}.
<div align="left" style="margin-top:1em;">
<fieldset>
	<legend>{tr}Wiki editor setup{/tr}</legend>
	{tr}Select the Wysiwyg editor mode{/tr}
	<table style="border:0px;padding-left:20px">
	<tr>
	<td>
	<input type="radio" name="editorType" value="wiki" {if empty($editorType) || $editorType eq 'wiki'}checked="checked"{/if} /> {tr}Compatible Wiki mode{/tr}</td><td> {tr}Use wiki syntax for saved pages{/tr}.<br>
		{tr}This is the most compatible with Tiki functionality and the most stable editor mode{/tr}.<br>
		{tr}Tools and functions in the editor toolbar will be limited{/tr}.<br>
	</td>
	</tr>
	<tr>
	<td></td><td>
	{preference name=wysiwyg_default}
	</td>
	</tr>
	<tr>
	<td><input type="radio" name="editorType" value="html" {if $editorType eq 'html'}checked="checked"{/if} /> {tr}HTML mode{/tr}</td><td>{tr}Use html syntax for saved pages{/tr}.<br>
		{tr}Has best compatibility with inline editing, but loses some wiki related features{/tr}.<br>
		{tr}Lost features include:{/tr} {tr}Problems with SEFURL{/tr}, {tr}SlideShow{/tr}.<br>
		{tr}Full editor toolbar{/tr}.<br>
	</td>
	</tr>
	<tr>
	<td></td><td>
	{preference name=wysiwyg_optional}
	</td>
	</tr>
	</table>
	{preference name=wysiwyg_inline_editing}
	{tr}Inline editing lets the user edit pages without a context switch{/tr}. {tr}The editor is embedded in the wiki page{/tr}.<br>
	{tr}When used on pages in wiki format, a conversion from HTML to Wiki format is required.{/tr}<br>
	<br>
	{tr}See also{/tr} <a href="tiki-admin.php?page=wysiwyg" target="_blank">{tr}Wysiwyg admin panel{/tr}</a>
</fieldset>
<br>
</div>


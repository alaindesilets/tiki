{* $Header: /cvsroot/tikiwiki/tiki/templates/tiki-editpage.tpl,v 1.60 2004-08-26 19:24:16 mose Exp $ *}

{popup_init src="lib/overlib.js"}

{* Check to see if there is an editing conflict *}
{if $editpageconflict == 'y'}
<script language='Javascript' type='text/javascript'>
<!-- //Hide Script
	alert("{tr}This page is being edited by{/tr} {$semUser}. {tr}Proceed at your own peril{/tr}.")
//End Hide Script -->
</script>
{/if}

{if $preview}
{include file="tiki-preview.tpl"}
{/if}
<h1>{tr}Edit{/tr}: {$page|escape}{if $pageAlias ne ''}&nbsp;({$pageAlias|escape}){/if}</h1>
{assign var=area_name value="editwiki"}
{if $page eq 'SandBox'}
<div class="wikitext">
{tr}The SandBox is a page where you can practice your editing skills, use the preview feature to preview the appearance of the page, no versions are stored for this page.{/tr}
</div>
{/if}
<form  enctype="multipart/form-data" method="post" action="tiki-editpage.php" id='editpageform'>
{if $preview}
<input type="submit" class="wikiaction" name="preview" value="{tr}preview{/tr}" />
{if $page neq 'SandBox'}
{if $tiki_p_minor eq 'y'}
<input type="checkbox" name="isminor" value="on" />{tr}Minor{/tr}
{/if}
<input type="submit" class="wikiaction" name="save" value="{tr}save{/tr}" /> &nbsp;&nbsp; <input type="submit" class="wikiaction" name="cancel_edit" value="{tr}cancel edit{/tr}" />
{/if}
{/if}
{if $page_ref_id}
<input type="hidden" name="page_ref_id" value="{$page_ref_id}" />
{/if}
{if $current_page_id}
<input type="hidden" name="current_page_id" value="{$current_page_id}" />
{/if}
{if $add_child}
<input type="hidden" name="add_child" value="true" />
{/if}
<table class="normal">

{if $tiki_p_view_categories eq 'y'}
{include file=categorize.tpl}
{/if}
{include file=structures.tpl}

{if $feature_wiki_templates eq 'y' and $tiki_p_use_content_templates eq 'y'}
<tr class="formcolor"><td>{tr}Apply template{/tr}:</td><td>
<select name="templateId" onchange="javascript:document.getElementById('editpageform').submit();">
<option value="0">{tr}none{/tr}</option>
{section name=ix loop=$templates}
<option value="{$templates[ix].templateId|escape}">{tr}{$templates[ix].name}{/tr}</option>
{/section}
</select>
</td></tr>
{/if}

{if $feature_multilingual eq 'y'}
<tr class="formcolor"><td>{tr}Language{/tr}:</td><td>
<select name="lang">
<option value="">{tr}Unknown{/tr}</option>
{section name=ix loop=$languages}
<option value="{$languages[ix].value|escape}"{if $lang eq $languages[ix].value} selected="selected"{/if}>{$languages[ix].name}</option>
{/section}
</select>
</td></tr>
{*<tr class="formcolor"><td>{tr}Is a translation of this page:{/tr}</td><td><input style="width:95%;" type="text" name="translation" value="{$translation|escape}" /></td></tr>*}
{/if}

{if $feature_smileys eq 'y'}
<tr class="formcolor"><td>{tr}Smileys{/tr}:</td><td>
{include file="tiki-smileys.tpl" area_name='editwiki'}
</td>
</tr>
{/if}
{if $feature_wiki_description eq 'y'}
<tr class="formcolor"><td>{tr}Description{/tr}:</td><td><input style="width:95%;" class="wikitext" type="text" name="description" value="{$description|escape}" /></td></tr>
{/if}
<tr class="formcolor"><td>{tr}Edit{/tr}:<br /><br />
{include file="textareasize.tpl" area_name='editwiki' formId='editpageform'}<br /><br />
{include file=tiki-edit_help_tool.tpl}
</td>
<td>
<textarea id='editwiki' class="wikiedit" name="edit" rows="{$rows}" cols="{$cols}">{$pagedata|escape}</textarea>
<input type="hidden" name="rows" value="{$rows}"/>
<input type="hidden" name="cols" value="{$cols}"/>
</td></tr>
{if $feature_wiki_footnotes eq 'y'}
{if $user}
<tr class="formcolor"><td>{tr}Footnotes{/tr}:</td><td><textarea name="footnote" rows="8" cols="42" style="width:95%;" >{$footnote|escape}</textarea></td></tr>
{/if}
{/if}

{if $page ne 'SandBox'}
<tr class="formcolor"><td>{tr}Comment{/tr}:</td><td><input style="width:90%;" class="wikitext" type="text" name="comment" value="{$commentdata|escape}" /></td></tr>
{/if}
{if $wiki_feature_copyrights  eq 'y'}
<tr class="formcolor"><td>{tr}Copyright{/tr}:</td><td>
<table border="0">
<tr class="formcolor"><td>{tr}Title:{/tr}</td><td><input size="40" class="wikitext" type="text" name="copyrightTitle" value="{$copyrightTitle|escape}" /></td></tr>
<tr class="formcolor"><td>{tr}Year:{/tr}</td><td><input size="4" class="wikitext" type="text" name="copyrightYear" value="{$copyrightYear|escape}" /></td></tr>
<tr class="formcolor"><td>{tr}Authors:{/tr}</td><td><input size="40" class="wikitext" name="copyrightAuthors" type="text" value="{$copyrightAuthors|escape}" /></td></tr>
</table>
</td></tr>
{/if}
{if $feature_wiki_allowhtml eq 'y' and $tiki_p_use_HTML eq 'y'}
<tr class="formcolor"><td>{tr}Allow HTML{/tr}: </td><td><input type="checkbox" name="allowhtml" {if $allowhtml eq 'y'}checked="checked"{/if}/></td></tr>
{/if}
{if $wiki_spellcheck eq 'y'}
<tr class="formcolor"><td>{tr}Spellcheck{/tr}: </td><td><input type="checkbox" name="spellcheck" {if $spellcheck eq 'y'}checked="checked"{/if}/></td></tr>
{/if}

<tr class="formcolor">
  <td>{tr}Import HTML{/tr}:</td>
  <td>
    <input class="wikitext" type="text" name="suck_url" value="{$suck_url|escape}" />&nbsp;
  </td>
</tr>
<tr class="formcolor">
  <td>&nbsp;</td>
  <td>
    <input type="submit" class="wikiaction" name="do_suck" value="{tr}Import{/tr}" />&nbsp;
    <input type="checkbox" name="parsehtml" {if $parsehtml eq 'y'}checked="checked"{/if}/>&nbsp;
    {tr}Try to convert HTML to wiki{/tr}
  </td>
</tr>
{if $tiki_p_admin_wiki eq 'y'}
<tr class="formcolor"><td>{tr}Import page{/tr}:</td><td>
<input type="hidden" name="MAX_FILE_SIZE" value="1000000000" />
<input name="userfile1" type="file" />
<a href="tiki-export_wiki_pages.php?page={$page|escape:"url"}&amp;all=1" class="link">{tr}export all versions{/tr}</a>
</td></tr>
{/if}
{if $feature_wiki_pictures eq 'y' and $tiki_p_upload_picture eq 'y'}
<tr class="formcolor"><td>{tr}Upload picture{/tr}</td><td>
<input type="hidden" name="MAX_FILE_SIZE" value="1000000000" />
<input type="hidden" name="hasAlreadyInserted" value="" />
<input type="hidden" name="prefix" value="/img/wiki_up/{if $tikidomain}{$tikidomain}/{/if}" />
<input name="picfile1" type="file" onchange="javascript:insertImg('editwiki','picfile1','hasAlreadyInserted')"/>
</td></tr>
{/if}
{if $feature_wiki_icache eq 'y'}
<tr class="formcolor"><td>{tr}Cache{/tr}</td><td>
    <select name="wiki_cache">
    <option value="0" {if $wiki_cache eq 0}selected="selected"{/if}>0 ({tr}no cache{/tr})</option>
    <option value="60" {if $wiki_cache eq 60}selected="selected"{/if}>1 {tr}minute{/tr}</option>
    <option value="300" {if $wiki_cache eq 300}selected="selected"{/if}>5 {tr}minutes{/tr}</option>
    <option value="600" {if $wiki_cache eq 600}selected="selected"{/if}>10 {tr}minute{/tr}</option>
    <option value="900" {if $wiki_cache eq 900}selected="selected"{/if}>15 {tr}minutes{/tr}</option>
    <option value="1800" {if $wiki_cache eq 1800}selected="selected"{/if}>30 {tr}minute{/tr}</option>
    <option value="3600" {if $wiki_cache eq 3600}selected="selected"{/if}>1 {tr}hour{/tr}</option>
    <option value="7200" {if $wiki_cache eq 7200}selected="selected"{/if}>2 {tr}hours{/tr}</option>
    </select> 
</td></tr>
{/if}

<tr class="formcolor"><td>&nbsp;</td><td><input type="hidden" name="page" value="{$page|escape}" />
<input type="submit" class="wikiaction" name="preview" value="{tr}preview{/tr}" /></td></tr>

{if $feature_antibot eq 'y' && $anon_user eq 'y'}
<tr><td class="formcolor">{tr}Anti-Bot verification code{/tr}:</td>
<td class="formcolor"><img src="tiki-random_num_img.php" alt='{tr}Random Image{/tr}'/></td></tr>
<tr><td class="formcolor">{tr}Enter the code you see above{/tr}:</td>
<td class="formcolor"><input type="text" maxlength="8" size="8" name="antibotcode" /></td></tr>
{/if}

{if $wiki_feature_copyrights  eq 'y'}
<tr class="formcolor"><td>{tr}License{/tr}:</td><td><a href="tiki-index.php?page={$wikiLicensePage}">{tr}{$wikiLicensePage}{/tr}</a></td></tr>
{if $wikiSubmitNotice neq ""}
<tr class="formcolor"><td>{tr}Important{/tr}:</td><td><b>{tr}{$wikiSubmitNotice}{/tr}</b></td>
{/if}
{/if}
{if $page neq 'SandBox' or $tiki_p_admin eq 'y'}
<tr class="formcolor"><td>&nbsp;</td><td>
{if $tiki_p_minor eq 'y' && $page neq 'SandBox'}
<input type="checkbox" name="isminor" value="on" />{tr}Minor{/tr}
{/if}
<input type="submit" class="wikiaction" name="save" value="{tr}save{/tr}" /> &nbsp;&nbsp;
{if $page neq 'SandBox'}
<input type="submit" class="wikiaction" name="cancel_edit" value="{tr}cancel edit{/tr}" />
{/if}
{/if}
</td></tr>
</table>
</form>
<br />
{include file=tiki-edit_help.tpl}

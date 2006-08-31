{* $Header: /cvsroot/tikiwiki/_mods/modules/top_page_editors/mod-top_page_editors.tpl,v 1.1 2006-08-31 12:49:30 sylvieg Exp $ *}
{eval assign="ld" var="ld_page_editors`$nb_mod_top_page_editors`"}

{if $nonums eq 'y'}
{eval var="{tr}`$module_rows` Top Page Editors{/tr}" assign="title1"}
{else}
{eval var="{tr}Top Page Editors{/tr}" assign="title1"}
{/if}

{if $lastdays == 1}
{eval var="<br />{tr}(This last day){/tr}" assign="title2"}
{elseif $lastdays > 1}
{eval var="<br />{tr}(These last $lastdays days){/tr}" assign="title2"}
{else}
{eval var=" " assign="title2"}
{/if}
{eval var="`$title1``$title2`" assign="tpl_module_title"} 
{tikimodule title=$tpl_module_title name="top_page_editors"}

{if $lastdaysChoice eq 'y'}
<div class="box-choice">
<form method="post" action="{$url}" name="submit_{$ld}">
{tr}Last days:{/tr}&nbsp;
<select name="{$ld}" onchange="submit_{$ld}.submit()">
<option value="" selected="selected">{tr}All{/tr}</option>
{section name=ix loop=$lastdaysList}
<option value="{$lastdaysList[ix]}" {if $lastdays eq "$lastdaysList[ix]"}selected="selected"{/if}>{$lastdaysList[ix]}</option>
{/section}
</select>
<br />
</form>
</div>
{/if}

<table  border="0" cellpadding="0" cellspacing="0">
{section name=ix loop=$editors}
<tr>
{if $nonums != 'y'}<td valign="top" class="module">{$smarty.section.ix.index_next})&nbsp;</td>{/if}
<td class="module">{$editors[ix].user|userlink} <span class="module_text_small"> -  {$editors[ix].nb} {tr}edits{/tr}</span></td>
</tr>
{/section}
</table>
{/tikimodule}

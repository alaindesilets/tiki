{if $showtitle eq 'y'}<div class="pagetitle">{$tracker_info.name}</div>{/if}
{if $showdesc eq 'y'}<div class="wikitext">{$tracker_info.description}</div>{/if}

{if $cant_pages > 1 or $tr_initial}
<div align="center">
{section name=ini loop=$initials}
{if $tr_initial and $initials[ini] eq $tr_initial}
<span class="button2"><span class="linkbuton">{$initials[ini]|capitalize}</span></span> . 
{else}
<a href="{$smarty.server.PHP_SELF}{if $query_string}?{$query_string}&amp;{else}?{/if}tr_initial={$initials[ini]}{if $tr_sort_mode}&amp;tr_sort_mode={$tr_sort_mode}{/if}&amp;tr_offset=0" class="prevnext">{$initials[ini]}</a> . 
{/if}
{/section}
<a href="{$smarty.server.PHP_SELF}{if $query_string}?{$query_string}&amp;{else}?{/if}tr_initial={if $tr_sort_mode}&amp;tr_sort_mode={$tr_sort_mode}{/if}&amp;tr_offset=0" class="prevnext">{tr}All{/tr}</a>
</div>
{/if}

<table class="normal">
<tr>
{foreach key=jx item=ix from=$fields}
{if $ix.isPublic eq 'y' and $ix.isHidden ne 'y' and $ix.type ne 'x' and $ix.type ne 'h'}
{if $ix.type eq 'l'}
<td class="heading auto">{$ix.name|default:"&nbsp;"}</td>
{elseif $ix.type eq 's' and $ix.name eq "{tr}Rating{/tr}"}
{if $tiki_p_tracker_view_ratings eq 'y'}
<td class="heading auto"{if $tiki_p_tracker_vote_ratings eq 'y'} colspan="2"{/if}>
<a class="tableheading" href="{$smarty.server.PHP_SELF}{if $query_string}?{$query_string}{else}?{/if}{if $tr_offset}&amp;tr_offset={$tr_offset}{/if}&amp;tr_sort_mode=f_{if 
	$tr_sort_mode eq 'f_'|cat:$ix.fieldId|cat:'_asc'}{$ix.fieldId}_desc{else}{$ix.fieldId}_asc{/if}">{$ix.name|default:"&nbsp;"}</a></td>
{/if}
{else}
<td class="heading auto"{if $ix.type eq 's' and $ix.name eq "{tr}Rating{/tr}"} colspan="2"{/if}>
<a class="tableheading" href="{$smarty.server.PHP_SELF}{if $query_string}?{$query_string}{else}?{/if}{if $tr_offset}&amp;tr_offset={$tr_offset}{/if}&amp;tr_sort_mode=f_{if 
	$tr_sort_mode eq 'f_'|cat:$ix.fieldId|cat:'_asc'}{$ix.fieldId}_desc{else}{$ix.fieldId}_asc{/if}">{$ix.name|default:"&nbsp;"}</a></td>
{/if}
{/if}
{/foreach}
{if $tracker_info.showCreated eq 'y'}
<td class="heading"><a class="tableheading" href="{$smarty.server.PHP_SELF}{if $query_string}?{$query_string}{else}?{/if}{if $tr_offset}&amp;tr_offset={$tr_offset}{/if}&amp;tr_sort_mode={if 
	$tr_sort_mode eq 'created_desc'}created_asc{else}created_desc{/if}">{tr}created{/tr}</a></td>
{/if}
{if $tracker_info.showLastModif eq 'y'}
<td class="heading"><a class="tableheading" href="{$smarty.server.PHP_SELF}{if $query_string}?{$query_string}{else}?{/if}{if $tr_offset}&amp;tr_offset={$tr_offset}{/if}&amp;tr_sort_mode={if 
	$tr_sort_mode eq 'lastModif_desc'}lastModif_asc{else}lastModif_desc{/if}">{tr}lastModif{/tr}</a></td>
{/if}
{if $tracker_info.useComments eq 'y' and $tracker_info.showComments eq 'y'}
<td class="heading" width="5%">{tr}coms{/tr}</td>
{/if}
{if $tracker_info.useAttachments eq 'y' and  $tracker_info.showAttachments eq 'y'}
<td class="heading" width="5%">{tr}atts{/tr}</td>
{/if}
</tr>

{cycle values="odd,even" print=false}
{section name=user loop=$items}
<tr class="{cycle}">

{section name=ix loop=$items[user].field_values}

{if $items[user].field_values[ix].isPublic eq 'y' and $items[user].field_values[ix].isHidden ne 'y' and $items[user].field_values[ix].type ne 'x' and $items[user].field_values[ix].type ne 'h'}
{if $items[user].field_values[ix].type eq 'l'}
<td class="auto">
{foreach key=tid item=tlabel from=$items[user].field_values[ix].links}
<div><a href="tiki-view_tracker_item.php?trackerId={$items[user].field_values[ix].trackerId}&amp;itemId={$tid}" class="link">{$tlabel}</a></div>
{/foreach}
</td>
{elseif $showlinks eq 'y' and $items[user].field_values[ix].isMain eq 'y' or ($items[user].field_values[ix].linkId and $items[user].field_values[ix].trackerId)}
<td class="auto">

{if $items[user].field_values[ix].linkId and $items[user].field_values[ix].trackerId}
<a href="tiki-view_tracker_item.php?trackerId={$items[user].field_values[ix].trackerId}&amp;itemId={$items[user].field_values[ix].linkId}" class="link">

{elseif $tiki_p_view_trackers eq 'y' or $tiki_p_modify_tracker_items eq 'y' or $tiki_p_comment_tracker_items eq 'y'}
<a class="tablename" href="tiki-view_tracker_item.php?trackerId={$items[user].field_values[ix].trackerId}&amp;itemId={$items[user].itemId}&amp;show=view">
{/if}

{if $items[user].field_values[ix].type eq 'f'}
{$items[user].field_values[ix].value|tiki_short_datetime|default:"&nbsp;"}

{elseif $items[user].field_values[ix].type eq 'c'}
[ {$items[user].field_values[ix].value|replace:"y":"{tr}Yes{/tr}"|replace:"n":"{tr}No{/tr}"|default:"{tr}No{/tr}"} ]

{elseif $items[user].field_values[ix].type eq 'i'}
<img src="{$items[user].field_values[ix].value}" alt="" />

{else}
{$items[user].field_values[ix].value|default:"&nbsp;"}

{/if}

{if $tiki_p_view_trackers eq 'y' or $tiki_p_modify_tracker_items eq 'y' or $tiki_p_comment_tracker_items eq 'y' or $items[user].field_values[ix].linkId}</a>{/if}
</td>
{else}
{if $items[user].field_values[ix].type eq 'f' or $items[user].field_values[ix].type eq 'j'}
<td class="auto">
{$items[user].field_values[ix].value|tiki_short_datetime|default:"&nbsp;"}
</td>

{elseif $items[user].field_values[ix].type eq 'c'}
<td class="auto">
{$items[user].field_values[ix].value|replace:"y":"{tr}Yes{/tr}"|replace:"n":"{tr}No{/tr}"|default:"{tr}No{/tr}"}
</td>

{elseif $items[user].field_values[ix].type eq 's' and $items[user].field_values[ix].name eq "{tr}Rating{/tr}" and $tiki_p_tracker_view_ratings eq 'y'}
<td class="auto">
{$items[user].field_values[ix].value|default:"-"}</td>
{if $tiki_p_tracker_vote_ratings eq 'y'}
<td class="auto" nowrap="nowrap">
<span class="button2">
{section name=i loop=$items[user].field_values[ix].options_array}
{if $items[user].field_values[ix].options_array[i] eq $items[user].my_rate}
<b class="linkbut highlight">{$items[user].field_values[ix].options_array[i]}</b>
{else}
<a href="{$smarty.server.PHP_SELF}{if $query_string}?{$query_string}{else}?{/if}&amp;trackerId={$items[user].trackerId}&amp;itemId={$items[user].itemId}&amp;fieldId={$items[user].field_values[ix].fieldId}&amp;rate_{$items[user].trackerId}={$items[user].field_values[ix].options_array[i]}" 
class="linkbut">{$items[user].field_values[ix].options_array[i]}</a>
{/if}
{/section}
</span>
</td>
{/if}

{elseif $items[user].field_values[ix].type ne 'x' and $items[user].field_values[ix].type ne 'h'}
<td class="auto">
{$items[user].field_values[ix].value|default:"&nbsp;"}
</td>
{/if}
{/if}

{/if}
{/section}

{if $tracker_info.showCreated eq 'y'}
<td>{$items[user].created|tiki_short_datetime}</td>
{/if}
{if $tracker_info.showLastModif eq 'y'}
<td>{$items[user].lastModif|tiki_short_datetime}</td>
{/if}
{if $tracker_info.useComments eq 'y' and $tracker_info.showComments eq 'y'}
<td  style="text-align:center;">{$items[user].comments}</td>
{/if}
{if $tracker_info.useAttachments eq 'y' and $tracker_info.showAttachments eq 'y'}
<td  style="text-align:center;"><a href="tiki-view_tracker_item.php?trackerId={$trackerId}&amp;itemId={$items[user].itemId}&amp;show=att" 
link="{tr}List Attachments{/tr}"><img src="img/icons/folderin.gif" border="0" alt="{tr}List Attachments{/tr}" 
/></a>{$items[user].attachments}</td>
{/if}
</tr>
{/section}
</table>

{if $cant_pages > 1 or $tr_initial}
<br />
<div align="center" class="mini">
{if $tr_prev_offset >= 0}
[<a class="prevnext" href="{$smarty.server.PHP_SELF}{
	if $query_string}?{$query_string}&amp;{else}?{/if}{
	if $tr_initial}tr_initial={$tr_initial}{/if}{
	if $tr_prev_offset}&amp;tr_offset={$tr_prev_offset}{/if}{
	if $tr_sort_mode}&amp;tr_sort_mode=f_{$tr_sort_mode}{/if}"
>{tr}prev{/tr}</a>]&nbsp;
{/if}
{tr}Page{/tr}: {$actual_page}/{$cant_pages}
{if $tr_next_offset >= 0}
&nbsp;[<a class="prevnext" href="{$smarty.server.PHP_SELF}{
	if $query_string}?{$query_string}&amp;{else}?{/if}{
	if $tr_initial}tr_initial={$tr_initial}{/if}{
	if $tr_next_offset}&amp;tr_offset={$tr_next_offset}{/if}{
	if $tr_sort_mode}&amp;tr_sort_mode=f_{$tr_sort_mode}{/if}"
>{tr}next{/tr}</a>]
{/if}
{if $direct_pagination eq 'y'}
<br />
{section loop=$cant_pages name=foo}
{assign var=selector_offset value=$smarty.section.foo.index|times:$maxRecords}
<a class="prevnext" href="{$smarty.server.PHP_SELF}{if $query_string}?{$query_string}&amp;{else}?{/if}{
	if $tr_initial}tr_initial={$tr_initial}{/if}
	&amp;tr_offset={$selector_offset}{
	if $tr_sort_mode}&amp;tr_sort_mode={$sort_mode}{/if}">
{$smarty.section.foo.index_next}</a>&nbsp;
{/section}
{/if}
</div>
{/if}


{popup_init src="lib/overlib.js"}
{*Smarty template*}
<a class="pagetitle" href="tiki-admin_chart_items.php">{tr}Admin chart items{/tr}</a>
<br/><br/>
[<a class="link" href="tiki-admin_charts.php">{tr}charts{/tr}</a>]
[<a class="link" href="tiki-admin_charts.php?chartId={$chartId}">{tr}edit chart{/tr}</a>]
[<a class="link" href="tiki-view_chart.php?chartId={$chartId}">{tr}view{/tr}</a>]
<h3>{tr}Add or edit an item{/tr} <a class="link" href="tiki-admin_chart_items.php?chartId=$chartId&amp;where={$where}&amp;offset={$offset}&amp;sort_mode={$sort_mode}&amp;itemId=0">new</a>
</h3>
<form action="tiki-admin_chart_items.php" method="post">
<input type="hidden" name="chartId" value="{$chartId}" />
<input type="hidden" name="itemId" value="{$info.itemId}" />
<input type="hidden" name="offset" value="{$offset}" />
<input type="hidden" name="where" value="{$where}" />
<input type="hidden" name="find" value="{$find}" />
<input type="hidden" name="sort_mode" value="{$sort_mode}" />
<table class="normal">
	<tr>
		<td class="formcolor">{tr}Title{/tr}</td>
		<td class="formcolor"><input type="text" maxlength="250" name="title" value="{$info.title}" /></td>
	</tr>
	
	<tr>
		<td class="formcolor">{tr}Description{/tr}</td>
		<td class="formcolor"><textarea rows="4" cols="40" name="description">{$info.description}</textarea></td>
	</tr>
	
	<tr>
		<td class="formcolor">{tr}URL{/tr}</td>
		<td class="formcolor"><input type="text" maxlength="250" name="URL" value="{$info.URL}" /></td>
	</tr>

	<tr>
		<td class="formcolor">&nbsp;</td>
		<td class="formcolor"><input type="submit" name="save" value="{if $itemId > 0}{tr}update{/tr}{else}{tr}create{/tr}{/if}" /></td>
	</tr>
</table>
</form>


<h3>{tr}Chart items{/tr}</h3>
<form action="tiki-admin_chart_items.php" method="post">
<input type="hidden" name="offset" value="{$offset}" />
<input type="hidden" name="chartId" value="{$chartId}" />
<input type="hidden" name="sort_mode" value="{$sort_mode}" />
{tr}Find{/tr}:<input size="8" type="text" name="find" value="{$find}" />
</form>
<form action="tiki-admin_chart_items.php" method="post">
<input type="hidden" name="offset" value="{$offset}" />
<input type="hidden" name="chartId" value="{$chartId}" />
<input type="hidden" name="find" value="{$find}" />
<input type="hidden" name="where" value="{$where}" />
<input type="hidden" name="sort_mode" value="{$sort_mode}" />
<table class="normal">
<tr>
<td width="7%" class="heading"><input type="submit" name="delete" value="{tr}x{/tr} " /></td>
<td class="heading" ><a class="tableheading" href="{if $sort_mode eq 'title_desc'}{sameurl sort_mode="title_asc"}{else}{sameurl sort_mode="title_desc"}{/if}">{tr}Title{/tr}</a></td>
<td class="heading" ><a class="tableheading" href="{if $sort_mode eq 'URL_desc'}{sameurl sort_mode="URL_asc"}{else}{sameurl sort_mode="URL_desc"}{/if}">{tr}URL{/tr}</a></td>
</tr>
{cycle values="odd,even" print=false}
{section name=ix loop=$items}
<tr>
	<td class="{cycle advance=false}">
		<input type="checkbox" name="item[{$items[ix].itemId}]" />
	</td>
	<td class="{cycle advance=false}">
		<a class="link" href="{sameurl itemId=$items[ix].itemId}">{$items[ix].title}</a>
	</td>
	<td class="{cycle advance=false}">
		{$items[ix].URL}
	</td>
</tr>
{sectionelse}
<tr>
	<td class="{cycle advance=false}" colspan="5">
	{tr}No items defined yet{/tr}
	</td>
</tr>	
{/section}
</table>
</form>

<div class="mini">
<div align="center">
{if $prev_offset >= 0}
[<a class="prevnext" href="{sameurl offset=$prev_offset}">{tr}prev{/tr}</a>]&nbsp;
{/if}
{tr}Page{/tr}: {$actual_page}/{$cant_pages}
{if $next_offset >= 0}
&nbsp;[<a class="prevnext" href="{sameurl offset=$next_offset}">{tr}next{/tr}</a>]
{/if}
{if $direct_pagination eq 'y'}
<br/>
{section loop=$cant_pages name=foo}
{assign var=selector_offset value=$smarty.section.foo.index|times:$maxRecords}
<a class="prevnext" href="{sameurl offset=$selector_offset}">
{$smarty.section.foo.index_next}</a>&nbsp;
{/section}
{/if}
</div>
</div> 
 


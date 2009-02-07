{* $Id$ *}
{title help="Polls" admpage="polls"}{tr}Admin Polls{/tr}{/title}

<div class="navbar">
	{button href="tiki-admin_polls.php?setlast=1" _text="{tr}Set last poll as current{/tr}"}
	{button href="tiki-admin_polls.php?closeall=1" _text="{tr}Close all polls but last{/tr}"}
	{button href="tiki-admin_polls.php?activeall=1" _text="{tr}Activate all polls{/tr}"}
</div>

<h2>{if $pollId eq '0'}{tr}Create poll{/tr}{else}{tr}Edit poll{/tr}{/if}</h2>

<form action="tiki-admin_polls.php" method="post">
<input type="hidden" name="pollId" value="{$pollId|escape}" />
<table class="normal">
<tr><td class="formcolor">{tr}Title{/tr}:</td><td class="formcolor"><input type="text" name="title" value="{$title|escape}" /></td></tr>
<tr><td class="formcolor">{tr}Active{/tr}:</td><td class="formcolor">
<select name="active">
<option value='a' {if $active eq 'a'}selected="selected"{/if}>{tr}active{/tr}</option>
<option value='c' {if $active eq 'c'}selected="selected"{/if}>{tr}current{/tr}</option>
<option value='x' {if $active eq 'x'}selected="selected"{/if}>{tr}closed{/tr}</option>
<option value='t' {if $active eq 't'}selected="selected"{/if} style="border-top:1px solid black;">{tr}template{/tr}</option>
<option value='o' {if $active eq 'o'}selected="selected"{/if}>{tr}object{/tr}</option>
</select>
</td></tr>
<tr>
<td class="formcolor">{tr}Options:{/tr}</td>
<td>
	<div><a href="javascript://toggle quick options" onclick="pollsToggleQuickOptions()">{tr}Toggle Quick Options{/tr}</a></div>
	<div id="tikiPollsQuickOptions" style="display: none">
		<div id="tikiPollsOptions">
			{section name=opt loop=$options}
				<div><input type="hidden" name="optionsId[]" value="{$options[opt].optionId}" />
				<input type="text" name="options[]" value="{$options[opt].title}" /></div>
			{/section}
			<div><input type="text" name="options[]" /></div>
		</div>
		<a href="javascript://Add Option"
			onclick="pollsAddOption()">{tr}Add Option{/tr}</a>
		{remarksbox type="tip" title="{tr}Tip{/tr}"}{tr}Leave box empty for deleting an option.{/tr}{/remarksbox}
	</div>
</td>
</tr>
{include file=categorize.tpl}
<tr><td class="formcolor">{tr}PublishDate{/tr}:</td><td class="formcolor">
{html_select_date time=$publishDate end_year="+1" field_order=$prefs.display_field_order} {tr}at{/tr} {html_select_time time=$publishDate display_seconds=false}
</td></tr>
<tr><td class="formcolor">&nbsp;</td><td class="formcolor"><input type="submit" name="save" value="{tr}Save{/tr}" /></td></tr>
</table>
</form>

<h2>{tr}Polls{/tr}</h2>
{if $channels or ($find ne '')}
  {include file='find.tpl' _sort_mode='y'}
{/if}
<table class="normal">
<tr>
<th>{self_link _sort_arg='sort_mode' _sort_field='pollId' title="{tr}ID{/tr}"}{tr}ID{/tr}{/self_link}</th>
<th>{self_link _sort_arg='sort_mode' _sort_field='title' title="{tr}Title{/tr}"}{tr}Title{/tr}{/self_link}</th>
{if $prefs.poll_list_categories eq 'y'}<th>{tr}Categories{/tr}</th>{/if}
{if $prefs.poll_list_objects eq 'y'}<th>{tr}Objects{/tr}</th>{/if}
<th>{self_link _sort_arg='sort_mode' _sort_field='active' title="{tr}Active{/tr}"}{tr}Active{/tr}{/self_link}</th>
<th>{self_link _sort_arg='sort_mode' _sort_field='votes' title="{tr}Votes{/tr}"}{tr}Votes{/tr}{/self_link}</th>
<th>{self_link _sort_arg='sort_mode' _sort_field='publishDate' title="{tr}Publish{/tr}"}{tr}Publish{/tr}{/self_link}</th>
<th>{tr}Options{/tr}</th>
<th>{tr}Action{/tr}</th>
</tr>
{cycle values="odd,even" print=false}
{section name=user loop=$channels}
<tr>
<td class="{cycle advance=false}">{$channels[user].pollId}</td>
<td class="{cycle advance=false}"><a class="tablename" href="tiki-poll_results.php?pollId={$channels[user].pollId}">{$channels[user].title}</a></td>
{if $prefs.poll_list_categories eq 'y'}<td class="{cycle advance=false}">
{section name=cat loop=$channels[user].categories}{$channels[user].categories[cat].name}{if !$smarty.section.cat.last}<br />{/if}{/section}</td>{/if}
{if $prefs.poll_list_objects eq 'y'}<td class="{cycle advance=false}">{section name=obj loop=$channels[user].objects}<a href="{$channels[user].objects[obj].href}">{$channels[user].objects[obj].name}</a>{if !$smarty.section.obj.last}<br />{/if}{/section}</td>{/if}
<td class="{cycle advance=false}">{$channels[user].active}</td>
<td class="{cycle advance=false}">{$channels[user].votes}</td>
<td class="{cycle advance=false}">{$channels[user].publishDate|tiki_short_datetime}</td>
<td class="{cycle advance=false}">{$channels[user].options}</td>
<td class="{cycle}">
   {self_link pollId=$channels[user].pollId}{icon _id=page_edit}{/self_link}
   <a class="link" href="tiki-admin_poll_options.php?pollId={$channels[user].pollId}" title="{tr}Options{/tr}">{icon _id=table alt="{tr}Options{/tr}"}</a>
   <a class="link" href="tiki-poll_results.php?pollId={$channels[user].pollId}">{icon _id="chart_curve" alt="{tr}Results{/tr}"}</a>
   <a class="link" href="tiki-admin_polls.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;remove={$channels[user].pollId}" title="{tr}Delete{/tr}">{icon _id=cross alt="{tr}Delete{/tr}"}</a>
</td>
</tr>
{sectionelse}
<tr><td colspan="{if $prefs.feature_poll_categories eq 'y'}8{else}7{/if}" class="odd">{tr}No records found{/tr}</td></tr>
{/section}
</table>

{pagination_links cant=$cant_pages step=$prefs.maxRecords offset=$offset }{/pagination_links}

<h2>{tr}Add poll to pages{/tr}</h2>
<form action="tiki-admin_polls.php" method="post">
<table class="normal">
<tr><td class="formcolor">
{tr}Poll{/tr}</td><td class="formcolor">
<select name="poll_template">
{section name=ix loop=$channels}
{if $channels[ix].active eq 't'}
<option value="{$channels[ix].pollId|escape}"{if $smarty.section.ix.first} selected="selected"{/if}>{tr}{$channels[ix].title}{/tr}</option>
{/if}
{/section}
</select></td></tr>
<tr><td class="formcolor">{tr}Title{/tr}</td><td class="formcolor"><input type="text" name="poll_title" /></td></tr>
<tr><td class="formcolor">
{tr}Wiki pages{/tr}</td><td class="formcolor">
<select name="pages[]" multiple="multiple" size="20">
{section name=ix loop=$listPages}
<option value="{$listPages[ix].pageName|escape}">{tr}{$listPages[ix].pageName}{/tr}</option>
{/section}
</select>
{remarksbox type="tip" title="{tr}Tip{/tr}"}{tr}Use Ctrl+Click to select multiple pages.{/tr}{/remarksbox}
</td></tr>
<tr><td class="formcolor">{tr}Lock the pages{/tr}</td><td class="formcolor"><input type="checkbox" name="locked" /></td></tr>
<tr><td class="formcolor"></td><td class="formcolor"><input type="submit" name="addPoll" value="{tr}Add{/tr}" /></td></tr></table>
</form>

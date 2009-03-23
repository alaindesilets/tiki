<!-- START of {$smarty.template} -->{popup_init src="lib/overlib.js"}

{title help="Charts"}{tr}Admin charts{/tr}{/title}

<h2>{tr}Add or edit a chart{/tr} <a class="link" href="tiki-admin_charts.php?where={$where}&amp;offset={$offset}&amp;sort_mode={$sort_mode}&amp;chartId=0">{tr}New{/tr}</a>
</h2>
<form action="tiki-admin_charts.php" method="post">
<input type="hidden" name="chartId" value="{$info.chartId|escape}" />
<input type="hidden" name="offset" value="{$offset|escape}" />
<input type="hidden" name="where" value="{$where|escape}" />
<input type="hidden" name="find" value="{$find|escape}" />
<input type="hidden" name="sort_mode" value="{$sort_mode|escape}" />
<table class="normal">
	<tr>
		<td class="formcolor">{tr}Title{/tr}</td>
		<td class="formcolor"><input type="text" maxlength="250" name="title" value="{$info.title|escape}" /></td>
	</tr>
	
	<tr>
		<td class="formcolor">{tr}Description{/tr}</td>
		<td class="formcolor"><textarea rows="4" cols="40" name="description">{$info.description|escape}</textarea></td>
	</tr>
	<tr>
		<td class="formcolor">{tr}Active{/tr}</td>
		<td class="formcolor"><input type="checkbox" name="isActive" {if $info.isActive eq 'y'}checked="checked"{/if} /></td>
	</tr>
	<tr>
		<td class="formcolor">{tr}Users can vote for only one item from this chart per period{/tr}</td>
		<td class="formcolor"><input id='chksc' type="checkbox" name="singleChartVotes" {if $info.singleChartVotes eq 'y'}checked="checked"{/if} /></td>
	</tr>
	<tr>
		<td class="formcolor">{tr}Prevent users from voting for the same item more than once{/tr}</td>
		<td class="formcolor"><input id='chksi' type="checkbox" name="singleItemVotes" {if $info.singleItemVotes eq 'y'}checked="checked"{/if} /></td>
	</tr>	

	<tr>
		<td class="formcolor">{tr}Users can suggest new items{/tr}</td>
		<td class="formcolor"><input {literal}onchange="javascript:if(!document.getElementById('chksug').checked) {document.getElementById('chkaut').checked=false;};"{/literal} id='chksug' type="checkbox" name="suggestions" {if $info.suggestions eq 'y'}checked="checked"{/if} /></td>
	</tr>
	<tr>
		<td class="formcolor">{tr}Auto validate user suggestions{/tr}</td>
		<td class="formcolor"><input {literal}onchange="javascript:if(document.getElementById('chkaut').checked) {document.getElementById('chksug').checked=true;};"{/literal} id='chkaut' type="checkbox" name="autoValidate" {if $info.autoValidate eq 'y'}checked="checked"{/if}</td>
	</tr>
	
	<tr>
		<td class="formcolor">{tr}Ranking shows{/tr}</td>
		<td class="formcolor">
			<select name="topN">
  	    <option value='0' {if $info.topN eq 0}selected="selected"{/if}>{tr}All items{/tr}</option>
				<option value='10' {if $info.topN eq 10}selected="selected"{/if}>{tr}Top 10 items{/tr}</option>
				<option value='20' {if $info.topN eq 20}selected="selected"{/if}>{tr}Top 20 items{/tr}</option>
				<option value='40' {if $info.topN eq 40}selected="selected"{/if}>{tr}Top 40 items{/tr}</option>
				<option value='50' {if $info.topN eq 50}selected="selected"{/if}>{tr}Top 50 items{/tr}</option>
				<option value='100' {if $info.topN eq 100}selected="selected"{/if}>{tr}Top 100 items{/tr}</option>
				<option value='250' {if $info.topN eq 250}selected="selected"{/if}>{tr}Top 250 items{/tr}</option>
			</select>
		</td>
	</tr>
	
	<tr>
		<td class="formcolor">{tr}Voting system{/tr}</td>
		<td class="formcolor">
			<select name="maxVoteValue">
				<option value="1" {if $info.maxVoteValue eq 1}selected="selected"{/if}>{tr}Vote items{/tr}</option>
				<option value="5" {if $info.maxVoteValue eq 5}selected="selected"{/if}>{tr}Rank 1..5{/tr}</option>
				<option value="10" {if $info.maxVoteValue eq 10}selected="selected"{/if}>{tr}Rank 1..10{/tr}</option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="formcolor">{tr}Ranking frequency{/tr}</td>
		<td class="formcolor">
			<select name="frequency">
				<option value="0" {if $info.frequency eq "0"}selected="selected"{/if}>{tr}Realtime{/tr}</option>
				<option value="300" {if $info.frequency eq "300"}selected="selected"{/if}>{tr}Each 5 minutes{/tr}</option>
				<option value="86400" {if $info.frequency eq "86400"}selected="selected"{/if}>{tr}Daily{/tr}</option>
				<option value="604800" {if $info.frequency eq "604800"}selected="selected"{/if}>{tr}Weekly{/tr}</option>
				<option value="2592000" {if $info.frequency eq "2592000"}selected="selected"{/if}>{tr}Monthly{/tr}</option>
			</select>
		</td>
	</tr>	
	<tr>
		<td class="formcolor">{tr}Show Average{/tr}</td>
		<td class="formcolor"><input type="checkbox" name="showAverage" {if $info.showAverage eq 'y'}checked="checked"{/if} /></td>
	</tr>
	<tr>
		<td class="formcolor">{tr}Show Votes{/tr}</td>
		<td class="formcolor"><input type="checkbox" name="showVotes" {if $info.showVotes eq 'y'}checked="checked"{/if} /></td>
	</tr>
	<tr>
		<td class="formcolor">{tr}Use Cookies for unregistered users{/tr}</td>
		<td class="formcolor"><input type="checkbox" name="useCookies" {if $info.useCookies eq 'y'}checked="checked"{/if} /></td>
	</tr>
	<tr>
		<td class="formcolor">{tr}Users can vote again after{/tr}</td>
		<td class="formcolor">
			<select id='selva' name="voteAgainAfter" {literal}onchange="javascript:if(document.getElementById('selva').value==0){document.getElementById('chksc').checked=false;document.getElementById('chksi').checked=false;};"{/literal} >
				<option value="0" {if $info.voteAgainAfter eq "0"}selected="selected"{/if}>{tr}Anytime{/tr}</option>
				<option value="300" {if $info.voteAgainAfter eq "300"}selected="selected"{/if}>{tr}5 minutes{/tr}</option>
				<option value="86400" {if $info.voteAgainAfter eq "86400"}selected="selected"{/if}>{tr}1 day{/tr}</option>
				<option value="604800" {if $info.voteAgainAfter eq "604800"}selected="selected"{/if}>{tr}1 week{/tr}</option>
				<option value="2592000" {if $info.voteAgainAfter eq "2592000"}selected="selected"{/if}>{tr}1 month{/tr}</option>			
			</select>
		</td>
	</tr>	

	<tr>
		<td class="formcolor">&nbsp;</td>
		<td class="formcolor"><input type="submit" name="save" value="{if $chartId > 0}{tr}Update{/tr}{else}{tr}Create{/tr}{/if}" /></td>
	</tr>
</table>
</form>


<h2>{tr}Charts{/tr}</h2>

{include file='find.tpl' _sort_mode='y'}

<form action="tiki-admin_charts.php" method="post">
<input type="hidden" name="offset" value="{$offset|escape}" />
<input type="hidden" name="find" value="{$find|escape}" />
<input type="hidden" name="where" value="{$where|escape}" />
<input type="hidden" name="sort_mode" value="{$sort_mode|escape}" />
<table class="normal">
<tr>
<th><input type="submit" name="delete" value="{tr}x{/tr} " /></th>
<th><a href="{if $sort_mode eq 'title_desc'}{sameurl sort_mode="title_asc"}{else}{sameurl sort_mode="title_desc"}{/if}">{tr}Title{/tr}</a></th>
<th style="text-align:right;">{tr}Items{/tr}</th>
<th style="text-align:right;">{tr}Ranks{/tr}</th>
<th>&nbsp;</th>
</tr>
{cycle values="odd,even" print=false}
{section name=ix loop=$items}
<tr>
	<td class="{cycle advance=false}">
		<input type="checkbox" name="chart[{$items[ix].chartId}]" />
	</td>
	<td class="{cycle advance=false}">
		<a class="link" href="{sameurl chartId=$items[ix].chartId}">{$items[ix].title}</a>
	</td>
	<td style="text-align:right;" class="{cycle advance=false}">
		<a class="link" href="tiki-admin_chart_items.php?chartId={$items[ix].chartId}">{$items[ix].items}</a>
	</td>
	<td style="text-align:right;" class="{cycle advance=false}">
		{$items[ix].periods}
	</td>
	<td style="text-align:right;" class="{cycle}">
		<a title="{tr}View{/tr}" class="link" href="tiki-view_chart.php?chartId={$items[ix].chartId}">{icon _id='monitor' alt='{tr}View{/tr}'}</a>
	</td>

</tr>
{sectionelse}
<tr>
	<td class="{cycle advance=false}" colspan="5">
	{tr}No charts defined yet{/tr}
	</td>
</tr>	
{/section}
</table>
</form>

{pagination_links cant=$cant_pages step=$prefs.maxRecords offset=$offset}{/pagination_links}<!-- END of {$smarty.template} -->

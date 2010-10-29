<div class="pollresults">
{cycle values="even,odd" print=false}
<table class="pollresults">
	{section name=ix loop=$poll_info.options}
		<tr class="{cycle}">
			<td class="pollr">
				{if $smarty.section.x.total > 1}<a href="tiki-poll_results.php?{if !empty($scoresort_desc)}scoresort_asc{else}scoresort_desc{/if}={$smarty.section.ix.index}">{/if}
				{$poll_info.options[ix].title|escape}
				{if $smarty.section.x.total > 1}</a>{/if}
			</td>
    		<td class="pollr">
				{quotabar length=$poll_info.options[ix].width}  {$poll_info.options[ix].percent}% ({$poll_info.options[ix].votes})
    		</td>
    	</tr>
	{/section}
</table>
<br />
{tr}Total{/tr}: {$poll_info.votes} {tr}votes{/tr}<br /><br />
{if isset($poll_info.total) and $poll_info.total > 0}
	{tr}Average:{/tr} {math equation="x/y" x=$poll_info.total y=$poll_info.votes format="%.2f"}
{/if}
</div>
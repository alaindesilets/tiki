<!-- START of {$smarty.template} -->{* $Id$ *}
{title help="Quiz"}{tr}Quizzes{/tr}{/title}

{if $tiki_p_view_quiz_stats eq 'y'}
	<div class="navbar">
		{button href="tiki-quiz_stats.php" _text="{tr}Quiz Stats{/tr}"}
	</div>

	{if $channels or ($find ne '')}
		{include file='find.tpl'}
	{/if}
{/if}

<table class="normal">
	<tr>
		<th>
			<a href="tiki-list_quizzes.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'name_desc'}name_asc{else}name_desc{/if}">{tr}Quiz{/tr}</a>
		</th>
		<th>
			<a href="tiki-list_quizzes.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'timeLimit_desc'}timeLimit_asc{else}timeLimit_desc{/if}">{tr}timeLimit{/tr}</a>
		</th>
		<th>
			{tr}Questions{/tr}
		</th>
		{if ($tiki_p_admin eq 'y' or $tiki_p_admin_quizzes eq 'y' or $tiki_p_view_quiz_stats eq 'y')}
			<th>
				{tr}Actions{/tr}
			</th>
		{/if}
	</tr>
	{cycle values="odd,even" print=false}
	{section name=user loop=$channels}
		{if ($tiki_p_admin eq 'y') or ($channels[user].individual eq 'n' and $tiki_p_take_quiz eq 'y') or ($channels[user].individual_tiki_p_take_quiz eq 'y')}
			<tr>
				<td class="{cycle advance=false}">
					<a class="tablename" href="tiki-take_quiz.php?quizId={$channels[user].quizId}">{$channels[user].name}</a>
					<div class="subcomment">
						{$channels[user].description|escape|nl2br}
					</div>

        </td>
        <td class="{cycle advance=false}">
					{$channels[user].timeLimited} {if $channels[user].timeLimited eq 'y'}({$channels[user].timeLimit} mins){/if}
				</td>
        <td class="{cycle advance=false}">
					{$channels[user].questions}
				</td>
				{if ($tiki_p_admin eq 'y' or $tiki_p_admin_quizzes eq 'y' or $tiki_p_view_quiz_stats eq 'y')}
					<td class="{cycle}">
						{if ($tiki_p_admin eq 'y') or ($channels[user].individual eq 'n' and $tiki_p_admin_quizzes eq 'y') or ($channels[user].individual_tiki_p_admin_quizzes eq 'y')}
							<a class="link" href="tiki-edit_quiz.php?quizId={$channels[user].quizId}">{icon _id='page_edit' alt='{tr}Edit{/tr}'}</a>
						{/if}
						{if ($tiki_p_admin eq 'y') or ($channels[user].individual eq 'n' and $tiki_p_view_quiz_stats eq 'y') or ($channels[user].individual_tiki_p_view_quiz_stats eq 'y')}
							<a class="link" href="tiki-quiz_stats_quiz.php?quizId={$channels[user].quizId}">{icon _id='chart_curve' alt='{tr}Stats{/tr}'}</a>
						{/if}
					</td>
				{/if}
      </tr>
		{/if}
	{sectionelse}
		<tr>
			<td class="{cycle}" colspan="4">
				{tr}No records.{/tr}
			</td>
		</tr>
	{/section}
</table>

{pagination_links cant=$cant_pages step=$prefs.maxRecords offset=$offset}{/pagination_links}<!-- END of {$smarty.template} -->

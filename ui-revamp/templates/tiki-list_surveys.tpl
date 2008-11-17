{* $Id$ *}
{title help="Surveys"}{tr}Surveys{/tr}{/title}

<div class="navbar">
{if $tiki_p_view_survey_stats eq 'y'}
  {button href="tiki-survey_stats.php" _text="{tr}Survey stats{/tr}"}
{/if}
{if $tiki_p_admin_surveys eq 'y'}
  {button href="tiki-admin_surveys.php" _text="{tr}Create New Survey{/tr}"}
{/if}
</div>

<table class="normal">
<tr>
<th>
<a href="tiki-list_surveys.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'name_desc'}name_asc{else}name_desc{/if}">{tr}Name{/tr}</a></th>
<th><a href="tiki-list_surveys.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'description_desc'}description_asc{else}description_desc{/if}">{tr}Description{/tr}</a></th>
<th>{tr}Questions{/tr}</th>
<th>{tr}Actions{/tr}</th>
</tr>
{cycle values="odd,even" print=false}
{section name=user loop=$channels}
{if ($tiki_p_admin eq 'y') or ($channels[user].individual eq 'n' and $tiki_p_take_survey eq 'y') or ($channels[user].individual_tiki_p_take_survey eq 'y')}
<tr>
<td class="{cycle advance=false}">
{if ($tiki_p_admin_surveys eq 'y') or ($channels[user].status eq 'o' and $channels[user].taken_survey eq 'n')}
<a class="tablename" href="tiki-take_survey.php?surveyId={$channels[user].surveyId}">
{else}
<a class="link" href="tiki-survey_stats_survey.php?surveyId={$channels[user].surveyId}">
{/if}
{$channels[user].name}</a>
</td>
<td class="{cycle advance=false}">{wiki}{$channels[user].description|escape}{/wiki}</td>
<td style="text-align:right;"  class="{cycle advance=false}">{$channels[user].questions}</td>

<td style="text-align:right;"  class="{cycle}">
{if ($tiki_p_admin_surveys eq 'y') or ($channels[user].status eq 'o' and $channels[user].taken_survey eq 'n')}
<a href="tiki-take_survey.php?surveyId={$channels[user].surveyId}">{icon _id='control_play' alt='{tr}Take Survey{/tr}}</a>
{/if}

{if ($tiki_p_admin eq 'y') or ($channels[user].individual eq 'n' and $tiki_p_view_survey_stats eq 'y') or ($channels[user].individual_tiki_p_view_survey_stats eq 'y')}
<a href="tiki-survey_stats_survey.php?surveyId={$channels[user].surveyId}">{icon _id='chart_curve' alt='{tr}Stats{/tr}'}</a>
{/if}

{if ($tiki_p_admin eq 'y') or ($channels[user].individual eq 'n' and $tiki_p_admin_surveys eq 'y') or ($channels[user].individual_tiki_p_admin_surveys eq 'y')}
<a href="tiki-admin_surveys.php?surveyId={$channels[user].surveyId}">{icon _id='page_edit' alt='{tr}Edit this Survey{/tr}'}</a>
{/if}
</td>
</tr>
{/if}
{sectionelse}
<tr><td class="odd" colspan="4">
<b>{tr}No records found{/tr}</b>
</td></tr>
{/section}
</table>
<! -- the page advance... it's set to ten by default in maxRecords... -->

<br />
<div class="mini">
{if $prev_offset >= 0}
[<a class="prevnext" href="tiki-list_surveys.php?find={$find}&amp;offset={$prev_offset}&amp;sort_mode={$sort_mode}">{tr}Prev{/tr}</a>]&nbsp;
{/if}
{tr}Page{/tr}: {$actual_page}/{$cant_pages}
{if $next_offset >= 0}
&nbsp;[<a class="prevnext" href="tiki-list_surveys.php?find={$find}&amp;offset={$next_offset}&amp;sort_mode={$sort_mode}">{tr}Next{/tr}</a>]
{/if}
{if $prefs.direct_pagination eq 'y'}
<br />
{section loop=$cant_pages name=foo}
{assign var=selector_offset value=$smarty.section.foo.index|times:$prefs.maxRecords}
<a class="prevnext" href="tiki-list_surveys.php?find={$find}&amp;offset={$selector_offset}&amp;sort_mode={$sort_mode}">
{$smarty.section.foo.index_next}</a>&nbsp;
{/section}
{/if}
</div>

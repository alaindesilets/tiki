{title url="tiki-edit_question_options.php?questionId=$questionId"}{tr}Edit question options{/tr}{/title}

<div class="navbar">
	{button href="tiki-list_quizzes.php" _text="{tr}List Quizzes{/tr}"} 
	{button href="tiki-quiz_stats.php" _text="{tr}Quiz Stats{/tr}"}
	{button href="tiki-quiz_stats_quiz.php?quizId=$quizId" _text="{tr}This Quiz Stats{/tr}"}
	{button href="tiki-edit_quiz.php?quizId=$quizId" _text="{tr}Edit this Quiz{/tr}"} 
	{button href="tiki-edit_quiz.php" _text="{tr}Admin Quizzes{/tr}"}
</div>

<h2>{tr}Create/edit options for question{/tr}: <a  href="tiki-edit_quiz_questions.php?quizId={$question_info.quizId}&amp;questionId={$question_info.questionId}">{$question_info.question}</a></h2>
<form action="tiki-edit_question_options.php" method="post">
<input type="hidden" name="optionId" value="{$optionId|escape}" />
<input type="hidden" name="questionId" value="{$questionId|escape}" />
<table class="normal">
<tr><td class="formcolor">{tr}Option{/tr}:</td><td class="formcolor"><textarea name="optionText" rows="5" cols="40">{$optionText|escape}</textarea></td></tr>
<tr><td class="formcolor">{tr}Points{/tr}:</td><td class="formcolor"><input type="text" name="points" value="{$points|escape}" /></td></tr>
<tr><td  class="formcolor">&nbsp;</td><td class="formcolor"><input type="submit" name="save" value="{tr}Save{/tr}" /></td></tr>
</table>
</form>

<h2>Options</h2>
<table class="findtable">
<tr><td class="findtable">{tr}Find{/tr}</td>
   <td class="findtable">
   <form method="get" action="tiki-edit_question_options.php">
     <input type="text" name="find" value="{$find|escape}" />
     <input type="submit" value="{tr}Find{/tr}" name="search" />
     <input type="hidden" name="sort_mode" value="{$sort_mode|escape}" />
     <input type="hidden" name="questionId" value="{$questionId|escape}" />
   </form>
   </td>
</tr>
</table>

<table class="normal">
<tr>
<th><a href="tiki-edit_question_options.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'optionId_desc'}optionId_asc{else}optionId_desc{/if}">{tr}ID{/tr}</a></th>
<th><a href="tiki-edit_question_options.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'optionText_desc'}optionText_asc{else}optionText_desc{/if}">{tr}text{/tr}</a></th>
<th><a href="tiki-edit_question_options.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'points_desc'}points_asc{else}points_desc{/if}">{tr}points{/tr}</a></th>
<th>{tr}Action{/tr}</th>
</tr>

{cycle values="odd,even" print=false}
{section name=user loop=$channels}
<tr>
<td class="{cycle advance=false}">{$channels[user].optionId}</td>
<td class="{cycle advance=false}">{$channels[user].optionText}</td>
<td class="{cycle advance=false}">{$channels[user].points}</td>
<td class="{cycle}">
   <a class="link" href="tiki-edit_question_options.php?questionId={$questionId}&amp;offset={$offset}&amp;sort_mode={$sort_mode}&amp;optionId={$channels[user].optionId}">{icon _id='page_edit' alt='{tr}Edit{/tr}'}</a>
   <a class="link" href="tiki-edit_question_options.php?questionId={$questionId}&amp;offset={$offset}&amp;sort_mode={$sort_mode}&amp;remove={$channels[user].optionId}">{icon _id='cross' alt='{tr}Remove{/tr}'}</a>
</td>
</tr>
{/section}
</table>

{pagination_links cant=$cant_pages step=$prefs.maxRecords offset=$offset}{/pagination_links}

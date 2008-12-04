{title}{tr}Submissions{/tr}{/title}

<div class="navbar">
	{button href="tiki-edit_submission.php" _text="{tr}Edit New Submission{/tr}"}
  {if $tiki_p_read_article eq 'y'}
		{button href="tiki-list_articles.php" _text="{tr}List articles{/tr}"}
  {/if}
</div>

{include file='find.tpl' _sort_mode='y'}

<table class="normal">
<tr>
{if $prefs.art_list_title eq 'y'}
	<th><a href="tiki-list_submissions.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'title_desc'}title_asc{else}title_desc{/if}">{tr}Title{/tr}</a></th>
{/if}
{if $prefs.art_list_topic eq 'y'}
	<th><a href="tiki-list_submissions.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'topicName_desc'}topicName_asc{else}topicName_desc{/if}">{tr}Topic{/tr}</a></th>
{/if}
{if $prefs.art_list_date eq 'y'}
	<th><a href="tiki-list_submissions.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'publishDate_desc'}publishDate_asc{else}publishDate_desc{/if}">{tr}PublishDate{/tr}</a></th>
{/if}
{if $prefs.art_list_size eq 'y'}
	<th style="text-align:right;"><a href="tiki-list_submissions.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'size_desc'}size_asc{else}size_desc{/if}">{tr}Size{/tr}</a></th>
{/if}
{if $prefs.art_list_img eq 'y'}
<th>{tr}Img{/tr}</th>
{/if}
{if $prefs.art_list_author eq 'y'}
	<th><a href="tiki-list_submissions.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'author_desc'}author_asc{else}author_desc{/if}">{tr}User{/tr}</a></th>
{/if}
<th>{tr}Action{/tr}</th>
</tr>
{cycle values="odd,even" print=false}
{section name=changes loop=$listpages}
<tr>
{if $prefs.art_list_title eq 'y'}
	<td class="{cycle advance=false}"><a class="link" title="{$listpages[changes].title}" href="tiki-edit_submission.php?subId={$listpages[changes].subId}">{$listpages[changes].title|truncate:$prefs.art_list_title_len:"...":true}</a>
	{*if $listpages[changes].type eq 'Review'}(r){/if*}
	</td>
{/if}
{if $prefs.art_list_topic eq 'y'}
	<td class="{cycle advance=false}">{$listpages[changes].topicName}</td>
{/if}
{if $prefs.art_list_date eq 'y'}
	<td class="{cycle advance=false}">{$listpages[changes].publishDate|tiki_short_datetime}</td>
{/if}
{if $prefs.art_list_size eq 'y'}
	<td style="text-align:right;" class="{cycle advance=false}">{$listpages[changes].size|kbsize}</td>
{/if}
{if $prefs.art_list_img eq 'y'}
	<td class="{cycle advance=false}">{$listpages[changes].hasImage}/{$listpages[changes].useImage}</td>
{/if}
{if $prefs.art_list_author eq 'y'}
<td class="{cycle advance=false}">{$listpages[changes].author}</td>
{/if}
<td class="{cycle}" >
	{if $tiki_p_edit_submission eq 'y' or ($listpages[changes].author eq $user and $user)}
		<a class="link" href="tiki-edit_submission.php?subId={$listpages[changes].subId}">{icon _id='page_edit'}</a>
	{/if}
	{if $tiki_p_remove_submission eq 'y'}
		<a class="link" href="tiki-list_submissions.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;remove={$listpages[changes].subId}">{icon _id='cross' alt='{tr}Remove{/tr}'}</a>
	{/if}
	{if $tiki_p_approve_submission eq 'y'}
		<a class="link" href="tiki-list_submissions.php?approve={$listpages[changes].subId}"><img src='img/icons2/post.gif' border='0' alt='{tr}Approve{/tr}' title='{tr}Approve{/tr}' /></a>
	{/if}
</td>
</tr>
{sectionelse}
<tr><td colspan="6">
<b>{tr}No records found{/tr}</b>
</td></tr>
{/section}
</table>

{pagination_links cant=$cant_pages step=$prefs.maxRecords offset=$offset}{/pagination_links}

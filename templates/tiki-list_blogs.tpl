<a class="pagetitle" href="tiki-list_blogs.php">{tr}Blogs{/tr}</a><br/><br/>
{if $tiki_p_create_blogs eq 'y'}
<a class="bloglink" href="tiki-edit_blog.php">{tr}create new blog{/tr}</a>
{/if}
<br/><br/>
<div align="center">
<table class="findtable">
<tr><td class="findtable">{tr}Find{/tr}</td>
   <td class="findtable">
   <form method="get" action="tiki-list_blogs.php">
     <input type="text" name="find" value="{$find}" />
     <input type="submit" value="{tr}find{/tr}" name="search" />
     <input type="hidden" name="sort_mode" value="{$sort_mode}" />
   </form>
   </td>
</tr>
</table>
<table class="bloglist">
<tr>
{if $blog_list_title eq 'y'}
	<td class="bloglistheading"><a class="bloglistheading" href="tiki-list_blogs.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'title_desc'}title_asc{else}title_desc{/if}">{tr}Title{/tr}</a></td>
{/if}
{if $blog_list_description eq 'y'}
	<td class="bloglistheading">{tr}Description{/tr}</td>
{/if}
{if $blog_list_created eq 'y'}
	<td class="bloglistheading"><a class="bloglistheading" href="tiki-list_blogs.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'created_desc'}created_asc{else}created_desc{/if}">{tr}Created{/tr}</a></td>
{/if}
{if $blog_list_lastmodif eq 'y'}
	<td class="bloglistheading"><a class="bloglistheading" href="tiki-list_blogs.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'lastModif_desc'}lastModif_asc{else}lastModif_desc{/if}">{tr}Last Modified{/tr}</a></td>
{/if}
{if $blog_list_user eq 'y'}
	<td class="bloglistheading"><a class="bloglistheading" href="tiki-list_blogs.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'user_desc'}user_asc{else}user_desc{/if}">{tr}User{/tr}</a></td>
{/if}
{if $blog_list_posts eq 'y'}
	<td style="text-align:right;"  class="bloglistheading"><a class="bloglistheading" href="tiki-list_blogs.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'posts_desc'}posts_asc{else}posts_desc{/if}">{tr}Posts{/tr}</a></td>
{/if}
{if $blog_list_visits eq 'y'}
	<td style="text-align:right;"  class="bloglistheading"><a class="bloglistheading" href="tiki-list_blogs.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'hits_desc'}hits_asc{else}hits_desc{/if}">{tr}Visits{/tr}</a></td>
{/if}
{if $blog_list_activity eq 'y'}
	<td style="text-align:right;"  class="bloglistheading"><a class="bloglistheading" href="tiki-list_blogs.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'activity_desc'}activity_asc{else}activity_desc{/if}">{tr}Activity{/tr}</a></td>
{/if}
<td class="bloglistheading">{tr}Action{/tr}</td>
</tr>
{cycle values="odd,even" print=false}
{section name=changes loop=$listpages}
<tr>
{if $blog_list_title eq 'y'}
	<td class="bloglistname{cycle advance=false}">&nbsp;{if ($tiki_p_admin eq 'y') or ($listpages[changes].individual eq 'n') or ($listpages[changes].individual_tiki_p_read_blog eq 'y' ) }<a class="blogname" href="tiki-view_blog.php?blogId={$listpages[changes].blogId}" title="{$listpages[changes].title}">{/if}{$listpages[changes].title|truncate:20:"(...)":true}{if ($tiki_p_admin eq 'y') or ($listpages[changes].individual eq 'n') or ($listpages[changes].individual_tiki_p_read_blog eq 'y' ) }</a>{/if}&nbsp;</td>
{/if}
{if $blog_list_description eq 'y'}
	<td class="bloglistdescription{cycle advance=false}">&nbsp;{$listpages[changes].description}&nbsp;</td>
{/if}
{if $blog_list_created eq 'y'}
	<td class="bloglistcreated{cycle advance=false}">&nbsp;{$listpages[changes].created|tiki_short_date}&nbsp;</td><!--tiki_date_format:"%b %d" -->
{/if}
{if $blog_list_lastmodif eq 'y'}
	<td class="bloglistlastModif{cycle advance=false}">&nbsp;{$listpages[changes].lastModif|tiki_short_datetime}&nbsp;</td><!--tiki_date_format:"%d of %b [%H:%M]"-->
{/if}
{if $blog_list_user eq 'y'}
	{if $blog_list_user eq 'link'}
		<td class="bloglistuser{cycle advance=false}">&nbsp;{$listpages[changes].user|userlink}&nbsp;</td>
	{elseif $blog_list_user eq 'avatar'}
		<td class="bloglistuser{cycle advance=false}">&nbsp;{$listpages[changes].user|avatarize}&nbsp;</td>
	{else}
		<td class="bloglistuser{cycle advance=false}">&nbsp;{$listpages[changes].user}&nbsp;</td>
	{/if}
{/if}	
{if $blog_list_posts eq 'y'}
	<td style="text-align:right;" class="bloglistposts{cycle advance=false}">&nbsp;{$listpages[changes].posts}&nbsp;</td>
{/if}
{if $blog_list_visits eq 'y'}
	<td style="text-align:right;" class="bloglistvisits{cycle advance=false}">&nbsp;{$listpages[changes].hits}&nbsp;</td>
{/if}
{if $blog_list_activity eq 'y'}	
	<td style="text-align:right;" class="bloglistactivity{cycle advance=false}">&nbsp;{$listpages[changes].activity}&nbsp;</td>
{/if}
<td class="bloglistactions{cycle}">
	{if $tiki_p_blog_post eq 'y'}
		{if ($tiki_p_admin eq 'y') or ($listpages[changes].individual eq 'n') or ($listpages[changes].individual_tiki_p_blog_post eq 'y' ) }
			{if ($user and $listpages[changes].user eq $user) or ($tiki_p_blog_admin eq 'y') or ($listpages[changes].public eq 'y')}
				<a class="bloglink" href="tiki-blog_post.php?blogId={$listpages[changes].blogId}"><img border='0' title='{tr}post{/tr}' alt='{tr}post{/tr}' src='img/icons/edit.gif' /></a>
			{/if}
		{/if}
	{/if}
	{if ($user and $listpages[changes].user eq $user) or ($tiki_p_blog_admin eq 'y')}
		{if ($tiki_p_admin eq 'y') or ($listpages[changes].individual eq 'n') or ($listpages[changes].individual_tiki_p_blog_create_blog eq 'y' ) }
			<a class="bloglink" href="tiki-edit_blog.php?blogId={$listpages[changes].blogId}"><img border='0' title='{tr}edit{/tr}' alt='{tr}edit{/tr}' src='img/icons/config.gif' /></a>
		{/if}
	{/if}
	{if ($user and $listpages[changes].user eq $user) or ($tiki_p_blog_admin eq 'y')}
		{if ($tiki_p_admin eq 'y') or ($listpages[changes].individual eq 'n') or ($listpages[changes].individual_tiki_p_blog_create_blog eq 'y' ) }
			<a class="bloglink" href="tiki-list_blogs.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;remove={$listpages[changes].blogId}"><img border='0' title='{tr}remove{/tr}' alt='{tr}remove{/tr}' src='img/icons2/delete.gif' /></a>
		{/if}
	{/if}
	{if $tiki_p_admin eq 'y'}
	    {if $listpages[changes].individual eq 'y'}({/if}<a class="bloglink" href="tiki-objectpermissions.php?objectName=blog%20{$listpages[changes].title}&amp;objectType=blog&amp;permType=blogs&amp;objectId={$listpages[changes].blogId}"><img border='0' title='{tr}perms{/tr}' alt='{tr}perms{/tr}' src='img/icons/key.gif' /></a>{if $listpages[changes].individual eq 'y'}){/if}
	{/if}
	
</td>
</tr>
{sectionelse}
<tr><td colspan="6">
<b>{tr}No records found{/tr}</b>
</td></tr>
{/section}
</table>
<br/>
<div class="mini">
{if $prev_offset >= 0}
[<a class="blogprevnext" href="tiki-list_blogs.php?find={$find}&amp;offset={$prev_offset}&amp;sort_mode={$sort_mode}">{tr}prev{/tr}</a>]&nbsp;
{/if}
{tr}Page{/tr}: {$actual_page}/{$cant_pages}
{if $next_offset >= 0}
&nbsp;[<a class="blogprevnext" href="tiki-list_blogs.php?find={$find}&amp;offset={$next_offset}&amp;sort_mode={$sort_mode}">{tr}next{/tr}</a>]
{/if}
{if $direct_pagination eq 'y'}
<br/>
{section loop=$cant_pages name=foo}
{assign var=selector_offset value=$smarty.section.foo.index|times:$maxRecords}
<a class="prevnext" href="tiki-list_blogs.php?find={$find}&amp;offset={$selector_offset}&amp;sort_mode={$sort_mode}">
{$smarty.section.foo.index_next}</a>&nbsp;
{/section}
{/if}
</div>
</div>
{if $tiki_p_admin eq 'y'}
<br/><br/>
<a href="tiki-admin.php?page=blogs"><img src='img/icons/config.gif' border='0'  alt="{tr}configure listing{/tr}" title="{tr}configure listing{/tr}" /></a>
{/if}


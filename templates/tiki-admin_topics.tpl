{* $Id$ *}

{title help="Articles"}{tr}Admin Topics{/tr}{/title}

<h2>{tr}Create a new topic{/tr}</h2>

<form enctype="multipart/form-data" action="tiki-admin_topics.php" method="post">
 <table class="normal">
<tr><td class="formcolor">{tr}Topic Name{/tr}</td><td class="formcolor"><input type="text" name="name" /></td></tr>
<tr><td class="formcolor">{tr}Upload Image{/tr}</td><td class="formcolor"><input type="hidden" name="MAX_FILE_SIZE" value="1000000" />
<input name="userfile1" type="file" /></td></tr>
<tr><td class="formcolor">&nbsp;</td><td class="formcolor"><input type="submit" name="addtopic" value="{tr}Add{/tr}" /></td></tr>
</table>
</form>

<h2>{tr}List of topics{/tr}</h2>
<table class="normal">
<tr>
<th>{tr}ID{/tr}</th>
<th>{tr}Name{/tr}</th>
<th>{tr}Image{/tr}</th>
<th>{tr}Active?{/tr}</th>
<th>{tr}Articles (subs){/tr}</th>
<th>{tr}Action{/tr}</th>
</tr>
{cycle print=false values="even,odd"}
{section name=user loop=$topics}
<tr>
<td class="{cycle advance=false}">{$topics[user].topicId}</td>
<td class="{cycle advance=false}"><a class="link" href="tiki-view_articles.php?topic={$topics[user].topicId}">{$topics[user].name}</a></td>
<td class="{cycle advance=false}">
{if $topics[user].image_size}
<img alt="{tr}topic image{/tr}" border="0" src="article_image.php?image_type=topic&amp;id={$topics[user].topicId}&amp;reload=1" />
{else}
&nbsp;
{/if}
</td>
<td class="{cycle advance=false}">{$topics[user].active}</td>
<td class="{cycle advance=false}">{$topics[user].arts} ({$topics[user].subs})</td>
<td class="{cycle}">
<a class="link" href="tiki-admin_topics.php?remove={$topics[user].topicId}">{icon _id='cross' alt='{tr}Remove{/tr}'}</a>
<a class="link" href="tiki-admin_topics.php?removeall={$topics[user].topicId}">{tr}Remove with articles{/tr}</a>
{if $topics[user].active eq 'n'}
<a class="link" href="tiki-admin_topics.php?activate={$topics[user].topicId}">{icon _id='accept' alt="{tr}Activate{/tr}" title='{tr}Inactive - Click to Activate{/tr}'}</a>
{else}
<a class="link" href="tiki-admin_topics.php?deactivate={$topics[user].topicId}">{icon _id='delete' alt="{tr}Deactivate{/tr}" title='{tr}Active - Click to Deactivate{/tr}'}</a>
{/if}
{if $topics[user].individual eq 'y'}<a title="{tr}Active Permissions{/tr}" class="link" href="tiki-objectpermissions.php?objectName={$topics[user].name|escape:"url"}&amp;objectType=topic&amp;permType=cms&amp;objectId={$topics[user].topicId}">{icon _id='key_active' alt="{tr}Active Permissions{/tr}"}</a>
{else}
<a title="{tr}Permissions{/tr}" class="link" href="tiki-objectpermissions.php?objectName={$topics[user].name|escape:"url"}&amp;objectType=topic&amp;permType=cms&amp;objectId={$topics[user].topicId}">{icon _id='key' alt="{tr}Permissions{/tr}"}</a>{/if}
 <a class="link" href="tiki-edit_topic.php?topicid={$topics[user].topicId}">{icon _id='page_edit'}</a>
</td>
</tr>
{sectionelse}
<tr>
<td colspan="5" class="odd">{tr}No records found{/tr}</td>
</tr>
{/section}
</table>

{if $feature_user_bookmarks eq 'y' and $user and $tiki_p_create_bookmarks eq 'y'}
<div class="box">
<div class="box-title">
<a class="cboxtlink" href="tiki-user_bookmarks.php">{tr}Bookmarks{/tr}</a>
</div>
<div class="box-data">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
{section name=ix loop=$modb_folders}
<tr><td valign="bottom" class="module">
<a href="{$ownurl}{$modb_sep}bookmarks_parent={$modb_folders[ix].folderId}"><img border="0" src="img/icons/folderin.gif" /></a>&nbsp;{$modb_folders[ix].name}
</td></tr>
{/section}
{section name=ix loop=$modb_urls}
<tr><td class="module">
<a class="linkmodule" href="{$modb_urls[ix].url}">{$modb_urls[ix].name}</a>
{if $tiki_p_cache_bookmarks eq 'y' and $urls[ix].datalen > 0}
(<a href="tiki-user_cached_bookmark.php?urlid={$modb_urls[ix].urlId}" class="linkmodule" target="_blank"><small>cache</small></a>)
{/if}
(<a class="linkmodule" href="{$ownurl}{$modb_sep}bookmark_removeurl={$modb_urls[ix].urlId}"><small>x</small></a>)
</td></tr>
{/section}
</table>
<br/>
<form name="bookmarks" action="{$ownurl}" method="post">
<input style="font-size: 9px;" type="submit" name="bookmark_mark" value="{tr}mark{/tr}" />
<input style="font-size: 9px;" type="text" size="8" name="bookmark_urlname" />
<input style="font-size: 9px;" type="submit" name="bookmark_create_folder" value="{tr}new{/tr}" />
</form>
</div>
</div>
{/if}
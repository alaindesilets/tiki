{* $Header: /cvsroot/tikiwiki/tiki/templates/styles/musus/modules/mod-online_users.tpl,v 1.1 2004-01-07 04:31:24 musus Exp $ *}

{tikimodule title="{tr}Online users{/tr}" name="online_users"}
{section name=ix loop=$online_users}
{if $online_users[ix].user_information eq 'public'}
<a class="linkmodule" href="tiki-user_information.php?view_user={$online_users[ix].user}">{$online_users[ix].user}</a><br/>
{else}
{$online_users[ix].user}<br/>
{/if}
{/section}
{/tikimodule}


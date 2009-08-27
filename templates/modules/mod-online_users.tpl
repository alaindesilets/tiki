{* $Id$ *}

{tikimodule error=$module_params.error title=$tpl_module_title name="online_users" flip=$module_params.flip decorations=$module_params.decorations nobox=$module_params.nobox notitle=$module_params.notitle}
{foreach key=ix from=$online_users item=online_user}
{if $user and $prefs.feature_messages eq 'y' and $tiki_p_messages eq 'y'}
    {if $online_user.allowMsgs eq 'n'}
	<img src="img/icons/icon_ultima_no.gif" width="18" height="9" hspace="2" vspace="0" alt="{tr}User does not accept messages{/tr}" />
    {else}
	<a class="linkmodule" href="messu-compose.php?to={$online_user.user}" title="{tr}Send a message to{/tr} {$online_user.realName|default:$online_user.user|escape}"><img src="img/icons/icon_ultima.gif" width="18" height="9" hspace="2" vspace="0" alt="{tr}Send a message{/tr}" /></a>
	{/if}
{/if}
{if $online_user.user_information eq 'public'}
    {$online_user.user|userlink:"link":"not_set":$online_user.realName|escape}<br />
{else}
    {$online_user.realName|default:$online_user.user|escape}<br />
{/if}
{/foreach}
{/tikimodule}

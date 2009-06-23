{* $Id$ *}

{if $user}
{if !isset($tpl_module_title)}{assign var=tpl_module_title value="{tr}Login{/tr}"}{/if}
{tikimodule error=$module_params.error title=$tpl_module_title name="login_infos" flip=$module_params.flip decorations=$module_params.decorations nobox=$module_params.nobox notitle=$module_params.notitle}

<div><a class="linkmodule" href="tiki-logout.php">{tr}Logout{/tr}</a></div>

{if $prefs.userTracker eq 'y'}
<div>{tr}User informations{/tr}: </div>
<div class="">
{if $prefs.userTracker}
&nbsp;&nbsp;<a href="tiki-view_tracker_item.php?view=+user" class="linkmodule">{$user}</a>
{else}
{$user}
{/if}
</div>
{/if}


{if $prefs.groupTracker eq 'y'}
<div>{tr}Group informations{/tr}:</div>
<div class="box-data">
{if $prefs.groupTracker}
&nbsp;&nbsp;<a href="tiki-view_tracker_item.php?view=+group" class="linkmodule">{$default_group}</a>
{else}
{$default_group}
{/if}
</div>
{/if}

{/tikimodule}
{/if}

{if $prefs.groupTracker eq 'n' and $prefs.userTracker eq 'n' }
<a href="tiki-admin.php?page=login" class="linkmodule">{tr}You need to activate user and/or group trackers{/tr}</a>
{/if}


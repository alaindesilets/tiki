<!-- START of {$smarty.template} -->{* $Id$ *}

{assign var=escgroup value=$group|escape:url}
{title help="Permissions+Settings" url="tiki-assignpermission.php?group=$escgroup"}{tr}Assign permissions to group:{/tr} {$group}{/title}

<div class="navbar">
	{if $tiki_p_admin eq 'y'} {* only full admins can manage groups, not tiki_p_admin_users *}
		{button href="tiki-admingroups.php" _text="{tr}Admin groups{/tr}"}
	{/if}
	{button href="tiki-adminusers.php" _text="{tr}Admin users{/tr}"}
	{button href="?do=temp_cache&amp;group=$escgroup" _text="{tr}Clear Cache{/tr}"}
</div>

<h2>{tr}Group Information{/tr}</h2>
<table class="normal" id="groupinformation">
<tr><td class="even">{tr}Name{/tr}:</td><td class="odd" colspan="2">{$group_info.groupName}</td></tr>
<tr><td class="even">{tr}Desc{/tr}:</td><td class="odd" colspan="2">{$group_info.groupDesc}</td></tr>
<tr><td class="even" style="vertical-align:top;">{tr}Permissions{/tr}:</td><td class="odd">
{section name=grp loop=$group_info.perms}
{$group_info.perms[grp]}{if $group_info.perms[grp] != "Anonymous"}<a class="link" href="tiki-assignpermission.php?type={$type}&amp;sort_mode={$sort_mode}&amp;permission={$group_info.perms[grp]}&amp;group={$group|escape:url}&amp;action=remove">{icon _id='cross' alt='{tr}Delete{/tr}'}</a>{/if}<br />
{/section}
</td></tr>
</table>
<br />
<a name="assign" ></a>
<h2>{tr}Assign Permissions{/tr}</h2>
<table class="findtable">
<tr><td class="findtable">{tr}Find{/tr}</td>
<td class="findtable">
<form method="post" action="tiki-assignpermission.php#assign" name="permselects">
<input type="text" name="find" value="{$find|escape}" />
<input type="submit" value="{tr}Find{/tr}" name="search" />
<input type="hidden" name="sort_mode" value="{$sort_mode|escape}" />
<select name="type" onchange="permselects.submit()">
<option value="">{tr}All{/tr}</option>
{sortlinks}
{section name=v loop=$types}
<option value="{$types[v]}"{if $type eq $types[v]} selected="selected"{/if}>{tr}{$types[v]}{/tr}</option>
{/section}
{/sortlinks}
</select>
<select name="group" onchange="permselects.submit()">
{section name=v loop=$groups}
<option value="{$groups[v].groupName}"{if $group eq $groups[v].groupName} selected="selected"{/if}>{$groups[v].groupName}</option>
{/section}
</select>
</form>
</td></tr></table>

<form action="tiki-assignpermission.php" method="post">
<input type="hidden" name="group" value="{$group|escape}" />
<input type="hidden" name="type" value="{$type|escape}" />
<input type="submit" name="update" value="{tr}Update{/tr}" /><br />
<table class="sortable" id="assignperms" width="100%">
<tr>
<th>&nbsp;</th>
<th>{tr}Name{/tr}</th>
<th {if $advanced_features ne 'y'}style="display:none;"{else}style="display:block;"{/if}>{tr}level{/tr}</th>
<th>{tr}Type{/tr}</th>
<th>{tr}desc{/tr}</th>
</tr>
{cycle values="odd,even" print=false}
{section name=user loop=$perms}
<tr>
<td class="{cycle advance=false}"><input type="hidden" name="permName[{$perms[user].permName}]" /><input type="checkbox" name="perm[{$perms[user].permName}]" 
{assign var=has_inherited_one_perm value='n'}
{assign var=has_inherited_perm value=''}
{foreach key=gr item=it from=$inherited_groups_perms}
{if $it[user].hasPerm eq 'y'}{assign var=has_inherited_one_perm value='y'}{/if}
{/foreach}
{if $perms[user].hasPerm eq 'y' or $inherited_from_anon[user].hasPerm eq 'y'or $inherited_from_reg[user].hasPerm eq 'y' or $has_inherited_one_perm eq 'y'}checked="checked" {/if}
{if $inherited_from_anon[user].hasPerm eq 'y' or $inherited_from_reg[user].hasPerm eq 'y' or $has_inherited_one_perm eq 'y' or $perms[user].from_admin eq 'y'}disabled="disabled" {/if}/>
</td>
<td class="{cycle advance=false}">{$perms[user].permName}</td>
<td class="{cycle advance=false}" {if $advanced_features ne 'y'}style="display:none;"{else}style="display:block;"{/if}><select name="level[{$perms[user].permName}]">{html_options output=$levels values=$levels selected=$perms[user].level}</select></td>
<td class="{cycle advance=false}">{tr}{$perms[user].type}{/tr}</td>
<td class="{cycle}">
{if $perms[user].from_admin eq 'y'}<span  style="float:right;font-size:80%;padding:1px 5px;border:1px solid #999;color:#258;background-color:#ace;">{tr}Admin{/tr}</span>{/if}
{if $inherited_from_anon[user].hasPerm eq 'y'}<span style="float:right;font-size:80%;padding:1px 5px;border:1px solid #999;color:#262;background-color:#ada;">{tr}inherited from{/tr}<a href="tiki-assignpermission.php?group=Anonymous"> Anonymous</a></span>{/if}
{if $inherited_from_reg[user].hasPerm eq 'y'}<span style="float:right;font-size:80%;padding:1px 5px;border:1px solid #999;color:#258;background-color:#acd;">{tr}inherited from{/tr}<a href="tiki-assignpermission.php?group=Registered"> Registered</a></span>{/if}
{if $has_inherited_one_perm eq 'y'}<span style="float:right;font-size:80%;padding:1px 5px;border:1px solid #999;color:#852;background-color:#dca;">{tr}inherited{/tr}</span>{/if}
{tr}{$perms[user].permDesc}{/tr}</td>
</tr>
{/section}
</table>
<input type="submit" name="update" value="{tr}Update{/tr}" />
<br/>
{remarksbox type="warning" title="{tr}Advanced feature{/tr}"}{tr}Level configuration{/tr}:
{if $advanced_features ne 'y'}
<a href="tiki-assignpermission.php?find={$find}&amp;type={$type}&amp;group={$group|escape:url}&amp;sort_mode={$sort_mode}&amp;advanced_features=y">{tr}Show{/tr}</a>
{else}
<a href="tiki-assignpermission.php?find={$find}&amp;type={$type}&amp;group={$group|escape:url}&amp;sort_mode={$sort_mode}">{tr}Hide{/tr}</a>
{/if}
</form>
<div {if $advanced_features ne 'y'}style="display:none;"{else}style="display:block;"{/if}>
<h2>{tr}Create level{/tr}</h2>
<form method="post" action="tiki-assignpermission.php">
<input type="hidden" name="group" value="{$group|escape}" />
<input type="hidden" name="type" value="{$type|escape}" />
{tr}Create level{/tr}: <input type="text" name="level" /><input type="submit" name="createlevel" value="{tr}Create{/tr}" />
</form>
<br />
<br />
<form method="post" action="tiki-assignpermission.php">
<input type="hidden" name="group" value="{$group|escape}" />
<input type="hidden" name="type" value="{$type|escape}" />
<select name="oper">
<option value="assign">{tr}Assign{/tr}</option>
<option value="remove">{tr}Remove{/tr}</option>
</select>
{tr}all permissions in level{/tr}:  
<select name="level[]" multiple="multiple" size="5">
{html_options output=$levels values=$levels selected=$perms[user].level}
</select>
<input type="submit" name="allper" value="{tr}Update{/tr}" />
</form>
{/remarksbox}
</div><!-- END of {$smarty.template} -->
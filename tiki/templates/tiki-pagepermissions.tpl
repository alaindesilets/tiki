{* $Header: /cvsroot/tikiwiki/tiki/templates/tiki-pagepermissions.tpl,v 1.8 2003-08-01 10:31:11 redflo Exp $ *}

<h2>{tr}Assign permissions to page{/tr}: {$page}</h2>
<h3>{tr}Current permissions for this page{/tr}:</h3>
<table class="normal">
<tr><td class="heading">{tr}group{/tr}</td><td class="heading">{tr}permission{/tr}</td><td class="heading">{tr}action{/tr}</td></tr>
{cycle print=false values="even,odd"}
{section  name=pg loop=$page_perms}
<tr>
  <td class="{cycle advance=false}">{$page_perms[pg].groupName}</td>
  <td class="{cycle advance=false}">{$page_perms[pg].permName}</td>
  <td class="{cycle}">
    (<a class="link" href="tiki-pagepermissions.php?referer={$referer}&amp;action=remove&amp;objectName={$objectName}&amp;objectId={$objectId}&amp;objectType={$objectType}&amp;permType={$permType}&amp;page={$page}&perm={$page_perms[pg].permName}&group={$page_perms[pg].groupName}">{tr}remove{/tr}</a>)
  </td></tr>
{sectionelse}
<tr><td>{tr}No individual permissions global permissions apply{/tr}</td></tr>
{/section}
</table>
<h3>{tr}Assign permissions to this page{/tr}</h3>
<form method="post" action="tiki-pagepermissions.php">
<input type="hidden" name="page" value="{$page|escape}" />
<input type="submit" name="assign" value="{tr}assign{/tr}" />
<select name="perm">
{section name=prm loop=$perms}
<option value="{$perms[prm].permName|escape}">{$perms[prm].permName}</option>
{/section}
</select>
{tr}to group{/tr}:
<select name="group">
{section name=grp loop=$groups}
<option value="{$groups[grp].groupName|escape}">{$groups[grp].groupName}</option>
{/section}
</select>
</form>
<h2>{tr}Send email notifications when this page changes to{/tr}:</h2>
<form action="tiki-pagepermissions.php" method="post">
<input type="hidden" name="page" value="{$page|escape}" />
{tr}add email{/tr}: <input type="text" name="email" />
<input type="submit" name="addemail" value="{tr}add{/tr}" />
</form>
<h3>{tr}Notifications{/tr}:</h3>
{section name=ix loop=$emails}
{$emails[ix]} (<a class="link" href="tiki-pagepermissions.php?page={$page}&amp;removeemail={$emails[ix]}">x</a>)<br/>
{/section}

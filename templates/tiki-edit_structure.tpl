<h1><a class="pagetitle" href="tiki-edit_structure.php?page_ref_id={$page_ref_id}">
  {if $editable == 'y'}{tr}Modify Structure{/tr}{else}{tr}Structure{/tr}{/if}: {$structure_name}
</a></h1>
<div class="navbar"><a class="linkbut" href="tiki-admin_structures.php?parentId={$parentId}" title="{tr}Structures{/tr}">{tr}Structures{/tr}</a></div>
{if $remove eq 'y'}
{tr}You will remove{/tr} '{$removePageName}' {if $page_removable == 'y'}{tr}and its subpages from the structure, now you have two options:{/tr}{else}{tr}and its subpages from the structure{/tr}{/if}
<ul>
<li><a class="link" href="tiki-edit_structure.php?page_ref_id={$removepage}&amp;rremove={$removepage}">{tr}Remove only from structure{/tr}</a></li>
{if $page_removable == 'y'}<li><a class="link" href="tiki-edit_structure.php?page_ref_id={$removepage}&amp;sremove={$removepage}">{tr}Remove from structure and remove page too{/tr}</a></li>{/if}
</ul>
<br />
{/if}

{if $alert_exists eq 'y'}
<strong>{tr}The page already exists. The page that has been added to the structure is the existing one.{/tr}</strong>
<br />
{/if}

<h2>{tr}Structure Layout{/tr}</h2>

<table>
{section name=ix loop=$subtree}
{if $subtree[ix].first or not $subtree[ix].last}
<tr {if $page_ref_id eq $subtree[ix].page_ref_id}class="even"{else}class="odd"{/if}>
{if $subtree[ix].pos eq ''}
	<td class="heading"><a class='link' href='tiki-index.php?page={$subtree[ix].pageName|escape:"url"}' title="{tr}view{/tr}"><img src="pics/icons/magnifier.png" border="0" width="16" height="16" alt="{tr}view{/tr}" /></a>
		{if $editable == 'y'}<a class="link" href='tiki-editpage.php?page={$subtree[ix].pageName|escape:"url"}'><img border='0' title='{tr}edit{/tr}' alt='{tr}edit{/tr}' src='pics/icons/page_edit.png' height='16' width='16' /></a>{/if}</td>
	<td class="heading">
		<a class='link' href='tiki-edit_structure.php?page_ref_id={$subtree[ix].page_ref_id}'><b>{$subtree[ix].pageName}{if $subtree[ix].page_alias} ({$subtree[ix].page_alias}){/if}</b></a>
	</td>
{else}
	<td {if $page_ref_id eq $subtree[ix].page_ref_id}style="border-style:dotted; border-width:1px; border-color:gray;"{/if}>
	<!--
		<a href='tiki-edit_structure.php?page_ref_id={$subtree[ix].page_ref_id}&amp;move_node=1'><img src="img/icons2/nav_dot_right.gif" hspace="3" height="11" width="8" border="0" title="{tr}Promote{/tr}" alt="{tr}Promote{/tr}" /></a>
		<a href='tiki-edit_structure.php?page_ref_id={$subtree[ix].page_ref_id}&amp;move_node=4'><img src="img/icons2/nav_dot_left.gif" hspace="3" height="11" width="8" border="0" title="{tr}Demote{/tr}" alt="{tr}Demote{/tr}" /></a>
		<a href='tiki-edit_structure.php?page_ref_id={$subtree[ix].page_ref_id}&amp;move_node=2'><img src="img/icons2/nav_home.gif" hspace="3" height="11" width="13" border="0" title="{tr}Previous{/tr}" alt="{tr}Previous{/tr}" /></a>
		<a href='tiki-edit_structure.php?page_ref_id={$subtree[ix].page_ref_id}&amp;move_node=3'><img src="img/icons2/nav_down.gif" hspace="3" height="11" width="13" border="0" title="{tr}Next{/tr}" alt="{tr}Next{/tr}" /></a>
	-->
		{if $editable == 'y'}<a href='tiki-edit_structure.php?page_ref_id={$subtree[ix].page_ref_id}&amp;move_node=1'><img src="pics/icons/resultset_previous.png" height="16" width="16" border="0" title="{tr}Promote{/tr}" alt="{tr}Promote{/tr}" /></a><a href='tiki-edit_structure.php?page_ref_id={$subtree[ix].page_ref_id}&amp;move_node=4'><img src="pics/icons/resultset_next.png" height="16" width="16" border="0" title="{tr}Demote{/tr}" alt="{tr}Demote{/tr}" /></a><a href='tiki-edit_structure.php?page_ref_id={$subtree[ix].page_ref_id}&amp;move_node=2'><img src="pics/icons/resultset_up.png" height="16" width="16" border="0" title="{tr}Previous{/tr}" alt="{tr}Previous{/tr}" /></a><a href='tiki-edit_structure.php?page_ref_id={$subtree[ix].page_ref_id}&amp;move_node=3'><img src="pics/icons/resultset_down.png" height="16" width="16" border="0" title="{tr}Next{/tr}" alt="{tr}Next{/tr}" style="margin-right:10px;"/>{/if}</a>
		{if $subtree[ix].viewable == 'y'}<a class='link' href='tiki-index.php?page_ref_id={$subtree[ix].page_ref_id}' title="{tr}view{/tr}"><img src="pics/icons/magnifier.png" border="0" width="16" height="16" alt="{tr}view{/tr}" /></a>{else}&nbsp;{/if}
		{if $subtree[ix].editable == 'y'}<a class="link" href='tiki-editpage.php?page={$subtree[ix].pageName|escape:"url"}'><img border='0' title='{tr}edit{/tr}' alt='{tr}edit{/tr}' src='pics/icons/page_edit.png' height='16' width='16' /></a>{/if}
		{if $editable == 'y'}<a class='link' href='tiki-edit_structure.php?page_ref_id={$subtree[ix].page_ref_id}&amp;remove={$subtree[ix].page_ref_id}'><img src='pics/icons/cross.png' border='0' alt='{tr}delete{/tr}' title='{tr}delete{/tr}' width='16' height='16' style="margin-right:20px;"/></a>{/if}
	</td>
	<td {if $page_ref_id eq $subtree[ix].page_ref_id}style="border-style:dotted; border-width:1px; border-color:gray;"{/if}>
		{if $page_ref_id eq $subtree[ix].page_ref_id}<b>{/if}
		{$subtree[ix].pos} &nbsp; {if $editable == 'y'}<a class='link' href='tiki-edit_structure.php?page_ref_id={$subtree[ix].page_ref_id}'>{/if}{$subtree[ix].pageName}{if $subtree[ix].page_alias} ({$subtree[ix].page_alias}){/if}{if $editable == 'y'}</a>{/if}
		{if $page_ref_id eq $subtree[ix].page_ref_id}</b>{/if}
	</td>
{/if}
</tr>
{/if}
{/section}
</table>

{if $editable == 'y'}
<form action="tiki-edit_structure.php" method="post">
<input type="hidden" name="page_ref_id" value="{$page_ref_id}" />

<h2>{tr}Current Node{/tr}: {$pageName}</h2>
<table class="normal">
  <tr>
  <td class="formcolor">{tr}Page alias{/tr}</td>
  <td class="formcolor">
  <input type="text" name="pageAlias" value="{$pageAlias}" />  <input type="submit" name="create" value="{tr}update{/tr}" />
  </td>
  </tr>
  <tr>
  <td class="formcolor">{tr}Move{/tr}</td>
  <td class="formcolor">
  <a href='tiki-edit_structure.php?page_ref_id={$page_ref_id}&amp;move_node=1'><img src="pics/icons/resultset_previous.png" height="16" width="16" border="0" title="{tr}Promote{/tr}" alt="{tr}Promote{/tr}" /></a><a href='tiki-edit_structure.php?page_ref_id={$page_ref_id}&amp;move_node=4'><img src="pics/icons/resultset_next.png" height="16" width="16" border="0" title="{tr}Demote{/tr}" alt="{tr}Demote{/tr}" /></a><a href='tiki-edit_structure.php?page_ref_id={$page_ref_id}&amp;move_node=2'><img src="pics/icons/resultset_up.png" height="16" width="16" border="0" title="{tr}Previous{/tr}" alt="{tr}Previous{/tr}" /></a><a href='tiki-edit_structure.php?page_ref_id={$page_ref_id}&amp;move_node=3'><img src="pics/icons/resultset_down.png" height="16" width="16" border="0" title="{tr}Next{/tr}" alt="{tr}Next{/tr}" style="margin-right:10px;"/></a>
  </td>
  </tr>
</table>
<h3>{tr}Add pages to current node{/tr}:</h3>
<table class="normal">
  <tr>
  <td class="formcolor">
  {tr}After page{/tr}
  </td>
  <td class="formcolor">
  <select name="after_ref_id">
  {section name=ix loop=$subpages}
  <option value="{$subpages[ix].page_ref_id}" {if $insert_after eq $subpages[ix].page_ref_id}selected="selected"{/if}>{$subpages[ix].pageName}</option>
  {/section}
  </select>
  </td>
  </tr>
  <tr>
  <td class="formcolor">
  {tr}create page{/tr}
  </td>
  <td class="formcolor">
  <input type="text" name="name" />
  </td>
  </tr>
  <tr>
  <td class="formcolor">
  {tr}Use pre-existing page{/tr}<br />
        <input type="text" name="find_objects" value="{$find_objects|escape}" />
        <input type="submit" value="{tr}filter{/tr}" name="search_objects" />
        {if $feature_categories eq 'y'}	
		<select name="categId">
		<option value='' {if $find_categId eq ''}selected="selected"{/if}>{tr}any category{/tr}</option>
		{section name=ix loop=$categories}
			<option value="{$categories[ix].categId|escape}" {if $find_categId eq $categories[ix].categId}selected="selected"{/if}>{tr}{$categories[ix].categpath}{/tr}</option>
		{/section}
		</select>
		{/if}
  </td>
  <td class="formcolor">
  <select name="name2[]" multiple="multiple" size="8">
  {section name=list loop=$listpages}
  <option value="{$listpages[list].pageName|escape}">{$listpages[list].pageName|truncate:40:"(...)":true}</option>
  {/section}
  </select>
  </td>
  </tr>
  <tr>
  <td class="formcolor">&nbsp;</td>
  <td class="formcolor">
  <input type="submit" name="create" value="{tr}update{/tr}" />
  </td>
  </tr>
</tr>
</table>
</form>

<br />
{/if}{* end of if structure editable *}

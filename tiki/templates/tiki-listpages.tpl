{* $Header: /cvsroot/tikiwiki/tiki/templates/tiki-listpages.tpl,v 1.27 2004-07-16 19:40:38 teedog Exp $ *}

<a href="tiki-listpages.php" class="pagetitle">{tr}List Wiki Pages{/tr}</a><br /><br />
{if $tiki_p_admin eq 'y'}
<a href="tiki-admin.php?page=wiki"><img src='img/icons/config.gif' border='0'  alt="{tr}configure listing{/tr}" title="{tr}configure listing{/tr}" /></a>
<br />
{if $tikifeedback}
<div class="simplebox {if $tikifeedback[n].num > 0} highlight{/if}">{section name=n loop=$tikifeedback}{$tikifeedback[n].mes}<br />{/section}</div>
{/if}
<br />
{/if}
<table class="findtable">
<tr><td class="findtitle">{tr}Find{/tr}</td>
   <td class="findtitle">
   <form method="get" action="tiki-listpages.php">
     <input type="text" name="find" value="{$find|escape}" />
     <input type="submit" name="search" value="{tr}find{/tr}" />
     <input type="hidden" name="sort_mode" value="{$sort_mode|escape}" />
   </form>
   </td>
</tr>

<form method="post" action="tiki-listpages.php">
<tr><td colspan="2">Show
<select name="max_records" onchange="this.form.submit();">
<option value="10" {if $maxRecords eq 10}selected {/if}>10</option>
<option value="20" {if $maxRecords eq 20}selected {/if}>20</option>
<option value="50" {if $maxRecords eq 50}selected {/if}>50</option>
<option value="100" {if $maxRecords eq 100}selected {/if}>100</option>
{if $tiki_p_admin eq y}
<option value="250" {if $maxRecords eq 250}selected {/if}>250</option>
<option value="500" {if $maxRecords eq 500}selected {/if}>500</option>
<option value="1000" {if $maxRecords eq 500}selected {/if}>1000</option>
{/if}
</select>
per page</td></tr>

</table>
<div align="center">
<form name="checkform" method="post" action="{$smarty.server.PHP_SELF}">
<input type="hidden" name="offset" value="{$offset|escape}" />
<input type="hidden" name="sort_mode" value="{$sort_mode|escape}" />
<table class="normal">
<tr>
{*  at the moment, the only working option to use the checkboxes for is deleting pages.
    so for now the checkboxes are visible iff $tiki_p_remove is set. Other applications make 
    sense as well (categorize, convert to pdf, etc). Add necessary corresponding permission here:
*}    
{if $tiki_p_admin eq 'y' || $tiki_p_remove eq 'y' || $tiki_p_admin_categories eq 'y'}              {* ... "or $tiki_p_other_sufficient_condition_for_checkboxes eq 'y'"  *}
  {assign var='checkboxes_on' value='y'}
{else}
  {assign var='checkboxes_on' value='n'}
{/if}
{if $checkboxes_on eq 'y'}
  <td class="heading">&nbsp;</td>
{/if}
{if $wiki_list_name eq 'y'}
	<td class="heading"><a class="tableheading" href="tiki-listpages.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'pageName_desc'}pageName_asc{else}pageName_desc{/if}">{tr}Page{/tr}</a></td>
{/if}
{if $wiki_list_hits eq 'y'}
	<td style="text-align:right;" class="heading"><a class="tableheading" href="tiki-listpages.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'hits_desc'}hits_asc{else}hits_desc{/if}">{tr}Hits{/tr}</a></td>
{/if}
{if $wiki_list_lastmodif eq 'y'}
	<td class="heading"><a class="tableheading" href="tiki-listpages.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'lastModif_desc'}lastModif_asc{else}lastModif_desc{/if}">{tr}Last mod{/tr}</a></td>
{/if}
{if $wiki_list_creator eq 'y'}
	<td class="heading"><a class="tableheading" href="tiki-listpages.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'creator_desc'}creator_asc{else}creator_desc{/if}">{tr}Creator{/tr}</a></td>
{/if}

{if $wiki_list_user eq 'y'}
	<td class="heading"><a class="tableheading" href="tiki-listpages.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'user_desc'}user_asc{else}user_desc{/if}">{tr}Last author{/tr}</a></td>
{/if}
{if $wiki_list_lastver eq 'y'}
	<td style="text-align:right;" class="heading"><a class="tableheading" href="tiki-listpages.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'version_desc'}version_asc{else}version_desc{/if}">{tr}Last ver{/tr}</a></td>
{/if}
{if $wiki_list_comment eq 'y'}
	<td class="heading"><a class="tableheading" href="tiki-listpages.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'comment_desc'}comment_asc{else}comment_desc{/if}">{tr}Com{/tr}</a></td>
{/if}
{if $wiki_list_status eq 'y'}
	<td style="text-align:center;" class="heading"><a class="tableheading" href="tiki-listpages.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'flag_desc'}flag_asc{else}flag_desc{/if}">{tr}Status{/tr}</a></td>
{/if}
{if $wiki_list_versions eq 'y'}
	<td style="text-align:right;" class="heading"><a class="tableheading" href="tiki-listpages.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'versions_desc'}versions_asc{else}versions_desc{/if}">{tr}Vers{/tr}</a></td>
{/if}
{if $wiki_list_links eq 'y'}
	<td style="text-align:right;" class="heading"><a class="tableheading" href="tiki-listpages.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'links_desc'}links_asc{else}links_desc{/if}">{tr}Links{/tr}</a></td>
{/if}
{if $wiki_list_backlinks eq 'y'}
	<td style="text-align:right;" class="heading"><a class="tableheading" href="tiki-listpages.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'backlinks_desc'}backlinks_asc{else}backlinks_desc{/if}">{tr}Backlinks{/tr}</a></td>
{/if}
{if $wiki_list_size eq 'y'}
	<td style="text-align:right;" class="heading"><a class="tableheading" href="tiki-listpages.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'size_desc'}size_asc{else}size_desc{/if}">{tr}Size{/tr}</a></td>
{/if}
</tr>
{cycle values="even,odd" print=false}
{section name=changes loop=$listpages}
<tr>
{if $checkboxes_on eq 'y'}
<td class="{cycle advance=false}"><input type="checkbox" name="checked[]" value="{$listpages[changes].pageName|escape}" {if $listpages[changes].checked eq 'y'}checked="checked" {/if}/></td>
{/if}
{if $wiki_list_name eq 'y'}
	<td class="{cycle advance=false}"><a href="tiki-index.php?page={$listpages[changes].pageName|escape:"url"}" class="link" title="{$listpages[changes].pageName}">{$listpages[changes].pageName|truncate:20:"...":true}</a>
	{if $tiki_p_edit eq 'y'}
	<br />(<a class="link" href="tiki-editpage.php?page={$listpages[changes].pageName|escape:"url"}">{tr}edit{/tr}</a>)
	{/if}
	</td>
{/if}
{if $wiki_list_hits eq 'y'}	
	<td style="text-align:right;" class="{cycle advance=false}">{$listpages[changes].hits}</td>
{/if}
{if $wiki_list_lastmodif eq 'y'}
	<td class="{cycle advance=false}">{$listpages[changes].lastModif|tiki_short_datetime}</td>
{/if}
{if $wiki_list_creator eq 'y'}
	<td class="{cycle advance=false}">{$listpages[changes].creator|userlink}</td>
{/if}

{if $wiki_list_user eq 'y'}
	<td class="{cycle advance=false}">{$listpages[changes].user|userlink}</td>
{/if}
{if $wiki_list_lastver eq 'y'}
	<td style="text-align:right;" class="{cycle advance=false}">{$listpages[changes].version}</td>
{/if}
{if $wiki_list_comment eq 'y'}
	<td class="{cycle advance=false}">{$listpages[changes].comment}</td>
{/if}
{if $wiki_list_status eq 'y'}
	<td style="text-align:center;" class="{cycle advance=false}">
	{if $listpages[changes].flag eq 'locked'}
		<img src='img/icons/lock_topic.gif' alt='{tr}locked{/tr}' />
	{else}
		<img src='img/icons/unlock_topic.gif' alt='{tr}unlocked{/tr}' />
	{/if}
	</td>
{/if}
{if $wiki_list_versions eq 'y'}
	{if $feature_history eq 'y'}
	<td style="text-align:right;" class="{cycle advance=false}"><a class="link" href="tiki-pagehistory.php?page={$listpages[changes].pageName|escape:"url"}">{$listpages[changes].versions}</a></td>
	{else}
	<td style="text-align:right;" class="{cycle advance=false}">{$listpages[changes].versions}</td>
	{/if}
{/if}
{if $wiki_list_links eq 'y'}
	<td style="text-align:right;" class="{cycle advance=false}">{$listpages[changes].links}</td>
{/if}
{if $wiki_list_backlinks eq 'y'}
	{if $feature_backlinks eq 'y'}
	<td style="text-align:right;" class="{cycle advance=false}"><a class="link" href="tiki-backlinks.php?page={$listpages[changes].pageName|escape:"url"}">{$listpages[changes].backlinks}</a></td>
	{else}
	<td style="text-align:right;" class="{cycle advance=false}">{$listpages[changes].backlinks}</td>
	{/if}
{/if}
{if $wiki_list_size eq 'y'}
	<td style="text-align:right;" class="{cycle advance=false}">{$listpages[changes].len|kbsize}</td>
{/if}
       {cycle print=false}
</tr>
{sectionelse}
<tr><td colspan="16">
<b>{tr}No records found{/tr}</b>
</td></tr>
{/section}
{if $checkboxes_on eq 'y'}
  <script language='Javascript' type='text/javascript'>
  <!--
  // check / uncheck all.
  // in the future, we could extend this to happen serverside as well for the convenience of people w/o javascript.
  // for now those people just have to check every single box
  document.write("<tr><td><input name=\"switcher\" id=\"clickall\" type=\"checkbox\" onclick=\"switchCheckboxes(this.form,'checked[]',this.checked)\"/></td>");
  document.write("<td colspan=\"15\"><label for=\"clickall\">{tr}select all{/tr}</label></td></tr>");
  //-->                     
  </script>
{/if}
</table>
{if $checkboxes_on eq 'y'} {* what happens to the checked items? *}
  <p align="left"> {*on the left to have it close to the checkboxes*}
  {if $categorize_mode neq 'y'}
  {tr}Perform action with checked:{/tr}
  <select name="submit_mult">
    <option value="" selected>-</option>
    {if $tiki_p_remove eq 'y'} 
      <option value="remove_pages" >{tr}remove{/tr}</option>
    {/if}
    {* add here e.g. <option value="categorize" >{tr}categorize{/tr}</option> *}
    {if $feature_categories eq 'y' && $tiki_p_admin_categories eq 'y'}
      <option value="categorize" >{tr}categorize{/tr}</option>
    {/if}
  </select>
{*
  <script language='Javascript' type='text/javascript'>
  <!--
  // Fake js to allow the use of the <noscript> tag (so non-js-users can still submit)
  //
  -->
  </script>
  <noscript>
*}
<input type="submit" value="{tr}ok{/tr}" />
{*</noscript>*}
  {else}
  <select name="categorization">
  	<option value="add">{tr}Add selected to{/tr}</option>
  	<option value="remove">{tr}Remove selected from{/tr}</option>
  </select>
  {tr}the following categories:{/tr}
  {section name=ix loop=$categories}
  	<br /><input type="checkbox" name="cat_categories[]" value="{$categories[ix].categId|escape}" /> <a class="link" href="tiki-admin_categories.php?parentId={$categories[ix].categId}" title="{tr}edit{/tr}">{$categories[ix].categpath}</a>
  {/section}
  <br /><input type="submit" value="{tr}ok{/tr}" />
  {/if}

  </p>
{/if}
</form>
<br />
<div class="mini">
{if $prev_offset >= 0}
[<a class="prevnext" href="tiki-listpages.php?find={$find}&amp;offset={$prev_offset}&amp;sort_mode={$sort_mode}&amp;max_records={$maxRecords}">{tr}prev{/tr}</a>]
{/if}
{tr}Page{/tr}: {$actual_page}/{$cant_pages}
{if $next_offset >= 0}
[<a class="prevnext" href="tiki-listpages.php?find={$find}&amp;offset={$next_offset}&amp;sort_mode={$sort_mode}&amp;max_records={$maxRecords}">{tr}next{/tr}</a>]
{/if}
{if $direct_pagination eq 'y'}
<br />
{section loop=$cant_pages name=foo}
{assign var=selector_offset value=$smarty.section.foo.index|times:$maxRecords}
<a class="prevnext" href="tiki-listpages.php?find={$find}&amp;offset={$selector_offset}&amp;sort_mode={$sort_mode}">
{$smarty.section.foo.index_next}</a>
{/section}
{/if}
</div>
</div>


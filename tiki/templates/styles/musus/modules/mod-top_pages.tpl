{* $Header: /cvsroot/tikiwiki/tiki/templates/styles/musus/modules/mod-top_pages.tpl,v 1.1 2004-01-07 04:31:24 musus Exp $ *}

{if $feature_wiki eq 'y'}
   {if $nonums eq 'y'}
   {eval var="{tr}Top `$module_rows` Pages{/tr}" assign="tpl_module_title"}
   {else}
   {eval var="{tr}Top Pages{/tr}" assign="tpl_module_title"}
   {/if}

  {tikimodule title=$tpl_module_title name="top_pages"}
  <table  border="0" cellpadding="0" cellspacing="0">
  {section name=ix loop=$modTopPages}
     <tr>{if $nonums != 'y'}<td class="module" valign='top'>{$smarty.section.ix.index_next})</td>{/if}
     <td class="module"><a class="linkmodule" href="tiki-index.php?page={$modTopPages[ix].pageName}">{$modTopPages[ix].pageName}</a></td></tr>
  {/section}
  </table>
  {/tikimodule}
{/if}

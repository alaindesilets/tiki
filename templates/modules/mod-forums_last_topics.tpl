{* $Header: /cvsroot/tikiwiki/tiki/templates/modules/mod-forums_last_topics.tpl,v 1.12 2007-05-31 09:42:59 nyloth Exp $ *}

{if $feature_forums eq 'y'}
{if !isset($tpl_module_title)}
{if $nonums eq 'y'}
{eval var="{tr}Last `$module_rows` forum topics{/tr}" assign="tpl_module_title"}
{else}
{eval var="{tr}Last forum topics{/tr}" assign="tpl_module_title"}
{/if}
{/if}
{tikimodule title=$tpl_module_title name="forums_last_topics" flip=$module_params.flip decorations=$module_params.decorations}
  <table  border="0" cellpadding="1" cellspacing="0" width="100%">
    {section name=ix loop=$modForumsLastTopics}
      <tr>
        {if $nonums != 'y'}<td valign="top" class="module">{$smarty.section.ix.index_next})</td>{/if}
        <td class="module">
		  {if $absurl == 'y'}
          <a class="linkmodule" href="{$base_url}{$modForumsLastTopics[ix].href}">
            {$modForumsLastTopics[ix].name}
          </a>
		  {else}
          <a class="linkmodule" href="{$modForumsLastTopics[ix].href}">
            {$modForumsLastTopics[ix].name}
          </a>
		  {/if}
        </td>
      </tr>
    {/section}
  </table>
{/tikimodule}
{/if}

{* $Header: /cvsroot/tikiwiki/tiki/templates/modules/mod-forums_most_read_topics.tpl,v 1.8 2005-03-12 16:51:00 mose Exp $ *}

{if $feature_forums eq 'y'}
{if $nonums eq 'y'}
{eval var="`$module_rows` {tr}Most read topics{/tr}" assign="tpl_module_title"}
{else}
{eval var="{tr}Most read topics{/tr}" assign="tpl_module_title"}
{/if}
{tikimodule title=$tpl_module_title name="forums_most_read_topics" flip=$module_params.flip decorations=$module_params.decorations}
  <table  border="0" cellpadding="0" cellspacing="0">
    {section name=ix loop=$modForumsMostReadTopics}
      <tr>
        {if $nonums != 'y'}<td class="module" valign="top">{$smarty.section.ix.index_next})</td>{/if}
        <td class="module">
          <a class="linkmodule" href="{$modForumsMostReadTopics[ix].href}">
            {$modForumsMostReadTopics[ix].name}
          </a>
        </td>
      </tr>
    {/section}
  </table>
{/tikimodule}
{/if}

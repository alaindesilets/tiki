{* $Header: /cvsroot/tikiwiki/tiki/templates/modules/mod-last_created_quizzes.tpl,v 1.7 2003-11-24 01:33:46 zaufi Exp $ *}

{if $feature_quizzes eq 'y'}
{if $nonums eq 'y'}
{eval var="{tr}Last `$module_rows` Created Quizzes{/tr}" assign="tpl_module_title"}
{else}
{eval var="{tr}Last Created Quizzes{/tr}" assign="tpl_module_title"}
{/if}
{tikimodule title=$tpl_module_title name="last_created_quizzes"}
  <table  border="0" cellpadding="0" cellspacing="0">
    {section name=ix loop=$modLastCreatedQuizzes}
      <tr>
        {if $nonums != 'y'}<td class="module" valign="top">{$smarty.section.ix.index_next})</td>{/if}
        <td class="module">
          <a class="linkmodule" href="tiki-take_quiz.php?quizId={$modLastCreatedQuizzes[ix].quizId}">
            {$modLastCreatedQuizzes[ix].name}
          </a>
        </td>
      </tr>
    {/section}
  </table>
{/tikimodule}
{/if}

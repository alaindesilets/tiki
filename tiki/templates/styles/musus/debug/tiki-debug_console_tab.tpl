{* $Header: /cvsroot/tikiwiki/tiki/templates/styles/musus/debug/tiki-debug_console_tab.tpl,v 1.2 2004-01-13 19:40:35 musus Exp $ *}
{* Debug console tab -- to display result of command *}

{* Display command results if we have smth to show... *}
{if $result_type ne NO_RESULT}
  <pre>&gt;&nbsp;{$command|escape:"html"}</pre>
  {if    $result_type == TEXT_RESULT }
    {* Show text in PRE section *}
    <pre>{strip}{$command_result|escape:"html"|wordwrap:90:"\n":true|replace:"\n":"<br/>"}{/strip}</pre>
  {elseif $result_type == HTML_RESULT }

    {* Type HTML as is *}
    {$command_result}

  {elseif $result_type == TPL_RESULT && strlen($result_tpl) > 0}

    {* Result have its own template *}
    {include file=$result_tpl}

  {/if}{* Check result type *}
<br/>
{/if}{* We have something to show as result *}
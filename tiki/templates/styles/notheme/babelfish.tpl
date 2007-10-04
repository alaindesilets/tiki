{* $Header: /cvsroot/tikiwiki/tiki/templates/styles/notheme/babelfish.tpl,v 1.4 2007-10-04 22:17:49 nyloth Exp $ *}

{if $prefs.feature_babelfish eq 'y' and $prefs.feature_babelfish_logo eq 'y'}

<table width="100%">
  {section loop=$babelfish_links name=i}
    <tr>
      {if $smarty.section.i.index == 0}
        <td>
          <a href="{$babelfish_links[i].href}" target="{$babelfish_links[i].target}"> {$babelfish_links[i].msg} </a>
        </td>
        <td rowspan="{$smarty.section.i.total}" align=right>
          {$babelfish_logo}
        </td>
      {else}
        <td>
          <a href="{$babelfish_links[i].href}" target="{$babelfish_links[i].target}"> {$babelfish_links[i].msg} </a>
        </td>
      {/if}
    </tr>
  {/section}
</table>

{elseif $prefs.feature_babelfish eq 'y' and $prefs.feature_babelfish_logo eq 'n'}

<table width="100%">
  {section loop=$babelfish_links name=i}
  <tr> <td align="center">
    <a href="{$babelfish_links[i].href}" target="{$babelfish_links[i].target}"> {$babelfish_links[i].msg} </a>
  </td> </tr>
  {/section}
</table>

{elseif $prefs.feature_babelfish eq 'n' and $prefs.feature_babelfish_logo eq 'y'}

<div align="center">
  {$babelfish_logo}
</div>

{/if}

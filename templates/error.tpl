{* Index we display a wiki page here *}
{include file="header.tpl"}
<div id="tiki-main">
  <div id="tiki-top">
    {include file="tiki-top_bar.tpl"}
  </div>
  <div id="tiki-mid">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
      <td id="leftcolumn">
      {section name=homeix loop=$left_modules}
      {$left_modules[homeix].data}
      {/section}
      </td>
      <td id="centercolumn"><div id="tiki-center">
      <br/>
        <div class="cbox">
        <div class="cbox-title">
        {tr}Error{/tr}
        </div>
        <div class="cbox-data">
        {$msg}<br/><br/>
        <a href="{$tikiIndex}" class="linkmenu">{tr}Return to home page{/tr}</a>
        </div>
        </div>
      </div></td>
      <td id="rightcolumn">
      {section name=homeix loop=$right_modules}
      {$right_modules[homeix].data}
      {/section}
      </td>
    </tr>
    </table>
  </div>
  <div id="tiki-bot">
    {include file="tiki-bot_bar.tpl"}
  </div>
</div>
{include file="footer.tpl"}

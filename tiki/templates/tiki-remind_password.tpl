<h1>{tr}I forgot my password{/tr}</h1>

{if $showmsg ne 'n'}
  {if $showmsg eq 'e'}<span class="warn">{/if}
  {$msg}
  {if $showmsg eq 'e'}</span>{/if}
  <br /><br />
{/if}

{if $showfrm eq 'y'}
  <form action="tiki-remind_password.php" method="post">
  <table class="normal">
  <tr>
    <td class="formcolor"><select name="mode" size=1><option selected value="user">{tr}username{/tr}<option value="email"> {tr}email{/tr}</select></td>
    <td class="formcolor"><input type="text" name="username" /></td>
    <td class="formcolor"><input type="submit" name="remind"
                                 value="{tr}send me my password{/tr}" /></td>
  </tr>  
  </table>
  </form>
{/if}

<br /><br />
<a href="{$tikiIndex}" class="link">{tr}Return to HomePage{/tr}</a>

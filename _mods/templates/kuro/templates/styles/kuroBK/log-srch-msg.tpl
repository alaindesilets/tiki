<!-- kuro-log_srch_msg /-->
<!-- put the login box in the top bar - can't do this until Tiki upgrade - mdavey /-->
    {if $user}
      {tr}logged as{/tr}: {$user}<br />
      <a class="linkmodule" href="tiki-logout.php">{tr}Logout{/tr}</a><br />
      {if $tiki_p_admin eq 'y'}
        <form action="{$login_url}" method="post">
        <label for="login-switchuser">{tr}user{/tr}:</label>
        <input type="text" name="username" id="login-switchuser" size="8" />
        <input type="submit" name="su" value="{tr}set{/tr}" />
        </form>
      {/if}
    {else}
     <form name="loginbox" action="{$login_url}" method="post" {if $feature_challenge eq 'y'}onsubmit="doChallengeResponse()"{/if}> 
     {if $feature_challenge eq 'y'}
     <script language="javascript" type='text/javascript' src="lib/md5.js"></script>   
     {literal}
     <script language='Javascript' type='text/javascript'>
     <!--
     function doChallengeResponse() {
       hashstr = document.loginbox.user.value +
       document.loginbox.pass.value +
       document.loginbox.email.value;
       str = document.loginbox.user.value + 
       MD5(hashstr) +
       document.loginbox.challenge.value;
       document.loginbox.response.value = MD5(str);
       document.loginbox.pass.value='';
       /*
       document.login.password.value = "";
       document.logintrue.username.value = document.login.username.value;
       document.logintrue.response.value = MD5(str);
       document.logintrue.submit();
       */
       document.loginbox.submit();
       return false;
     }
     // -->
    </script>
    {/literal}
     <input type="hidden" name="challenge" value="{$challenge|escape}" />
     <input type="hidden" name="response" value="" />
     {/if} // feature_challenge
      <table border="0">
      <tr>
        <td>
          <table>
          <tr><td class="module"><strong><label for="login-user">{tr}User{/tr}:</label></strong>
          <input type="text" name="user" id="login-user" size="7" maxlenggth="32"/>
          {if $feature_challenge eq 'y'} <!-- quick hack to make challenge/response work until 1.8 tiki auth overhaul -->
          <strong><label for="login-email">{tr}Email{/tr}:</label></strong>
          <input type="text" name="email" id="login-email" size="7" maxlength="32"/>
          {/if}
          <strong><label for="login-pass">{tr}Pass{/tr}:</label></strong>
          <input type="password" name="pass" id="login-pass" size="7" maxlength="32"/>
          <input type="submit" name="login" value="{tr}login{/tr}" /></td></tr>
          {if $rememberme ne 'disabled'}
          <tr><td class="module"><label for="login-remember">{tr}Remember me{/tr}</label> <input type="checkbox" name="rme" id="login-remember" value="on"/></td></tr>
          {/if}
          <tr>
          {if $forgotPass eq 'y' and $allowRegister eq 'y'}
            <td valign="bottom">[ <a class="linkmodule" href="tiki-register.php" title="{tr}Click here to register{/tr}">{tr}register{/tr}</a> | <a class="linkmodule" href="tiki-remind_password.php" title="{tr}Click here if you've forgotten your password{/tr}">{tr}I forgot my pass{/tr}</a> ]</td>
          {/if}
          {if $forgotPass eq 'y' and $allowRegister ne 'y'}
            <td valign="bottom"><a class="linkmodule" href="tiki-remind_password.php" title="{tr}Click here if you've forgotten your password{/tr}">{tr}I forgot my pass{/tr}</a></td>
          {/if}
          {if $forgotPass ne 'y' and $allowRegister eq 'y'}
            <td valign="bottom"><a class="linkmodule" href="tiki-register.php" title="{tr}Click here to register{/tr}">{tr}register{/tr}</a></td>
          {/if}
          {if $forgotPass ne 'y' and $allowRegister ne 'y'}
          <td valign="bottom">&nbsp;</td>
          {/if}
          </tr>
          {if $http_login_url ne '' or $https_login_url ne ''}
          <tr>
          <td valign="bottom">
            <a class="linkmodule" href="{$http_login_url}" title="{tr}Click here to login using the default security protocol{/tr}">{tr}standard{/tr}</a> |
            <a class="linkmodule" href="{$https_login_url}" title="{tr}Click here to login using a secure protocol{/tr}">{tr}secure{/tr}</a>
          </td>
          </tr>
          {/if}
          {if $show_stay_in_ssl_mode eq 'y'}
            <tr>
              <td>
                <label for="login-stayssl">{tr}stay in ssl mode{/tr}:</label>?
                <input type="checkbox" name="stay_in_ssl_mode" id="login-stayssl" {if $stay_in_ssl_mode eq 'y'}checked="checked"{/if} />
              </td>
            </tr>
          {/if}
          </table>
        </td>
      </tr>
      </table>

      {if $show_stay_in_ssl_mode ne 'y'}
        <input type="hidden" name="stay_in_ssl_mode" value="{$stay_in_ssl_mode|escape}" />
      {/if}
      </form>
    {/if} // user

<!-- /kuro-log_srch_msg /-->

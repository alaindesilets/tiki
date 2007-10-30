<div class="rbox" name="tip">
	<div class="rbox-title" name="tip">{tr}Tip{/tr}</div>  
	<div class="rbox-data" name="tip">
	  {tr}Text area (that apply throughout many features){/tr}
        </div>
</div>
<br />

<div class="cbox">
  <div class="cbox-title">
    {tr}{$crumbs[$crumb]->description}{/tr}
    {help crumb=$crumbs[$crumb]}
  </div>


      <form action="tiki-admin.php?page=textarea" method="post">
        <table class="admin">
        <tr>
   
   		<td class="form"> {if $prefs.feature_help eq 'y'}<a href="{$prefs.helpurl}Smiley" target="tikihelp" class="tikihelp" title="{tr}Allow Smileys{/tr}">{/if} {tr}Allow Smileys{/tr} {if $prefs.feature_help eq 'y'}</a>{/if} </td>
        	<td><input type="checkbox" name="feature_smileys" {if $prefs.feature_smileys eq 'y'}checked="checked"{/if}/></td>
       	</tr>
	<tr>
		<td class="form"> {if $prefs.feature_help eq 'y'}<a href="http://tikiwiki.org/tiki-index.php?page=AutoLinks" target="tikihelp" class="tikihelp" title="{tr}AutoLinks{/tr}">{/if} {tr}AutoLinks{/tr} {if $prefs.feature_help eq 'y'}</a>{/if}</td>
		<td><input type="checkbox" name="feature_autolinks" {if $prefs.feature_autolinks eq 'y'}checked="checked"{/if}/></td>
       	</tr>
	<tr>
	        <td class="form"> <label for="general-ext_links">{tr}Open external links in new window{/tr}:</label></td>
	        <td><input type="checkbox" name="popupLinks" id="general-ext_links" {if $prefs.popupLinks eq 'y'}checked="checked"{/if}/></td>
       	</tr>
	<tr>
	        <td class="form"> <label for="quicktags_over_textarea">{tr}Show quicktags over textareas (instead on left side){/tr}:</label></td>
	        <td><input type="checkbox" name="quicktags_over_textarea" id="quicktags_over_textarea" {if $prefs.quicktags_over_textarea eq 'y'}checked="checked"{/if}/></td>
       	</tr>
	<tr>	
		
          <td colspan="2" class="button"><input type="submit" name="textareasetup" value="{tr}Save{/tr}" /></td>
		  
        </tr>
        </table>
      </form>

</div>


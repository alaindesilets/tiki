<form action="tiki-admin.php?page=freetags" method="post">
<div class="cbox">
<table class="admin"><tr><td>
<div style="padding:1em;" align="center"><input type="submit" value="{tr}Change preferences{/tr}" /></div>
{if $prefs.feature_tabs eq 'y'}
			{tabs}{strip}
				{tr}General Settings{/tr}|
				{tr}3D Tag Browser{/tr}
			{/strip}{/tabs}
{/if}

{cycle name=content values="1,2" print=false advance=false reset=true}

    <fieldset{if $prefs.feature_tabs eq 'y'} class="tabcontent" id="content{cycle name=content assign=focustab}{$focustab}"{/if}>
      {if $prefs.feature_tabs neq 'y'}
        <legend class="heading">
          <a href="#content{cycle name=content assign=focus}{$focus}" onclick="flip('content{$focus}'); return false;">
            <span>{tr}General Settings{/tr}</span>
          </a>
        </legend>
        <div id="content{$focus}" style="display:{if !isset($smarty.session.tiki_cookie_jar.show_content.$focus) and $smarty.session.tiki_cookie_jar.show_content.$focus neq 'y'}none{else}block{/if};">
      {/if}

<fieldset><legend>{tr}Freetags{/tr}{if $prefs.feature_help eq 'y'} {help url="Freetags+Config"}{/if}</legend>
<input type="hidden" name="freetagsfeatures" />
<div class="adminoptionbox">
	<div class="adminoption"><input type="checkbox" onclick="flip('showcloud');" id="freetags_browse_show_cloud" name="freetags_browse_show_cloud" {if $prefs.freetags_browse_show_cloud eq 'y'}checked="checked"{/if} /></div>
	<div class="adminoptionlabel"><label for="freetags_browse_show_cloud">{tr}Show tag cloud{/tr}</label>
<div class="adminoptionboxchild" id="showcloud" style="display:{if $prefs.freetags_browse_show_cloud eq 'y'}block{else}none{/if};">
	<div class="adminoptionlabel"><label for="freetags_browse_amount_tags_in_cloud">{tr}Maximum number of tags in cloud{/tr}:</label> <input type="text" id="freetags_browse_amount_tags_in_cloud" name="freetags_browse_amount_tags_in_cloud" value="{$prefs.freetags_browse_amount_tags_in_cloud|escape}" size="3" /></div>
</div>
	</div>
</div>
<div class="adminoptionbox">
	<div class="adminoption"><input type="checkbox" id="freetags_show_middle" name="freetags_show_middle"{if $prefs.freetags_show_middle eq 'y'} checked="checked"{/if} /></div>
	<div class="adminoptionlabel"><label for="freetags_show_middle">{tr}Show freetags in middle column{/tr}.</label></div>
</div>
<div class="adminoptionbox">
	<div class="adminoption"><input type="checkbox" id="freetags_preload_random" name="freetags_preload_random search" {if $prefs.freetags_preload_random_search eq 'y'}checked="checked"{/if} /></div>
	<div class="adminoptionlabel"><label for="freetags_preload_random">{tr}Preload freetag random tag{/tr}.</label><br /><em>{tr}When arriving on <a href="tiki-browse_freetags.php">freetag search page</a>{/tr}.</em></div>
</div>

<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="freetags_cloud_colors">{tr}Random tag cloud colors{/tr}:</label> <input type="text" name="freetags_cloud_colors" id="freetags_cloud_colors" value="{foreach from=$prefs.freetags_cloud_colors item=color naem=colors}{$color}{if !$smarty.foreach.colors.last},{/if}{/foreach}" /><br /><em>{tr}Separate colors with a comma (,){/tr}.</em></div>
</div>
<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="freetags_browse_amount_tags_suggestion">{tr}Number of Tags to show in Tag Suggestions{/tr}:</label> <input type="text" name="freetags_browse_amount_tags_suggestion" id="freetags_browse_amount_tags_suggestion" value="{$prefs.freetags_browse_amount_tags_suggestion|escape}" size="3" /></div>
</div>
<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="freetags_normalized_valid_chars">{tr}Valid characters pattern{/tr}:</label> <input type="text" id="freetags_normalized_valid_chars" name="freetags_normalized_valid_chars" value="{$prefs.freetags_normalized_valid_chars}" />
	<div class="adminoptionboxchild">
	<a class="button" href='#Browsing' onclick="document.getElementById('freetags_normalized_valid_chars').value='a-zA-Z0-9';">{tr}Alphanumeric ASCII characters only{/tr}</a> ({tr}No accents or special characters{/tr}.)<br />
			<a class="button" href='#Browsing' onclick="document.getElementById('freetags_normalized_valid_chars').value='';">{tr}Accept all charactrs{/tr}</a>
	</div>
	</div>
</div>
<div class="adminoptionbox">
	<div class="adminoption"><input type="checkbox" id="freetags_lowercase_only" name="freetags_lowercase_only" {if $prefs.freetags_lowercase_only eq 'y'}checked="checked"{/if} /></div>
	<div class="adminoptionlabel"><label for="freetags_lowercase_only">{tr}Lowercase tags only{/tr}</label></div>
</div>

<div class="adminoptionbox">
	<div class="adminoption"><input type="checkbox" id="freetags_multilingual" name="freetags_multilingual" {if $prefs.freetags_multilingual eq 'y'}checked="checked"{/if} /></div>
	<div class="adminoptionlabel"><label for="freetags_multilingual">{tr}Multilingual freetags{/tr}</label>
	{if $prefs.feature_multilingual ne 'y'}<br />{icon _id=information} {tr}Multiligual disabled{/tr}. <a href=" tiki-admin.php?page=i18n" title="i18n">{tr}Enable now{/tr}</a>.{/if}
	</div>
</div>
<div class="adminoptionbox">
<input type="hidden" name="morelikethisoptions" />
	<div class="adminoptionlabel"><label for="">{tr}&quot;More Like This&quot; algorithm{/tr}:</label> 
	<select name="morelikethis_algorithm" onchange="flip('basicalgorithm');">			
	        <option value="basic"{if $prefs.morelikethis_algorithm eq 'basic' or ! $prefs.morelikethis_algorithm} selected="selected"{/if}>{tr}basic{/tr}</option>
	        <option value="weighted"{if $prefs.morelikethis_algorithm eq 'weighted'} selected="selected"{/if}>{tr}weighted{/tr}</option>
	      </select></div>
</div>
<div class="adminoptionboxchild" id="basicalgorithm" style="display:{if $prefs.morelikethis_algorithm eq 'basic' or ! $prefs.morelikethis_algorithm}block{else}none{/if};">
	<div class="adminoptionlabel"><label for="">{tr}Minimum amount of tags in common{/tr}: </label>
	<select name="morelikethis_basic_mincommon">
	        <option value="1"{if $prefs.morelikethis_basic_mincommon eq '1'} selected="selected"{/if}>1</option>
	        <option value="2"{if $prefs.morelikethis_basic_mincommon eq '2' or ! $prefs.morelikethis_basic_mincommon} selected="selected"{/if}>2</option>
	        <option value="3"{if $prefs.morelikethis_basic_mincommon eq '3'} selected="selected"{/if}>3</option>
	        <option value="4"{if $prefs.morelikethis_basic_mincommon eq '4'} selected="selected"{/if}>4</option>
	        <option value="5"{if $prefs.morelikethis_basic_mincommon eq '5'} selected="selected"{/if}>5</option>
	        <option value="6"{if $prefs.morelikethis_basic_mincommon eq '6'} selected="selected"{/if}>6</option>
	        <option value="7"{if $prefs.morelikethis_basic_mincommon eq '7'} selected="selected"{/if}>7</option>
	        <option value="8"{if $prefs.morelikethis_basic_mincommon eq '8'} selected="selected"{/if}>8</option>
	        <option value="9"{if $prefs.morelikethis_basic_mincommon eq '9'} selected="selected"{/if}>9</option>
	</select>	
	</div>
</div>
{*
        <tr>
          <td class="form">{tr}Tagging remembers tagger{/tr}: </td>
          <td><input type="checkbox" name="freetags_taggers"{if $prefs.freetags_taggers eq 'y'} checked="checked"{/if} /></td>
        <tr>
          <td class="form">{tr}Color of tags used by user{/tr}: </td>
          <td><input type="text" name="freetags_user_color" value="{$prefs.freetags_user_color}" /></td>
        <tr>
*}

</fieldset>

<fieldset><legend>{tr}Tag Management{/tr}</legend>
<div class="adminoptionbox">
	<div class="adminoptionlabel"><div align="center"><input type="submit" value="{tr}Cleanup unused tags{/tr}" name="cleanup" /></div></div></div>
</div>
</fieldset>

     {if $prefs.feature_tabs neq 'y'}</div>{/if}
    </fieldset>

    <fieldset{if $prefs.feature_tabs eq 'y'} class="tabcontent" id="content{cycle name=content assign=focustab}{$focustab}"{/if}>
      {if $prefs.feature_tabs neq 'y'}
        <legend class="heading">
          <a href="#content{cycle name=content assign=focus}{$focus}" onclick="flip('content{$focus}'); return false;">
            <span>{tr}3D Tag Browser{/tr}</span>
          </a>
        </legend>
        <div id="content{$focus}" style="display:{if !isset($smarty.session.tiki_cookie_jar.show_content.$focus) and $smarty.session.tiki_cookie_jar.show_content.$focus neq 'y'}none{else}block{/if};">
      {/if}

<input type="hidden" name="freetagsset3d" />	
{if $prefs.feature_morcego ne "y"}
<div class="adminoptionbox">
	<div class="adminoptionlabel">{icon _id=information} {tr}Morcego 3D browser disabled{/tr}. <a href=" tiki-admin.php?page=features" title="features">{tr}Enable now{/tr}</a>.</div>
</div>
{else}
<div class="adminoptionbox">
	<div class="adminoption"><input type="checkbox" id="freetags_feature_3d" name="freetags_feature_3d" {if $prefs.freetags_feature_3d eq 'y'}checked="checked" {/if}onclick="flip('use3d');" /></div>
	<div class="adminoptionlabel"><label for="freetags_feature_3d">{tr}Enable freetags 3D browser{/tr}</label></div>
</div><br />
{/if}
<div id="use3d" style="display:{if $prefs.freetags_feature_3d eq 'y'}block{else}none{/if};"> 
<fieldset><legend>{tr}General{/tr}</legend>
<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="freetags_3d_width">{tr}Browser width{/tr}:</label> <input type="text" name="freetags_3d_width" id="freetags_3d_width" value="{$prefs.freetags_3d_width|escape}" size="3" /></div>
</div>
<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="freetags_3d_height">{tr}Browser height{/tr}: </label><input type="text" name="freetags_3d_height" id="freetags_3d_height" value="{$prefs.freetags_3d_height|escape}" size="3" /></div>
</div>
</fieldset>

<fieldset><legend>{tr}Graph appearance{/tr}</legend>
<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="freetags_3d_navigation_depth">{tr}Navigation depth{/tr}: <input type="text" name="freetags_3d_navigation_depth" id="freetags_3d_navigation_depth" value="{$prefs.freetags_3d_navigation_depth|escape}" size="2" /></label></div>
</div>
<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="freetags_3d_node_size">{tr}Node size{/tr}: </label><input type="text" name="freetags_3d_node_size" id="freetags_3d_node_size" value="{$prefs.freetags_3d_node_size|default:"30"}" size="2" /></div>
</div>
<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="freetags_3d_text_size">{tr}Text size{/tr}: </label><input type="text" name="freetags_3d_text_size" id="freetags_3d_text_size" value="{$prefs.freetags_3d_text_size|default:"40"}" size="3" /></div>
</div>
<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="freetags_3d_spring_size">{tr}Spring (connection) size{/tr}: <input type="text" name="freetags_3d_spring_size" id="freetags_3d_spring_size" value="{$prefs.freetags_3d_spring_size|default:"100"}" size="3" /></label></div>
</div>
<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="freetags_3d_existing_page_color">{tr}Node color{/tr}: <input type="text" name="freetags_3d_existing_page_color" id="freetags_3d_existing_page_color" value="{$prefs.freetags_3d_existing_page_color|escape}" size="7" /></label></div>
</div>
</fieldset>

<fieldset><legend>{tr}Camera settinsg{/tr}</legend>
<div class="adminoptionbox">
	<div class="adminoption"><input type="checkbox" id="freetags_3d_adjust_camera" name="freetags_3d_adjust_camera" {if $prefs.freetags_3d_adjust_camera eq 'true'}checked="checked"{/if} /></div>
	<div class="adminoptionlabel"><label for="freetags_3d_adjust_camera">{tr}Camera distance adjusted relative to nearest node{/tr}.</label></div>
</div>
<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="freetags_3d_camera_distance">{tr}Camera distance{/tr}: </label><input type="text" name="freetags_3d_camera_distance" id="freetags_3d_camera_distance" value="{$prefs.freetags_3d_camera_distance|default:"200"}" size="3" /></div>
</div>
<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="freetags_3d_fov">{tr}Field of view{/tr}: </label><input type="text" name="freetags_3d_fov" id="freetags_3d_fov" value="{$prefs.freetags_3d_fov|default:"250"}" size="3" /></div>
</div>
<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="freetags_3d_feed_animation_interval">{tr}Feed animation interval (milisecs){/tr}: <input type="text" id="freetags_3d_feed_animation_interval" name="freetags_3d_feed_animation_interval" value="{$prefs.freetags_3d_feed_animation_interval|escape}" size="4" /></label></div>
</div>
</fieldset>

<fieldset><legend>{tr}Physics engine{/tr}</legend>
<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="freetags_3d_friction_constant">{tr}Friction constant{/tr}:</label> <input type="text" name="freetags_3d_friction_constant" id="freetags_3d_friction_constant" value="{$prefs.freetags_3d_friction_constant|default:"0.4f"}" size="7" /></div>
</div>
<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="freetags_3d_elastic_constant">{tr}Elastic constant{/tr}: </label><input type="text" name="freetags_3d_elastic_constant" id="freetags_3d_elastic_constant" value="{$prefs.freetags_3d_elastic_constant|default:"0.5f"}" size="7" /></div>
</div>
<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="freetags_3d_eletrostatic_constant">{tr}Eletrostatic constant{/tr}: </label><input type="text" name="freetags_3d_eletrostatic_constant" id="freetags_3d_eletrostatic_constant" value="{$prefs.freetags_3d_eletrostatic_constant|default:"1000f"}" size="7" /></div>
</div>
<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="freetags_3d_node_mass">{tr}Node mass{/tr}: </label><input type="text" name="freetags_3d_node_mass" id="freetags_3d_node_mass" value="{$prefs.freetags_3d_node_mass|default:"5"}" size="7" /></div>
</div>
<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="freetags_3d_node_charge">{tr}Node charge{/tr}: </label><input type="text" name="freetags_3d_node_charge" id="freetags_3d_node_charge" value="{$prefs.freetags_3d_node_charge|default:"1"}" size="7" /></div>
</div>
</fieldset>
{*      <tr>
        <td class="form">{tr}Load page on navigation{/tr}: </td>
	<td><input type="checkbox" name="freetags_3d_autoload" value="true" {if $prefs.freetags_3d_missing_page_color eq 'true'}checked="checked"{/if} /></td>
      </tr> *}
	  
{*        <td class="form">{tr}Missing page node color{/tr}: </td>
	<td><input type="text" name="freetags_3d_missing_page_color" value="{$prefs.freetags_3d_missing_page_color|escape}" size="7" /></td>
      </tr> *}

</div>

	  {if $prefs.feature_tabs neq 'y'}</div>{/if}
    </fieldset>

<div style="padding:1em;" align="center"><input type="submit" value="{tr}Change preferences{/tr}" /></div>
</td></tr></table>
</div>
</form>
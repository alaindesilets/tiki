{remarksbox type="tip" title="{tr}Tip{/tr}"}
	{tr}Text area (that apply throughout many features){/tr}
{/remarksbox}

<form action="tiki-admin.php?page=textarea" method="post">
<div class="heading input_submit_container" style="text-align: right">
	<input type="submit" name="textareasetup" value="{tr}Change preferences{/tr}" />
</div>
	{tabset name="admin_textarea"}
		{tab name="{tr}General Settings{/tr}"}
<fieldset><legend>{tr}Features{/tr}{if $prefs.feature_help eq 'y'} {help url="Text+Area"}{/if}</legend>
<div class="adminoptionbox">
	<div class="adminoption"><input type="checkbox" id="feature_antibot" name="feature_antibot" {if $prefs.feature_antibot eq 'y'}checked="checked" {/if}/></div>
	<div class="adminoptionlabel"><label for="feature_antibot">{tr}Anonymous editors must enter anti-bot code (CAPTCHA){/tr}. </label>{if $prefs.feature_help eq 'y'} {help url="Spam+Protection"}{/if}</div>
</div>

<div class="adminoptionbox">
	<div class="adminoption"><input type="checkbox" id="feature_wiki_protect_email" name="feature_wiki_protect_email" {if $prefs.feature_wiki_protect_email eq 'y'}checked="checked"{/if}/></div>
	<div class="adminoptionlabel"><label for="feature_wiki_protect_email">{tr}Protect email against spam{/tr}.</label></div>
</div>

<div class="adminoptionbox">
	<div class="adminoption"><input type="checkbox" id="feature_smileys" name="feature_smileys" {if $prefs.feature_smileys eq 'y'}checked="checked" {/if}/> </div>
	<div class="adminoptionlabel"><label for="feature_smileys">{tr}Smileys{/tr} </label>{if $prefs.feature_help eq 'y'} {help url="Smiley"}{/if}</div>
</div>

<div class="adminoptionbox">
	<div class="adminoption"><input type="checkbox" id="feature_wiki_ext_icon" name="feature_wiki_ext_icon" {if $prefs.feature_wiki_ext_icon eq 'y'}checked="checked"{/if}/></div>
	<div class="adminoptionlabel"><label for="feature_wiki_ext_icon">{tr}External link icon{/tr}</label>
		<br /><em>{tr}External links will be identified with{/tr}: </em><img border="0" class="externallink" src="img/icons/external_link.gif" alt=" (external link)" />.
	</div>
</div>

<div class="adminoptionbox">
	<div class="adminoption"><input type="checkbox" name="popupLinks" id="general-ext_links" {if $prefs.popupLinks eq 'y'}checked="checked" {/if}/></div>
	<div class="adminoptionlabel"><label for="general-ext_links">{tr}Open external links in new window{/tr}.</label>
	<br /><em>{tr}External links will be identified with{/tr}: </em><img border="0" class="externallink" src="img/icons/external_link.gif" alt=" (external link)" />.
	</div>
</div>

<div class="adminoptionbox">
	<div class="adminoption"><input type="checkbox" name="feature_filegals_manager" id="feature_filegals_manager" {if $prefs.feature_filegals_manager eq 'y'}checked="checked" {/if}/> </div>
	<div class="adminoptionlabel"><label for="feature_filegals_manager">{tr}Use File Galleries to store pictures {/tr}.</label></div>
</div>

<div class="adminoptionbox">
	<div class="adminoption"><input type="checkbox" id="feature_dynamic_content" name="feature_dynamic_content" {if $prefs.feature_dynamic_content eq 'y'}checked="checked" {/if}/> </div>
	<div class="adminoptionlabel"><label for="feature_dynamic_content">{tr}Dynamic Content System{/tr} </label>{if $prefs.feature_help eq 'y'} {help url="Dynamic+Content"}{/if}</div>
</div>

<div class="adminoptionbox">
	<div class="adminoption"><input type="checkbox" name="feature_comments_post_as_anonymous" id="feature_comments_post_as_anonymous"{if $prefs.feature_comments_post_as_anonymous eq 'y'} checked="checked" {/if}/> </div>
	<div class="adminoptionlabel"><label for="feature_comments_post_as_anonymous">{tr}Allow to post comments as Anonymous{/tr} </label>{if $prefs.feature_help eq 'y'} {help url="Post+Comments+as+Anonymous"}{/if}</div>
</div>
</fieldset>

<fieldset><legend>{tr}Wiki syntax{/tr}{if $prefs.feature_help eq 'y'} {help url="Wiki+Syntax"}{/if}</legend>

<div class="adminoptionbox">
	<div class="adminoption"><input type="checkbox" id="feature_wiki_paragraph_formatting" name="feature_wiki_paragraph_formatting" {if $prefs.feature_wiki_paragraph_formatting eq 'y'}checked="checked" {/if}onclick="flip('usewikiparaformat');" /></div>
	<div class="adminoptionlabel"><label for="feature_wiki_paragraph_formatting">{tr}Wiki paragraph formatting{/tr}</label></div>
<div class="adminoptionboxchild" id="usewikiparaformat" style="display:{if $prefs.feature_wiki_paragraph_formatting eq 'y'}block{else}none{/if};">
	<div class="adminoption"><input type="checkbox" id="feature_wiki_paragraph_formatting_add_br" name="feature_wiki_paragraph_formatting_add_br" {if $prefs.feature_wiki_paragraph_formatting_add_br eq 'y'}checked="checked"{/if}/></div>
	<div class="adminoptionlabel"><label for="feature_wiki_paragraph_formatting_add_br">{tr}...but still create line breaks within paragraphs{/tr}.</label></div>
</div>
</div>
<div class="adminoptionbox">
	<div class="adminoption"><input type="checkbox" id="section_comments_parse" name="section_comments_parse" {if $prefs.section_comments_parse eq 'y'}checked="checked"{/if}/></div>
	<div class="adminoptionlabel">
		<label for="section_comments_parse">{tr}Parse wiki syntax in comments in all sections apart from Forums{/tr}</label>{if $prefs.feature_help eq 'y'} {help url="Wiki+Syntax"}{/if}
		{remarksbox type='tip' title='Tip'}Use 'Accept wiki syntax' for forums, currently <em>{if $prefs.feature_forum_parse eq 'y'}on{else}off{/if}</em> {icon _id="arrow_right" href="tiki-admin.php?page=forums"}{/remarksbox}
	</div>
</div>

<div class="adminoptionbox">
	<div class="adminoption"><input type="checkbox" id="feature_wiki_monosp" name="feature_wiki_monosp" {if $prefs.feature_wiki_monosp eq 'y'}checked="checked"{/if}/></div>
	<div class="adminoptionlabel"><label for="feature_wiki_monosp">{tr}Automonospaced text{/tr}</label></div>
</div>

<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="feature_wiki_tables">{tr}Tables syntax{/tr}:</label>
	<select name="feature_wiki_tables" id="feature_wiki_tables">
    <option value="old" {if $prefs.feature_wiki_tables eq 'old'}selected="selected"{/if}>{tr}|| for rows{/tr}</option>
    <option value="new" {if $prefs.feature_wiki_tables eq 'new'}selected="selected"{/if}>{tr}&lt;return&gt; for rows{/tr}</option>
    </select>
	</div>
</div>

</fieldset>

<fieldset><legend>{tr}Miscellaneous{/tr}</legend>
<div class="adminoptionbox">
	<div class="adminoption"><input type="checkbox" id='feature_autolinks' name="feature_autolinks" {if $prefs.feature_autolinks eq 'y'}checked="checked"{/if}/> </div>
	<div class="adminoptionlabel"><label for="feature_autolinks">{tr}AutoLinks{/tr} </label>{if $prefs.feature_help eq 'y'} {help url="AutoLinks"}{/if}</div>
</div>

<div class="adminoptionbox">
	<div class="adminoption"><input onclick="flip('hotwords_nw');" type="checkbox" name="feature_hotwords" id="feature_hotwords" {if $prefs.feature_hotwords eq 'y'}checked="checked" {/if}/> </div>
	<div class="adminoptionlabel"><label for="feature_hotwords">{tr}Hotwords{/tr} </label>{if $prefs.feature_help eq 'y'} {help url="Hotwords"}{/if}</div>
	
	<div class="adminoptionboxchild" id="hotwords_nw" style="display:{if $prefs.feature_hotwords eq 'y'}block{else}none{/if};">
		<div class="adminoption"><input type="checkbox" name="feature_hotwords_nw" id="feature_hotwords_nw" {if $prefs.feature_hotwords_nw eq 'y'}checked="checked"{/if}/> </div>
		<div class="adminoptionlabel"><label for="feature_hotwords_nw">{tr}Open Hotwords in new window{/tr}.</label></div>	
	</div>
</div>

<div class="adminoptionbox">
	<div class="adminoption"><input type="checkbox" name="feature_use_quoteplugin" id="feature_use_quoteplugin"{if $prefs.feature_use_quoteplugin eq 'y'}checked="checked" {/if}/> </div>
	<div class="adminoptionlabel"><label for="feature_use_quoteplugin"> {tr}Use Quote plugin rather than &ldquo;&gt;&rdquo; for quoting{/tr}.</label>{if $prefs.feature_help eq 'y'} {help url="PluginQuote"}{/if}
{if $prefs.wikiplugin_quote ne 'y'}<br />{icon _id=information} {tr}Plugin disabled{/tr}. {/if}
	</div>
</div>
</fieldset>

<fieldset><legend>{tr}Default size{/tr}</legend>

<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="default_rows_textarea_wiki">{tr}Wiki{/tr}:</label> <input type="text" name="default_rows_textarea_wiki" id="default_rows_textarea_wiki" value="{$prefs.default_rows_textarea_wiki}" size="4" /> {tr}rows{/tr}</div>
</div>

<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="default_rows_textarea_comment">{tr}Comments {/tr}:</label><input type="text" name="default_rows_textarea_comment" id="default_rows_textarea_comment" value="{$prefs.default_rows_textarea_comment}" size="4" />{tr}rows{/tr}</div>
</div>

<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="default_rows_textarea_forum">{tr}Forum{/tr}:</label><input type="text" name="default_rows_textarea_forum" id="default_rows_textarea_forum" value="{$prefs.default_rows_textarea_forum}" size="4" />{tr}rows{/tr}</div>
</div>

<div class="adminoptionbox">
	<div class="adminoptionlabel"><label for="default_rows_textarea_forumthread">{tr}Forum reply{/tr}: </label><input type="text" name="default_rows_textarea_forumthread" id="default_rows_textarea_forumthread" value="{$prefs.default_rows_textarea_forumthread}" size="4" />{tr}rows{/tr}</div>
</div>
</fieldset>
		{/tab}

		{tab name="{tr}Plugins{/tr}"}

	<!-- *** plugins *** -->
		{remarksbox type="note" title="{tr}About plugins{/tr}"}{tr}Tiki plugins add functionality to wiki pages, articles and blogs etc. You can enable and disable them below.{/tr}
		{tr}You can approve plugin use at <a href="tiki-plugins.php">tiki-plugins.php</a>.{/tr}		
		{tr}The edit plugin icon is an easy way for users to edit the parameters of each plugin in wiki pages. It can be disabled for individual plugins below.{/tr}
		{/remarksbox}

		<fieldset class="admin">
		<legend>{tr}Edit plugin icons{/tr}</legend>
		<div class="adminoptionbox">
			<div class="adminoption"><input type="checkbox" id="wiki_edit_plugin" name="wiki_edit_plugin" {if $prefs.wiki_edit_plugin eq 'y'}checked="checked"{/if}/></div> 
				<div class="adminoptionlabel"><label for="wiki_edit_plugin">{tr}Enable edit plugin icons{/tr} {tr}(experimental - not comprehensively tested and requires javascript){/tr}</label></div>
		</div>
		</fieldset>
		<fieldset class="admin">
                <legend>{tr}Plugins{/tr}</legend>
				<fieldset class="admin donthide">
					{listfilter selectors='#content2 .admin fieldset' exclude=".donthide"}
				</fieldset>
		{foreach from=$plugins key=plugin item=info}
			<fieldset class="admin">
                	<legend>{$info.name|escape}</legend>
			<div class="adminoptionbox">	 
			<strong>{$plugin|escape}</strong>: {$info.description|escape}{assign var=pref value=wikiplugin_$plugin} {if $prefs.feature_help eq 'y'} {help url="Plugin$plugin"}{/if}
			</div>
			{if in_array( $pref, $info.prefs)}
				<div class="adminoptionbox"> 
				{assign var=pref value=wikiplugin_$plugin}
				{assign var=pref_inline value=wikiplugininline_$plugin}	
					<div class="adminoption"><input type="checkbox" id="wikiplugin_{$plugin|escape}" name="wikiplugin_{$plugin|escape}" {if $prefs[$pref] eq 'y'}checked="checked" {/if}/> 
					</div> 
					<div class="adminoptionlabel"><label for="wikiplugin_{$plugin|escape}">{tr}Enable{/tr}</label>
					</div> 
				</div>	
				<div class="adminoptionbox">
				        {if !isset($plugins.$plugin.inline)}<div class="adminoption"><input type="checkbox" id="wikiplugininline_{$plugin|escape}" name="wikiplugininline_{$plugin|escape}" {if $prefs[$pref_inline] eq 'y'}checked="checked" {/if}/>
                         </div>{/if} 
					<div class="adminoptionlabel">{if !isset($plugins.$plugin.inline)}<label for="wikiplugininline_{$plugin|escape}">{/if}{if isset($plugins.$plugin.inline)}The edit plugin icon is not supported for this plugin{else}{tr}Disable edit plugin icon (make plugin inline){/tr}{/if}{if !isset($plugins.$plugin.inline)}</label>{/if}
					</div> 
				</div>
			{/if} 
			</fieldset>
		{/foreach}
		</fieldset>
		{/tab}

		{tab name="{tr}Plugin Aliases{/tr}"}

	<!-- *** plugin aliases *** -->
		{remarksbox type="note" title="{tr}About plugin aliases{/tr}"}{tr}Tiki plugin aliases allow you to define your own custom configurations of existing plugins.<br />Find out more here: {help url="Plugin+Alias"}{/tr}{/remarksbox}
		{if $prefs.feature_jquery neq 'y'}
			{remarksbox type="tip" title="{tr}Tip{/tr}"}{tr}This page is designed to work with JQuery {icon _id="arrow_right" href="tiki-admin.php?page=features"}{/tr}{/remarksbox}
		{/if}

		{* JQuery JS to set up page *}{jq}
$jq('#content3 legend').click(function(event, hidefirst) {
	var im = $jq(this).contents("img");
	if (im.length > 0) { im = im[0]; }
	if (!typeof this.showing == 'undefined' || !this.showing) {
		if ($jq(im).length > 0) { $jq(im).attr("src", $jq(im).attr("src").replace("/omodule.", "/module.")); }
		this.showing = true;
		if (hidefirst) {
			$jq(this).nextAll(":not(.hidefirst)").show('fast')
		} else {
			$jq(this).nextAll().show('fast')
		}
	} else {
		if ($jq(im).length > 0) { $jq(im).attr("src", $jq(im).attr("src").replace("/module.", "/omodule.")); }
		this.showing = false;
		$jq(this).nextAll(":not(.stayopen)").hide('fast')
	}
	return false;
}).css("cursor", "pointer").nextAll(":not(.stayopen)").hide();
{{if $plugin_admin}{* show gen info and simple params if plugin_admin selected *}}
$jq('#pluginalias_general legend').trigger('click');
$jq('#pluginalias_simple_args legend').trigger('click'{{if isset($plugin_admin.params)}, true{/if}});
$jq('#pluginalias_body legend').trigger('click'{{if isset($plugin_admin.body.params)}, true{/if}});
$jq('#pluginalias_add').click(function() {
	window.location.href = window.location.href.replace(/plugin_alias=[^&]*/, 'plugin_alias_new=true');
});
{{elseif $plugins_alias}{* or if no plugin_admin and a nice list *}}
$jq('#pluginalias_general').hide();
$jq('#pluginalias_simple_args').hide();
$jq('#pluginalias_doc').hide();
$jq('#pluginalias_body').hide();
$jq('#pluginalias_composed_args').hide();
$jq('#pluginalias_add').click(function() {
	$jq('#pluginalias_general legend')[0].showing = false;
	$jq('#pluginalias_general legend').trigger('click');
	$jq('#pluginalias_simple_args legend')[0].showing = false;
	$jq('#pluginalias_simple_args legend').trigger('click');
	$jq('#pluginalias_body legend')[0].showing = false;
	$jq('#pluginalias_body legend').trigger('click');

	$jq('#pluginalias_general').show();
	$jq('#pluginalias_simple_args').show();
	$jq('#pluginalias_doc').show();
	$jq('#pluginalias_body').show();
	$jq('#pluginalias_composed_args').show();

	$jq('#pluginalias_available legend')[0].showing = true;
	$jq('#pluginalias_available legend').trigger('click');

	return false;
});
{{else}{* or new view if no plugin_admin and no list *}}
	$jq('#pluginalias_general legend').trigger('click');
	$jq('#pluginalias_simple_args legend').trigger('click');
	$jq('#pluginalias_body legend').trigger('click');
{{/if}}
if (window.location.href.indexOf('plugin_alias_new=true') > -1) {
	$jq('#pluginalias_add').trigger('click');
}
	{/jq}
		{* from tiki-admin-include-plugins.tpl *}
		{if $plugins_alias|@count}
			<fieldset id="pluginalias_available">
				<legend><strong>{tr}Available Alias{/tr}</strong>{icon _id="omodule"} {icon _id="add" id="pluginalias_add"}</legend>
				<div class="input_submit_container">
					{foreach from=$plugins_alias item=name}
						{assign var=full value='wikiplugin_'|cat:$name}
						<input type="checkbox" name="enabled[]" value="{$name|escape}" {if $prefs[$full] eq 'y'}checked="checked"{/if}/>
						<a href="tiki-admin.php?page=textarea&amp;plugin_alias={$name|escape}">{$name|escape}</a>
					{/foreach}
					<div align="center">
						<input type="submit" name="enable" value="{tr}Enable Plugins{/tr}"/>
					</div>
				</div>
			</fieldset>
			{jq}$jq('#pluginalias_available legend').trigger('click');{/jq}
		{/if}
		<fieldset id="pluginalias_general">
			<legend>{tr}General Information{/tr}{icon _id="omodule"}</legend>
		
			<div class="adminoptionbox">
				<div class="adminoptionlabel">
					<label for="plugin_alias">{tr}Plugin Name{/tr}:</label>
					{if $plugin_admin}
						<input type="hidden" name="plugin_alias" id="plugin_alias" value="{$plugin_admin.plugin_name|escape}"/>
						<strong>{$plugin_admin.plugin_name|escape}</strong>
					{else}
						<input type="text" name="plugin_alias" id="plugin_alias" />
					{/if}
				</div>
			</div>
			<div class="adminoptionbox">
				<div class="adminoptionlabel">
					<label for="implementation">{tr}Base Plugin{/tr}:</label>
					<select name="implementation" id="implementation">
						{foreach from=$plugins_real item=base}
							<option value="{$base|escape}" {if isset($plugin_admin.implementation) and $plugin_admin.implementation eq $base}selected="selected"{/if}>{$base|escape}</option>
						{/foreach}
					</select>
				</div>
			</div>
			<div class="adminoptionbox"><div class="adminoptionlabel">
					<label for="plugin_name">{tr}Name{/tr}:</label> <input type="text" name="name" id="plugin_name" value="{$plugin_admin.description.name|escape}"/>
			</div></div>
			<div class="adminoptionbox"><div class="adminoptionlabel">
					<label for="plugin_description">{tr}Description{/tr}:</label> <input type="text" name="description" id="plugin_description" value="{$plugin_admin.description.description|escape}" class="width_40em"/>
			</div></div>
			<div class="adminoptionbox"><div class="adminoptionlabel">
					<label for="plugin_body">{tr}Body Label{/tr}:</label> <input type="text" name="body" id="plugin_body" value="{$plugin_admin.description.body|escape}"/>
			</div></div>
			<div class="adminoptionbox"><div class="adminoptionlabel">
					<label for="plugin_deps">{tr}Dependencies{/tr}:</label> <input type="text" name="prefs" id="plugin_deps" value="{if !empty($plugin_admin.description.prefs)}{','|implode:$plugin_admin.description.prefs}{/if}"/>
			</div></div>
			<div class="adminoptionbox"><div class="adminoptionlabel">
					<label for="filter">{tr}Filter{/tr}:</label> <input type="text" id="filter" name="filter" value="{$plugin_admin.description.filter|default:'xss'|escape}"/>
			</div></div>
			<div class="adminoptionbox"><div class="adminoptionlabel">
					<label for="validate">{tr}Validation{/tr}:</label> 
					<select name="validate" id="validate">
						{foreach from=','|explode:'none,all,body,arguments' item=val}
							<option value="{$val|escape}" {if $plugin_admin.description.validate eq $val}selected="selected"{/if}>{$val|escape}</option>
						{/foreach}
					</select>
			</div></div>
			<div class="adminoptionbox"><div class="adminoptionlabel">
					<label for="inline">{tr}Inline (No Plugin Edit UI){/tr}:</label> <input type="checkbox" id="inline" name="inline" value="1" {if $plugin_admin.description.inline}checked="checked"{/if}/>
			</div></div>
		</fieldset>
		<fieldset id="pluginalias_simple_args">
			<legend>{tr}Simple Plugin Arguments{/tr}{icon _id="omodule"} {icon _id="add" id="pluginalias_simple_add"}</legend>
			{jq}
$jq('#pluginalias_simple_add').click(function() { $jq('#pluginalias_simple_new').toggle("fast"); return false; });
{{if $plugin_admin.params}}
$jq('#pluginalias_doc legend').trigger('click'{{if isset($plugin_admin.description.params)}, true{/if}});
$jq('#pluginalias_simple_new').hide();
{{/if}}
			{/jq}
			{foreach from=$plugin_admin.params key=token item=value}
				{if ! $value|is_array}
					<div class="admingroup adminoptionbox">
						<div class="adminoptionlabel">
							<label for="sparams_{$token|escape}_token">{tr}Argument{/tr}:</label> <input type="text" name="sparams[{$token|escape}][token]" id="sparams_{$token|escape}_token" value="{$token|escape}"/>
							<label for="sparams_{$token|escape}_default" style="float:none;display:inline">{tr}Default{/tr}:</label> <input type="text" name="sparams[{$token|escape}][default]" id="sparams_{$token|escape}_default" value="{$value|escape}"/>
						</div>
					</div>
				{/if}
			{/foreach}
			<div class="admingroup adminoptionbox hidefirst" id="pluginalias_simple_new">
				<div class="adminoptionlabel">
					<label for="sparams__NEW__token">{tr}New Argument{/tr}:</label>
					<input type="text" name="sparams[__NEW__][token]" id="sparams__NEW__token" value=""/>
					<label for="sparams__NEW__default" style="float:none;display:inline">{tr}Default{/tr}:</label>
					<input type="text" name="sparams[__NEW__][default]" id="sparams__NEW__default" value=""/>
				</div>
			</div>
		</fieldset>
		<fieldset id="pluginalias_doc">
			<legend>{tr}Plugin Parameter Documentation{/tr}{icon _id="omodule"} {icon _id="add" id="pluginalias_doc_add"}</legend>
			{jq}$jq('#pluginalias_doc_add').click(function() { $jq('#pluginalias_doc_new').toggle("fast"); return false; });{/jq}
			
			{foreach from=$plugin_admin.description.params key=token item=detail}
				<div class="clearfix admingroup adminoptionbox{if $token eq '__NEW__'} hidefirst" id="pluginalias_doc_new{/if}">
					<div class="adminoptionlabel q1">
						<input type="text" name="input[{$token|escape}][token]" value="{if $token neq '__NEW__'}{$token|escape}{/if}"/>
					</div>
					<div class="adminnestedbox q234">
						<div class="adminoptionlabel">
							<label for="input[{$token|escape}][name]">{tr}Name{/tr}:</label> <input type="text" name="input[{$token|escape}][name]" value="{$detail.name|escape}"/>
						</div>
						<div class="adminoptionlabel">
							<label for="input[{$token|escape}][description]">{tr}Description{/tr}:</label> <input type="text" name="input[{$token|escape}][description]" value="{$detail.description|escape}" class="width_30em"/>
						</div>
						<div class="adminoptionlabel">
							<label for="input[{$token|escape}][required]">{tr}Required{/tr}:</label> <input type="checkbox" name="input[{$token|escape}][required]" value="y"{if $detail.required} checked="checked"{/if}/>
						</div>
						<div class="adminoptionlabel">
							<label for="input[{$token|escape}][safe]">{tr}Safe{/tr}:</label> <input type="checkbox" name="input[{$token|escape}][safe]" value="y"{if $detail.safe} checked="checked"{/if}/>
						</div>
						<div class="adminoptionlabel">
							<label for="input[{$token|escape}][filter]">{tr}Filter{/tr}:</label> <input type="text" name="input[{$token|escape}][filter]" value="{$detail.filter|default:xss|escape}"/>
						</div>
					</div>
				</div>
			{/foreach}
		</fieldset>
		<fieldset id="pluginalias_body">
			<legend>{tr}Plugin Body{/tr}{icon _id="omodule"}</legend>

			<div class="adminoptionbox">
				<div class="adminoptionlabel">
					<label for="ignorebody">{tr}Ignore User Input{/tr}:</label> <input type="checkbox" name="ignorebody" id="ignorebody" value="y" {if $plugin_admin.body.input eq 'ignore'}checked="checked"{/if}/>
				</div>
			</div>
			<div class="adminoptionbox">
				<div class="adminoptionlabel">
					<label for="defaultbody">{tr}Default Content{/tr}:</label>
					<textarea cols="60" rows="12" id="defaultbody" name="defaultbody">{$plugin_admin.body.default|escape}</textarea>
				</div>
				<div class="q1">&nbsp;</div>
				<div class="q234">
					<fieldset class="stayopen">
						<legend>{tr}Parameters{/tr}{icon _id="omodule"}{icon _id="add" id="pluginalias_body_add"}</legend>
						{jq}$jq('#pluginalias_body_add').click(function() { $jq('#pluginalias_body_new').toggle("fast"); return false; });{/jq}
						
						{foreach from=$plugin_admin.body.params key=token item=detail}
							<div class="clearfix admingroup adminoptionbox{if $token eq '__NEW__'} hidefirst" id="pluginalias_body_new{/if}">
								<div class="q1">
									<input type="text" name="bodyparam[{$token|escape}][token]" value="{if $token neq '__NEW__'}{$token|escape}{/if}"/>
								</div>
								<div class="q234">
									<div class="adminoptionlabel">
										<label for="bodyparam[{$token|escape}][encoding]">{tr}Encoding{/tr}:</label> 
										<select name="bodyparam[{$token|escape}][encoding]">
											{foreach from=','|explode:'none,html,url' item=val}
												<option value="{$val|escape}" {if $detail.encoding eq $val}selected="selected"{/if}>{$val|escape}</option>
											{/foreach}
										</select>
									</div>
									<div class="adminoptionlabel">
										<label for="bodyparam[{$token|escape}][input]">{tr}Argument Source (if different){/tr}:</label> <input type="text" name="bodyparam[{$token|escape}][input]" value="{$detail.input|escape}"/>
									</div>
									<div class="adminoptionlabel">
										<label for="bodyparam[{$token|escape}][default]">{tr}Default Value{/tr}:</label> <input type="text" name="bodyparam[{$token|escape}][default]" value="{$detail.default|escape}"/>
									</div>
								</div>
							</div>
						{/foreach}
					</fieldset>
				</div>
			</div>
		</fieldset>
		<fieldset id="pluginalias_composed_args">
			<legend>{tr}Composed Plugin Arguments{/tr}{icon _id="omodule"} {icon _id="add" id="pluginalias_composed_add"}</legend>
			{jq}$jq('#pluginalias_composed_add').click(function() { $jq('#pluginalias_composed_new').toggle("fast"); return false; });{/jq}

			{foreach from=$plugin_admin.params key=token item=detail}
				{if $detail|is_array}
					{if !isset($composed_args)}{assign var=composed_args value=true}{/if}
					<div class="clearfix admingroup adminoptionbox{if $token eq '__NEW__'} hidefirst" id="pluginalias_composed_new{/if}">
						<div class="adminoptionlabel q1">
							<input type="text" name="cparams[{$token|escape}][token]" value="{if $token neq '__NEW__'}{$token|escape}{/if}"/>
						</div>
						<div class="q234">
							<div class="adminoptionlabel">
								<label for="cparams[{$token|escape}][pattern]">{tr}Pattern{/tr}:</label> <input type="text" name="cparams[{$token|escape}][pattern]" value="{$detail.pattern|escape}"/>
							</div>
							<fieldset class="stayopen">
								<legend>{tr}Parameters{/tr}{icon _id="omodule"} {icon _id="add" id="pluginalias_composed_addparam"}</legend>
								{jq}$jq('#pluginalias_composed_addparam').click(function() { $jq('#pluginalias_composed_newparam').toggle("fast"); return false; });{/jq}
								{foreach from=$detail.params key=t item=d}
									<div class="clearfix admingroup adminoptionbox{if $t eq '__NEW__'} hidefirst" id="pluginalias_composed_newparam{/if}">
										<div class="q1">
											<input type="text" name="cparams[{$token|escape}][params][{$t|escape}][token]" value="{if $t neq '__NEW__'}{$t|escape}{/if}"/>
										</div>
										<div class="q234">
											<div class="adminoptionlabel">
												<label for="cparams[{$token|escape}][pattern]">{tr}Encoding{/tr}:</label>
												<select name="cparams[{$token|escape}][params][{$t|escape}][encoding]">
													{foreach from=','|explode:'none,html,url' item=val}
														<option value="{$val|escape}" {if $d.encoding eq $val}selected="selected"{/if}>{$val|escape}</option>
													{/foreach}
												</select>
											</div>
											<div class="adminoptionlabel">
												<label for="cparams[{$token|escape}][params][{$t|escape}][input]">{tr}Argument Source (if different){/tr}:</label> <input type="text" name="cparams[{$token|escape}][params][{$t|escape}][input]" value="{$d.input|escape}"/>
											</div>
											<div class="adminoptionlabel">
												<label for="cparams[{$token|escape}][params][{$t|escape}][input]">{tr}Default Value{/tr}:</label> <input type="text" name="cparams[{$token|escape}][params][{$t|escape}][default]" value="{$d.default|escape}"/>
											</div>
										</div>
									</div>
								{/foreach}
							</fieldset>
						</div>
					</div>
				{/if}
			{/foreach}
			{if $plugin_admin}{jq}$jq('#pluginalias_composed_args legend').trigger('click'{{if isset($composed_args)}, true{/if}});{/jq}{/if}
		</fieldset>
		{/tab}
	{/tabset}
<div class="heading input_submit_container" style="text-align: right">
	<input type="submit" name="textareasetup" value="{tr}Change preferences{/tr}" />
</div>
</form>



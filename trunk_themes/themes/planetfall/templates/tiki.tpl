{* $Id: tiki.tpl 12618 2008-04-21 05:43:35Z chibaguy $ *}<!DOCTYPE html 
	PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{if !empty($pageLang)}{$pageLang}{else}{$prefs.language}{/if}" lang="{if !empty($pageLang)}{$pageLang}{else}{$prefs.language}{/if}">
	<head>
{include file='header.tpl'}
	</head>
	<body{if isset($section) and $section eq 'wiki page' and $prefs.user_dbl eq 'y' and $dblclickedit eq 'y' and $tiki_p_edit eq 'y'} ondblclick="location.href='tiki-editpage.php?page={$page|escape:"url"}';"{/if} onload="{if $prefs.feature_tabs eq 'y'}tikitabs({if $cookietab neq ''}{$cookietab}{else}1{/if},50);{/if}{if $msgError} javascript:location.hash='msgError'{/if}"{if $section or $smarty.session.fullscreen eq 'y'} class="{if $section}tiki_{$section|replace:' ':'_'}{/if}{if $smarty.session.fullscreen eq 'y'} fullscreen{/if}"{/if}>
		<ul class="jumplinks" style="position:absolute;top:-9000px;left:-9000px;z-index:9;">
			<li><a href="#tiki-center">{tr}Jump to Content{/tr}</a></li>
		</ul>

{if $prefs.feature_community_mouseover eq 'y'}		{popup_init src="lib/overlib.js"}{/if}

{if $prefs.feature_fullscreen eq 'y' and $filegals_manager eq '' and $print_page ne 'y'}
	{if $smarty.session.fullscreen eq 'n'}
		{self_link fullscreen="y" _class="fullscreenbutton" _ajax='n' _icon=application_get _title="{tr}Fullscreen{/tr}"}{/self_link}
	{else}
		{self_link fullscreen="n" _class="fullscreenbutton" _ajax='n' _icon=application_put _title="{tr}Cancel Fullscreen{/tr}"}{/self_link}
	{/if}
{/if}

{* TikiTest ToolBar *}
{if $prefs.feature_tikitests eq 'y' and $tikitest_state neq 0}
	{include file='tiki-tests_topbar.tpl'}
{/if}
{if $prefs.feature_ajax eq 'y'}
	{include file='tiki-ajax_header.tpl'}
{/if}
{if $prefs.feature_fullscreen != 'y' or $smarty.session.fullscreen != 'y'}
		<table width="100%" cellpadding="0" cellspacing="0" id="main">
			<tr id="cols">
				<td rowspan="3" id="leftmargin">&nbsp;</td>
				<td id="leftborder" rowspan="3"><img src="styles/planetfall/9DA6B3-1x1.png" height="100%" width="1px" alt="spacer" /></td>{* For content cols - leftmargin graphic border. *}
				<td colspan="5{* change to 5 if the 2 border tds are used *}" id="main-header">
					<div class="clearfix" id="header">
						{* Site identity header section *}
							<div class="clearfix" id="siteheader">
								{include file='tiki-site_header.tpl'}
							</div>
						</div>
				</td>
				<td id="rightborder" rowspan="5"><img src="styles/planetfall/9DA6B3-1x1.png" height="100%" width="1px" alt="spacer" /></td>{* For content cols - rightmargin graphic border. *}
				<td rowspan="3" id="rightmargin">&nbsp;</td>
			</tr>
			<tr id="midrow">
				<td id="centercolumn" valign="top">
			{/if}
			<hr class="hidden" /> {* for semantic separation of center and side columns *}
			{if $smarty.session.fullscreen neq 'y'}
      			{if $prefs.feature_left_column eq 'user' or $prefs.feature_right_column eq 'user'}
        			<div id="showhide_columns">
      					{if $prefs.feature_left_column eq 'user' && $left_modules|@count > 0 && $show_columns.left_modules ne 'n'}
							<div style="text-align:left;float:left;"><a class="flip" href="javascript:flip('leftcolumn','table-cell');">{icon _name=oleftcol _id="oleftcol" class="colflip" alt="[{tr}Show/Hide Left Menus{/tr}]"}</a></div>
						{/if}
						{if $prefs.feature_right_column eq 'user'&& $right_modules|@count > 0 && $show_columns.right_modules ne 'n'}
        					<div style="text-align:right;float:right;"><a class="flip" href="javascript:flip('rightcolumn','table-cell');">{icon _name=orightcol _id="orightcol" class="colflip" alt="[{tr}Show/Hide Right Menus{/tr}]"}</a></div>
						{/if}
        				<br clear="all" />
					</div>
			{/if}
				{/if}
				{if $prefs.feature_tell_a_friend eq 'y' && $tiki_p_tell_a_friend eq 'y' and (!isset($edit_page) or $edit_page ne 'y')}
					<div class="tellafriend"><a href="tiki-tell_a_friend.php?url={$smarty.server.REQUEST_URI|escape:'url'}">{tr}Email this page{/tr}</a></div>
				{/if}
					<div id="tiki-center">
						{if $prefs.feature_custom_center_column_header}{* Content comes from Look and Feel admin  *}
							{eval var=$prefs.feature_custom_center_column_header}
						{/if}
						{$mid_data}
						{show_help}
					</div>
					<hr class="hidden" /> {* for semantic separation of center and side columns *}
			{if $prefs.feature_fullscreen != 'y' or $smarty.session.fullscreen != 'y'}
				</td>
			{if $prefs.feature_left_column ne 'n' && $left_modules|@count > 0 && $show_columns.left_modules ne 'n'}
				<td id="leftcolumn" valign="top"{if $prefs.feature_left_column eq 'user'} style="display:{if isset($cookie.show_leftcolumn) and $cookie.show_leftcolumn ne 'y'}none{else}table-cell;_display:block{/if};"{/if}>
					<h2 class="hidden">Sidebar</h2>
					<div class="colwrapper">
						{section name=homeix loop=$left_modules}
							{$left_modules[homeix].data}
						{/section}
					</div>
				</td>
			{/if}
			{if $prefs.feature_right_column ne 'n' && $right_modules|@count > 0 && $show_columns.right_modules ne 'n'}
				<td id="rightcolumn" valign="top"{if $prefs.feature_right_column eq 'user'} style="display:{if isset($cookie.show_rightcolumn) and $cookie.show_rightcolumn ne 'y'}none{else}table-cell;_display:block{/if};" {/if}>
					<h2 class="hidden">Sidebar</h2>
					<div class="colwrapper">
						{section name=homeix loop=$right_modules}
							{$right_modules[homeix].data}
						{/section}
					</div>
				</td>
			{/if}
		</tr>
	{if $prefs.feature_bot_bar eq 'y'}
		<tr>
			<td id="footer" colspan="3">
				<div class="wrapper"> 
		  			<div class="content">
    					{include file='tiki-bot_bar.tpl'}
					</div>
				</div>
			</td>
		</tr>
	{/if}
</table>
{/if}
{include file='footer.tpl'}

{if $prefs.feature_endbody_code}{*this code must be added just before </body>: needed by google analytics *}
	{eval var=$prefs.feature_endbody_code}
{/if}
	</body>
</html>

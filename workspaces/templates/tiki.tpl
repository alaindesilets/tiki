<<<<<<< .working
{* $Id: tiki.tpl 12618 2008-04-21 05:43:35Z chibaguy $ *}{include file="header.tpl"}
=======
{* $Id$ *}
<!DOCTYPE html 
	PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{if !empty($pageLang)}{$pageLang}{else}{$prefs.language}{/if}" lang="{if !empty($pageLang)}{$pageLang}{else}{$prefs.language}{/if}">
	<head>
{include file="header.tpl"}
	</head>
	<body{if isset($section) and $section eq 'wiki page' and $prefs.user_dbl eq 'y' and $dblclickedit eq 'y' and $tiki_p_edit eq 'y'} ondblclick="location.href='tiki-editpage.php?page={$page|escape:"url"}';"{/if} onload="{if $prefs.feature_tabs eq 'y'}tikitabs({if $cookietab neq ''}{$cookietab}{else}1{/if},50);{/if}{if $msgError} javascript:location.hash='msgError'{/if}"{if $section or $smarty.session.fullscreen eq 'y'} class="{if $section}tiki_{$section|replace:' ':'_'}{/if}{if $smarty.session.fullscreen eq 'y'} fullscreen{/if}"{/if}>
		<ul class="jumplinks" style="position:absolute;top:-9000px;left:-9000px;z-index:9;">
			<li><a href="#tiki-center">{tr}Jump to Content{/tr}</a></li>
		</ul>

{if $prefs.feature_community_mouseover eq 'y'}		{popup_init src="lib/overlib.js"}{/if}

{if $prefs.feature_fullscreen eq 'y' and $filegals_manager eq '' and $print_page ne 'y'}
	{if $smarty.session.fullscreen eq 'y'}	<a href="{$smarty.server.SCRIPT_NAME}{if $fsquery}?{$fsquery|escape}&amp;{else}?{/if}fullscreen=n" class="menulink" id="fullscreenbutton">{icon _id=application_put alt="{tr}Cancel Fullscreen{/tr}"}</a>
	{else}	<a href="{$smarty.server.SCRIPT_NAME}{if $fsquery}?{$fsquery}&amp;{else}?{/if}fullscreen=y" class="menulink" id="fullscreenbutton">{icon _id=application_get alt="{tr}Fullscreen{/tr}"}</a>
	{/if}
{/if}

>>>>>>> .merge-right.r18200
{* TikiTest ToolBar *}
{if $prefs.feature_tikitests eq 'y' and $tikitest_state neq 0}
{include file="tiki-tests_topbar.tpl"}
{/if}
{if $prefs.feature_ajax eq 'y'}
{include file="tiki-ajax_header.tpl"}
{/if}
<div id="main">
{if $prefs.feature_fullscreen != 'y' or $smarty.session.fullscreen != 'y'}
<div class="clearfix" id="header"{if $prefs.feature_bidi eq 'y'} dir="rtl"{/if}>
	{if $prefs.feature_siteidentity eq 'y'}
	{* Site identity header section *}
	<div class="clearfix" id="siteheader">
		{include file="tiki-site_header.tpl"}
	</div>
	{/if}
</div>
{/if}
{* New admin top bar for 3.0 *}
{include file="tiki-admin_bar.tpl"}
<div class="clearfix" id="middle">
	<div class="clearfix {if $prefs.feature_fullscreen != 'n' and $smarty.session.fullscreen != 'n'}fullscreen{/if}{if $prefs.feature_fullscreen != 'y' and $smarty.session.fullscreen !='n'}nofullscreen{/if}" id="c1c2">
		<div class="clearfix" id="wrapper">
			<div id="col1" class="{if $prefs.feature_left_column ne 'n' && $left_modules|@count > 0 && $show_columns.left_modules ne 'n'}marginleft{/if}{if $prefs.feature_right_column ne 'n' && $right_modules|@count > 0 && $show_columns.right_modules ne 'n'} marginright{/if}"{if $prefs.feature_bidi eq 'y'} dir="rtl"{/if}>
				{if $smarty.session.fullscreen neq 'y'}
		{if $prefs.feature_left_column eq 'user' or $prefs.feature_right_column eq 'user'}
			<div class="clearfix" id="showhide_columns">
			{if $prefs.feature_left_column eq 'user' && $left_modules|@count > 0 && $show_columns.left_modules ne 'n'}
				<div style="text-align:left;float:left;"><a class="flip" 
					href="#" onclick="toggleCols('col2','left'); return false">{icon _id=ofolder  name="leftcolumnicn" class="colflip" alt="+/-"}&nbsp;{tr}Show/Hide Left Menus{/tr}&nbsp;</a></div>
    		{/if}
			{if $prefs.feature_right_column eq 'user'&& $right_modules|@count > 0 && $show_columns.right_modules ne 'n'}
				<div class="clearfix" style="text-align:right;float:right"><a class="flip"
					href="#" onclick="toggleCols('col3','right'); return false">&nbsp;{tr}Show/Hide Right Menus{/tr}&nbsp;{icon _id=ofolder name="rightcolumnicn" class="colflip" alt="+/-"}</a>
				</div>
			{/if}
			<br style="clear:both" />
			</div>
		{/if}
	{/if}
	{if $prefs.feature_tell_a_friend eq 'y' && $tiki_p_tell_a_friend eq 'y' and (!isset($edit_page) or $edit_page ne 'y' and $prefs.feature_site_send_link ne 'y')}
				<div class="tellafriend"><a href="tiki-tell_a_friend.php?url={$smarty.server.REQUEST_URI|escape:'url'}">{tr}Email this page{/tr}</a>
				</div>
				{/if}
					<div id="tiki-center" {*id needed for ajax editpage link*} class="clearfix content">
						{$mid_data}
						{show_help}
					</div>
				</div>
			</div>
			{if $prefs.feature_fullscreen != 'y' or $smarty.session.fullscreen != 'y'}
			<hr class="hidden" /> {* for semantic separation of center and side columns *}
			{if $prefs.feature_left_column ne 'n' && $left_modules|@count > 0 && $show_columns.left_modules ne 'n'}
				<div id="col2"{if $prefs.feature_bidi eq 'y'} dir="rtl"{/if}>
				<h2 class="hidden">Sidebar</h2>
					<div class="content">
						{section name=homeix loop=$left_modules}
						 	{$left_modules[homeix].data}
						{/section}
    			    </div>
				</div>
			{/if}
			{/if}
			</div>{* -- END of c1c2 -- *}
{if $prefs.feature_fullscreen != 'y' or $smarty.session.fullscreen != 'y'}
	{if $prefs.feature_right_column ne 'n' && $right_modules|@count > 0 && $show_columns.right_modules ne 'n'}
		<div class="clearfix" id="col3" 
		{if $prefs.feature_right_column eq 'user'} 
		style="display:{if isset($cookie.show_rightcolumn) and $cookie.show_rightcolumn ne 'y'}none{else}table-cell;_display:block{/if};"
		{/if}{if $prefs.feature_bidi eq 'y'} dir="rtl"{/if}>
		<h2 class="hidden">Sidebar</h2>
		<div class="content">
			{section name=homeix loop=$right_modules}
				{$right_modules[homeix].data}
			{/section}
        </div>
	</div><br style="clear:both" />
	{/if}
{/if}
</div>
</div>{* -- END of middle part wrapper -- *}
{if $prefs.feature_fullscreen != 'y' or $smarty.session.fullscreen != 'y'}
{if $prefs.feature_bot_bar eq 'y'}
<div id="footer">
	<div class="footerbgtrap">
		<div class="content"{if $prefs.feature_bidi eq 'y'} dir="rtl"{/if}>
   			{include file="tiki-bot_bar.tpl"}
		</div>
	</div>
</div>

{/if}
{/if}
{include file="footer.tpl"}

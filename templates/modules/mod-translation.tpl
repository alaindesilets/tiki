{* $Header: /cvsroot/tikiwiki/tiki/templates/modules/mod-translation.tpl,v 1.1.2.1 2008-01-29 15:28:13 lphuberdeau Exp $ *}

{if $show_translation_module}
{if !isset($tpl_module_title)}{assign var=tpl_module_title value="{tr}Page translation{/tr}"}{/if}
{tikimodule title=$tpl_module_title name="translation" flip=$module_params.flip decorations=$module_params.decorations nobox=$module_params.nobox}
	{if $mod_translation_better_known or $mod_translation_better_other}
		<div>
			{tr}Pages with updated content{/tr}:
			{if $mod_translation_better_known}
			<ul>
				{foreach item=better from=$mod_translation_better_known}
				<li>
					<a href="tiki-index.php?page={$better.page|escape}">{$better.page}</a> ({$better.lang})
					{if $tiki_p_edit}
					<div>
						- <a href="tiki-editpage.php?page={$pageName|escape}&amp;source_page={$better.page|escape}&amp;oldver={$better.last_update|escape}&amp;newver={$better.current_version|escape}&amp;diff_style=inlinediff-full">{tr}update from it{/tr}</a>
					</div>
					{/if}
				</li>
				{/foreach}
			</ul>
			{else}
				<em>{tr}Sorry, none of the pages match your <a href="tiki-user_preferences.php">language preferences</a>.{/tr}</em>
			{/if}
			{if $mod_translation_better_other}
			<a href="javascript:void(0)" onclick="document.getElementById('mod-translation-better-ul').style.display='block';this.style.display='none'">{tr}More...{/tr}</a>
			<ul id="mod-translation-better-ul" style="display:none">
				{foreach item=better from=$mod_translation_better_other}
				<li>
					<a href="tiki-index.php?page={$better.page|escape}">{$better.page}</a> ({$better.lang})
					{if $tiki_p_edit}
					<div>
						- <a href="tiki-editpage.php?page={$pageName|escape}&amp;source_page={$better.page|escape}&amp;oldver={$better.last_update|escape}&amp;newver={$better.current_version|escape}&amp;diff_style=inlinediff-full">{tr}update from it{/tr}</a>
					</div>
					{/if}
				</li>
				{/foreach}
			</ul>
			{/if}
		</div>
	{/if}
{/tikimodule}
{/if}

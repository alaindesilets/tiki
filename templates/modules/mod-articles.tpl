{* $Id$ *}

{tikimodule error=$module_params.error title=$tpl_module_title name="articles" flip=$module_params.flip decorations=$module_params.decorations nobox=$module_params.nobox notitle=$module_params.notitle}
	{if $nonums != 'y'}<ol>{else}<ul>{/if}
		{section name=ix loop=$modArticles}
			<li>
				{if isset($module_params.img)}
					<div class="image">
						<img alt="" src="article_image.php?{if $modArticles[ix].hasImage eq 'y'}id={$modArticles[ix].articleId}{elseif $modArticles[ix].topicId}image_type=topic&amp;id={$modArticles[ix].topicId}{/if}" width="{$module_params.img}" />
					</div>
				{/if}
				<a class="linkmodule" href="{if $absurl == 'y'}{$base_url}{/if}{$modArticles[ix].articleId|sefurl:article}" title="{$modArticles[ix].created|tiki_short_date}, {tr}by{/tr} {$modArticles[ix].author|escape}">
					{$modArticles[ix].title|escape}{if $showcreated eq 'y'} <span class="date">({$modArticles[ix].created|tiki_short_date})</span>{/if}{if $showpubl eq 'y'} <span class="date">({$modArticles[ix].publishDate|tiki_short_date})</span>{/if}
				</a>
			</li>
		{/section}
	{if $nonums != 'y'}</ol>{else}</ul>{/if}
	{if $more eq 'y'}
		<div class="more">
			{assign var=queryArgs value=''}
			{foreach from=$urlParams item=urlParam key=urlParamKey}
				{if !empty($urlParam) and !empty($module_params[$urlParamKey])}
					{if empty($queryArgs)}
						{assign var=queryArgs value='?'}
					{else}
						{assign var=queryArgs value="$queryArgs&amp;"}
					{/if}
					{capture assign=queryArgs}{$queryArgs}{$urlParam}={$module_params[$urlParamKey]|escape:"url"}{/capture}
				{/if}
			{/foreach}
			{button href="tiki-view_articles.php$queryArgs" _text="{tr}More...{/tr}"}
		</div>
	{/if}
{/tikimodule}

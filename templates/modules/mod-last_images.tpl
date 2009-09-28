{* $Id$ *}

{tikimodule error=$module_params.error title=$tpl_module_title name="last_images" flip=$module_params.flip decorations=$module_params.decorations nobox=$module_params.nobox notitle=$module_params.notitle}

{if $nonums != 'y'}<ol>{else}<ul>{/if}
{section name=ix loop=$modLastImages}
<li>
	{if $content eq "thumbnails"}
		<span class="module">
       <a class="linkmodule" href="tiki-browse_image.php?imageId={$modLastImages[ix].imageId}">
       {* doing regex to prevent xss *}
       <img src="show_image.php?id={$modLastImages[ix].imageId}&amp;thumb=1" title="{$modLastImages[ix].name|regex_replace:"/\"/":"'"}" alt="{$modLastImages[ix].description|regex_replace:"/\"/":"'"}" />
       </a>
		</span>
{if isset($toolbar)}
<span class="module"><a class="linkmodule" href="javascript:insertAt('editwiki','{literal}{{/literal}img src=show_image.php?id={$modLastImages[ix].imageId}{literal}}{/literal}');">{tr}insert original{/tr}</a>
::<a class="linkmodule" href="javascript:insertAt('editwiki','{literal}{{/literal}img src=show_image.php?id={$modLastImages[ix].imageId}&amp;thumb=1{literal}}{/literal}');">{tr}insert thumbnail{/tr}</a>
</span>
{/if}
	{else}
		<a class="linkmodule" href="tiki-browse_image.php?imageId={$modLastImages[ix].imageId}">{$modLastImages[ix].name|escape}</a>
	{/if}
</li>
{/section}
{if $nonums != 'y'}</ol>{else}</ul>{/if}
{/tikimodule}

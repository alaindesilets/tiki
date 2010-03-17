{* $Id$ *}

{tikimodule error=$module_params.error title=$tpl_module_title name="last_created_blogs" flip=$module_params.flip decorations=$module_params.decorations nobox=$module_params.nobox notitle=$module_params.notitle}
{if $modLastCreatedBlogs[0] neq ''}
	{if $nonums != 'y'}<ol>{else}<ul>{/if}
	   {section name=ix loop=$modLastCreatedBlogs}
			<li>
	          <a class="linkmodule" href="tiki-view_blog.php?blogId={$modLastCreatedBlogs[ix].blogId}" title="{$modLastCreatedBlogs[ix].created|tiki_short_datetime}, {tr}by{/tr} {if $modLastCreatedBlogs[ix].user ne ''}{$modLastCreatedBlogs[ix].user|escape}{else}{tr}Anonymous{/tr}{/if}">
	            {$modLastCreatedBlogs[ix].title|escape}
	          </a>
			</li>
	    {/section}
	{if $nonums != 'y'}</ol>{else}</ul>{/if}
{else}
      <em>{tr}No records to display{/tr}</em>
{/if}
{/tikimodule}

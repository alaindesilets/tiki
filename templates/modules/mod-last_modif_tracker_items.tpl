{* $Id$ *}

{if !isset($tpl_module_title)}
{if $module_params.nonums eq 'y'}
{eval var="{tr}Last `$module_rows` Modified Items{/tr}" assign="tpl_module_title"}
{else}
{eval var="{tr}Last Modified Items{/tr}" assign="tpl_module_title"}
{/if}
{/if}
{tikimodule error=$module_params.error title=$tpl_module_title name="last_modif_tracker_items" flip=$module_params.flip decorations=$module_params.decorations nobox=$module_params.nobox notitle=$module_params.notitle}
  {if !empty($module_error)}{tr}{$module_error}{/tr}{/if}
  {if $module_params.nonums != 'y'}<ol>{else}<ul>{/if}
   {section name=ix loop=$modLastItems}
   <li>
	<a class="linkmodule" href="tiki-view_tracker_item.php?itemId={$modLastItems[ix].itemId}&amp;trackerId={$modLastItems[ix].trackerId}">
	{$modLastItems[ix].subject}
          </a>
	 </li>
    {/section}
{if $module_params.nonums != 'y'}</ol>{else}</ul>{/if}
{/tikimodule}

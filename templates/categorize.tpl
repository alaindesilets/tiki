{if $feature_categories eq 'y' and (count($categories) gt 0 or $tiki_p_admin_categories eq 'y')}
<tr class="formcolor">
 <td>{tr}Categorize{/tr}</td>
 <td{if $cols} colspan="{$cols}"{/if}>
  [ <a title="{tr}Click here to show the categories{/tr}" class="link" href="javascript:show('categorizator');">{tr}show categories{/tr}</a>
  | <a title="{tr}Click here to hide the categories{/tr}" class="link" href="javascript:hide('categorizator');">{tr}hide categories{/tr}</a> ]
  <div id="categorizator" {if $cat_categorize eq 'n' and $categ_checked ne 'y'}style="display:none;"{else}style="display:block;"{/if}>
  {if count($categories) gt 0}
   <select name="cat_categories[]" multiple="multiple" size="5">
   {section name=ix loop=$categories}
    <option value="{$categories[ix].categId|escape}" {if $categories[ix].incat eq 'y'}selected="selected"{/if}>{$categories[ix].categpath}</option>
   {/section}
   </select><br />
   <label for="cat-check">{tr}categorize this object{/tr}:</label>
    <input type="checkbox" name="cat_categorize" id="cat-check" {if $cat_categorize eq 'y' or $categ_checked eq 'y'}checked="checked"{/if}/><br />
  {else}
    {tr}No categories defined{/tr} <br />
  {/if}
  {if $tiki_p_admin_categories eq 'y'}
    <a title="{tr}Click here to administer categories{/tr}" href="tiki-admin_categories.php" class="link">{tr}Admin categories{/tr}</a>
  {/if}
  </div>
  </td>
</tr>
{/if}{* $feature_categories eq 'y' *}

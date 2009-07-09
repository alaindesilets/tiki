{* $Id$ *}

{if is_array($fgal_options) and count($fgal_options) gt 0}
	{foreach key=key item=item from=$fgal_options}
		{if $key eq 'default_view'}
<tr class="formcolor">
	<td><label for="fgal_{$key}">{$item.name}:<label></td>
	<td>
		<select id="fgal_{$key}" name="fgal_{$key}">
			<option value="list"{if $item.value eq 'list'} selected="selected"{/if}>{tr}List{/tr}</option>
			<option value="browse"{if $item.value eq 'browse'} selected="selected"{/if}>{tr}Browse{/tr}</option>
		</select>
	</td>
</tr>
		{else}
<tr class="formcolor">
	<td><label for="fgal_{$key}">{$item.name}:</label></td>
	<td><input type="checkbox" id="fgal_{$key}" name="fgal_{$key}" {if $item.value eq 'y'}checked="checked"{/if}/></td>
</tr>
		{/if}
	{/foreach}
{/if}

{if is_array($fgal_listing_conf) and count($fgal_listing_conf) gt 0}
	{foreach key=key item=item from=$fgal_listing_conf}
<tr class="formcolor">
	<td><label for="fgal_list_{$key}">{$item.name}:</label></td>
	<td>
		<select id="fgal_list_{$key}" name="fgal_list_{$key}">
		{if $key eq 'name'}
			<option value="a"{if $item.value eq 'a'} selected="selected"{/if}>{tr}Name-filename{/tr}</option>
			<option value="n"{if $item.value eq 'n'} selected="selected"{/if}>{tr}Name{/tr}</option>
			<option value="f"{if $item.value eq 'f'} selected="selected"{/if}>{tr}Filename only{/tr}</option>
		{else}
			<option value='n'{if $item.value eq 'n'} selected="selected"{/if}>{tr}Hide{/tr}</option>
			<option value='y'{if $item.value eq 'y'} selected="selected"{/if}>{tr}Show as a column{/tr}</option>
			<option value='o'{if $item.value eq 'o'} selected="selected"{/if}>{tr}Show in popup box{/tr}</option>
			<option value='a'{if $item.value eq 'a'} selected="selected"{/if}>{tr}Both{/tr}</option>
		{/if}
		{if $key eq 'lockedby'}
			<option value='i'{if $item.value eq 'i'} selected="selected"{/if}>{tr}Show an icon in a column{/tr}</option>
		{/if}
		</select>
	</td>
</tr>
	{/foreach}
{/if}

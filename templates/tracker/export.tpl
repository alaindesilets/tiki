<div class="accordion">
	<h4>{tr}Structure{/tr}</h4>
	<form class="simple" action="" method="post">
		<label>
			{tr}Tracker Export{/tr}
			<textarea>{$export|escape}</textarea>
		</label>
	</form>
	<h4>{tr}Quick Export{/tr}</h4>
	<form method="post" class="simple no-ajax" action="{service controller=tracker action=dump_items trackerId=$trackerId}">
		<p>{tr}Produce a CSV with basic formatting.{/tr}</p>
		<div {*class="submit"*}>
			<input type="submit" value="{tr}Export{/tr}"/>
		</div>
	</form>
	<h4>{tr}Export Tracker Items{/tr}</h4>
	<form class="simple no-ajax" action="{service controller=tracker action=export_items trackerId=$trackerId}" method="post">
		<label>
			{tr}Filename{/tr}
			<input type="text" value="Tracker_{$trackerId|escape}.csv" disabled="disabled"/>
		</label>
		<label>
			{tr}Charset encoding{/tr}
			<select name="encoding">
				<option value="UTF-8" selected="selected">{tr}UTF-8{/tr}</option>
				<option value="ISO-8859-1">{tr}ISO-8859-1 Latin{/tr}</option>
			</select>
		</label>
		<label>
			{tr}Separator{/tr}
			<input type="text" name="separator" value="," size="2" />
		</label>
		<label>
			{tr}Delimitor (left){/tr}
			<input type="text" name="delimitorL" value="&quot;" size="2" />
		</label>
		<label>
			{tr}Delimitor (right){/tr}
			<input type="text" name="delimitorR" value="&quot;" size="2" />
		</label>
		<label>
			{tr}Carriage return inside field value{/tr}
			<input type="text" name="CR" value="%%%" size="4" />
		</label>
		<label>
			<input type="checkbox" name="parse" value="1" />
			{tr}Parse as wiki text{/tr}
		</label>
		<fieldset>
			<legend>{tr}Generic information{/tr}</legend>
			<label>
				<input type="checkbox" name="showItemId" value="1" checked="checked" />
				{tr}Item ID{/tr}
			</label>
			<label>
				<input type="checkbox" name="showStatus" value="1" checked="checked" />
				{tr}Status{/tr}
			</label>
			<label>
				<input type="checkbox" name="showCreated" value="1" checked="checked" />
				{tr}Creation date{/tr}
			</label>
			<label>
				<input type="checkbox" name="showLastModif" value="1" checked="checked" />
				{tr}Last modification date{/tr}
			</label>
		</fieldset>
		<fieldset>
			<legend>{tr}Fields{/tr}</legend>
			{foreach from=$fields item=field}
				<label>
					<input type="checkbox" name="listfields[]" value="{$field.fieldId|escape}" checked="checked" />
					{$field.name|escape}
				</label>
			{/foreach}
		</fieldset>
		<label>
			{tr}Number of records{/tr}
			<input type="number" name="recordsMax" value="{$recordsMax|escape}" />
		</label>
		<label>
			{tr}First record{/tr}
			<input type="number" name="recordsOffset" value="1" />
		</label>
		<div{* class="submit"*}>
			<input type="submit" value="{tr}Export{/tr}" />
		</div>
	</form>
</div>
{jq}
$('.accordion').removeClass('accordion').accordion({
	header: 'h4',
	autoHeight: false
});
{/jq}

<form class="simple" method="post" action="tiki-ajax_services.php">
	<label>
		{tr}Name:{/tr}
		<input type="text" name="name" value="{$name|escape}" required="required"/>
	</label>
	<label style="display:none;">
		{tr}Permanent Name:{/tr}
		<input type="text" name="permName" value="{$permName|escape}" pattern="[a-zA-Z0-9_]+"/>
	</label>
	<label>
		{tr}Type:{/tr}
		<select name="type">
			{foreach from=$types key=k item=info}
				<option value="{$k|escape}"
					{if $type eq $k}selected="selected"{/if}>
					{$info.name|escape}
					{if $info.deprecated}- Deprecated{/if}
				</option>
			{/foreach}
		</select>
		{foreach from=$types item=info key=k}
			<div class="description {$k|escape}" style="display: none;">
				{$info.description|escape}
			</div>
		{/foreach}
	</label>
	<label>
		{tr}Description:{/tr}
		<textarea name="description">{$description|escape}</textarea>
	</label>
	<label>
		<input type="checkbox" name="description_parse" value="1"
			{if $descriptionIsParsed}checked="checked"{/if}
			/>
		{tr}Description contains wiki syntax{/tr}
	</label>
	<label>
		<input type="checkbox" name="adminOnly" value="1"/>
		{tr}Restrict visibility to administrators{/tr}
		<div class="description">
			{tr}Useful if you are working on a live tracker.{/tr}
		</div>
	</label>
	<div>
		<input type="submit" name="submit" value="{tr}Add Field{/tr}"/>
		<input type="submit" name="submit_and_edit" value="{tr}Add Field &amp; Edit Advanced Options{/tr}"/>
		<input type="hidden" name="controller" value="tracker"/>
		<input type="hidden" name="action" value="add_field"/>
		<input type="hidden" name="trackerId" value="{$trackerId|escape}"/>
		<input type="hidden" name="next" value="close"/>
	</div>
</form>

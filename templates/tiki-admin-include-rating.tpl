{* $Id$ *}

<form class="admin" id="performance" name="performance" action="tiki-admin.php?page=rating" method="post">
	<div class="heading input_submit_container" style="text-align: right">
		<input type="submit" value="{tr}Apply{/tr}" />
		<input type="reset" value="{tr}Reset{/tr}" />
	</div>

	<fieldset>
		<legend>{tr}Global configuration{/tr}</legend>
		{preference name=rating_advanced}
	</fieldset>
	
	<div class="input_submit_container" style="margin-top: 5px; text-align: center">
		<input type="submit" value="{tr}Apply{/tr}" />
	</div>
</form>
<div id="rating_advanced_childcontainer">
	{foreach from=$configurations item=config}
		<form class="config" method="post" action="">
			<fieldset>
				<legend>{$config.name|escape}</legend>
				<input type="hidden" name="config" value="{$config.ratingConfigId|escape}"/>
				<div>
					<label for="rating_name_{$config.ratingConfigId|escape}">{tr}Name{/tr}</label>
					<input type="text" name="name" value="{$config.name|escape}" id="rating_name_{$config.ratingConfigId|escape}"/>
				</div>
				<div>
					<label for="rating_expiry_{$config.ratingConfigId|escape}">{tr}Cache duration{/tr}</label>
					<input type="text" name="expiry" value="{$config.expiry|escape}" id="rating_expiry_{$config.ratingConfigId|escape}"/>
				</div>
				<div>
					<textarea name="formula" rows="5" style="width: 100%;">{$config.formula|escape}</textarea>
				</div>
				<div class="error"></div>
				<input type="submit" name="edit" value="{tr}Save{/tr}"/>
			</fieldset>
		</form>
	{/foreach}
	<form method="post" action="">
		<fieldset>
			<legend>{tr}Create New{/tr}</legend>
			<label for="rating_config_new">{tr}Name{/tr}</label>
			<input type="text" name="name" id="rating_config_new"/>
			<input type="submit" name="create" value="{tr}Create{/tr}"/>
		</fieldset>
	</form>
</div>
{jq}
$jq('form.config').submit( function( e ) {
	return ! $jq(this).find('input[type=submit]').attr('disabled');
} );
$jq('form.config .error').hide();
$jq('form.config textarea').change( function( e ) {
	var text = this;
	e.preventDefault();
	var submit = $jq(this).closest('form').find('input[type=submit]').attr('disabled', true);
	$jq.getJSON( window.location.href, { test: $jq(this).val() }, function( data ) {
		submit.attr( 'disabled', ! data.valid );
		if( data.valid ) {
			$jq(text).closest('form').find('.error').hide();
		} else {
			$jq(text).closest('form').find('.error').show().text( data.message );
		}
	} );
} );
{/jq}

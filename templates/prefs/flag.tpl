<div class="adminoptionbox">
	<div class="adminoption">
		<input id="{$p.id|escape}" type="checkbox" name="{$p.preference|escape}" {if $p.value eq 'y'}checked="checked" {/if} {if ! $p.available}disabled="disabled"{/if}/>
	</div>
	<div class="adminoptionlabel" >
		<label for="{$p.id|escape}">{$p.name|escape}</label>
		{include file=prefs/shared-flags.tpl}
		{if $p.hint}
			<br/><em>{$p.hint|simplewiki}</em>
		{/if}
	</div>
	{include file=prefs/shared-dependencies.tpl}
	{jq}
if( ! $jq('#{{$p.id|escape}}').attr('checked') || $jq('#{{$p.id|escape}}').attr('disabled') ) {
	$jq('#{{$p.preference|escape}}_childcontainer').hide();
}
if ($jq('#{{$p.preference|escape}}_childcontainer').length) {
	$jq('#{{$p.id|escape}}').change( function() {
		var id = '{{$p.preference|escape}}_childcontainer';
		if( $jq('#{{$p.id|escape}}').attr('checked') || $jq('#{{$p.id|escape}}').attr('disabled') ) {
			{{if $mode eq 'invert'}}hide(id);{{else}}show(id);{{/if}}
		} else {
			{{if $mode eq 'invert'}}show(id);{{else}}hide(id);{{/if}}
		}
	} ).change();
}
{/jq}
</div>

{* $Id$ *}
{strip}
	{* Simple remarks box used by Smarty entity block.remarksbox.php & wikiplugin_remarksbox.php *}
	<div class="clearfix rbox {$rbox_params.type} panel {$rbox_params.class}" id="{$rbox_guid}">
		{if $rbox_params.close and $rbox_params.type ne 'errors' and $rbox_params.type ne 'confirm'}
			{icon _id="close" class="rbox-close close" aria-hidden="true" onclick=$rbox_close_click}
		{/if}
		{if $rbox_params.title ne ''}
			<div class="rbox-title panel-heading">
				{if $rbox_params.icon ne 'none'}{icon _id=$rbox_params.icon alt="{tr}{$rbox_params.type}{/tr}"}{/if} {$rbox_params.title|escape}
			</div>
		{/if}
		<div class="rbox-data {$rbox_params.highlight} panel-body"{if !empty($rbox_params.width)} style="width:{$rbox_params.width}"{/if}>
			{$remarksbox_content}
		</div>
	</div>
{/strip}
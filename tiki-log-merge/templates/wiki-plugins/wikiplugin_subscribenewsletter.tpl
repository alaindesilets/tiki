{* $Id$ *}
{if $wpSubscribe eq 'y'}
	{if empty($subscribeThanks)}
		{tr}Subscription confirmed!{/tr}
	{else}
		{$subscribeThanks|escape}
	{/if}
{else}
	<form method="post">
		<input type="hidden" name="wpNlId" value="{$subscribeInfo.nlId|escape}" />
		{if empty($subcribeMessage)}
			<input type="submit" name="wpSubscribe" value="{tr}Subscribe to the newsletter:{/tr} {$subscribeInfo.name}" />
		{else}
			<input type="submit" name="wpSubscribe" value="{$subcribeMessage|escape}" />
		{/if}
	</form>
{/if}
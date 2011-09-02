<form method="post" action="" id="{$execution_key|escape}_form">
	<input type="hidden" name="{$execution_key|escape}" value="1"/>
	<div class="memberlist">
		{if $displayMode eq 'tabs'}
			<ul>
				{foreach from=$memberlist_groups key=groupName item=groupData}
						<li><a href="#{$execution_key|escape}_{$groupName|escape}">{$groupName|escape}</a></li>
				{/foreach}
			</ul>
		{/if}
		{foreach from=$memberlist_groups key=groupName item=groupData}
			<div class="group" id="{$execution_key|escape}_{$groupName|escape}">
				<h2>{$groupName|escape}</h2>
				{if isset($groupData.info) and !empty($groupData.info.groupDesc)}
					<p class=="description">{$groupData.info.groupDesc}</p>
				{/if}
				{if $groupData.members}
					{if $groupData.can_remove}{tr}Check to remove:{/tr}{/if}
					<ul>
						{foreach from=$groupData.members item=memberName}
							<li>
								{if $groupData.can_remove && $memberName != $user}
									<label>
										<input type="checkbox" name="remove[{$groupName|escape}][]" value="{$memberName|escape}"/>
										{$memberName|userlink}
									</label>
								{else}
									{$memberName|userlink}
								{/if}
								{if $prefs.feature_group_transition eq 'y'}
									{foreach from=$groupData.transitions key=cand item=trans}
										{if $cand eq $memberName}
											{foreach from=$trans key=trans item=label}
												{self_link transition=$trans member=$memberName}{$label|escape}{/self_link}
											{/foreach}
										{/if}
									{/foreach}
								{/if}
							</li>
						{/foreach}
					</ul>
				{/if}
				{if $groupData.can_add}
					<p class="action">{tr}Add:{/tr} <input type="text" name="add[{$groupName|escape}]" class="username-input"/> (comma separated)</p>
				{/if}
				{if $groupData.can_join}
					<p class="action">
						<input type="checkbox" name="join[]" value="{$groupName|escape}" id="join-{$groupName|escape}"/>
						<label for="join-{$groupName|escape}">{tr}Join myself{/tr}</label>
					</p>
				{/if}
				{if $groupData.can_leave}
					<p class="action">
						<input type="checkbox" name="leave[]" value="{$groupName|escape}" id="leave-{$groupName|escape}"/>
						<label for="leave-{$groupName|escape}">{tr}Leave myself{/tr}</label>
					</p>
				{/if}
			</div>
		{/foreach}
	</div>
	{if $can_apply}
		<input type="submit" value="{tr}Apply{/tr}"/>
	{/if}
</form>
{jq}
$('.username-input').tiki('autocomplete','username');
{/jq}

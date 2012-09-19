{* $Id$ *}
{title help="Server+Check"}{tr}Server Check{/tr}{/title}

<h2>{tr}MySQL Database Properties{/tr}</h2>
<table class="normal">
	<tr>
		<th>{tr}Property{/tr}</th>
		<th>{tr}Value{/tr}</th>
		<th>{tr}Tiki Fitness{/tr}</th>
		<th>{tr}Explanation{/tr}</th>
	</tr>
	{cycle values="even,odd" print=false}
	{foreach from=$mysql_properties key=key item=item}
		<tr class="{cycle}">
			<td class="text">{$key}</td>
			<td class="text">{$item.setting}</td>
			<td class="text">
				{if $item.fitness eq 'good'}
					{icon _id=accept alt="$item.fitness" style="vertical-align:middle"}
				{elseif $item.fitness eq 'bad'}
					{icon _id=exclamation alt="$item.fitness" style="vertical-align:middle"}
				{elseif $item.fitness eq 'ugly'}
					{icon _id=error alt="$item.fitness" style="vertical-align:middle"}
				{elseif $item.fitness eq 'unknown'}
					{icon _id=error alt="$item.fitness" style="vertical-align:middle"}
				{/if}
				{$item.fitness}
			</td>
			<td class="text">{$item.message}</td>
		</tr>
	{foreachelse}
		{norecords _colspan=4}
	{/foreach}
</table>

<h2>MySQL crashed Tables</h2>
{remarksbox type="note" title="{tr}Be careful{/tr}"}The following list is just a very quick look at SHOW TABLE STATUS that tells you, if tables have been marked as crashed. If you are experiencing database problems you should still run CHECK TABLE or myisamchk to make sure.{/remarksbox}
<table class="normal">
	<tr>
		<th>{tr}Table{/tr}</th>
		<th>{tr}Comment{/tr}</th>
	</tr>
	{cycle values="even,odd" print=false}
	{foreach from=$mysql_crashed_tables key=key item=item}
		<tr class="{cycle}">
			<td class="text">{$key}</td>
			<td class="text">{$item.Comment}</td>
		</tr>
	{foreachelse}
		{norecords _colspan=2}
	{/foreach}
</table>

<h2>{tr}Server Information{/tr}</h2>
<table class="normal">
	<tr>
		<th>{tr}Property{/tr}</th>
		<th>{tr}Value{/tr}</th>
	</tr>
	{cycle values="even,odd" print=false}
	{foreach from=$server_information key=key item=item}
		<tr class="{cycle}">
			<td class="text">{$key}</td>
			<td class="text">{$item.value}</td>
		</tr>
	{foreachelse}
		{norecords _colspan=2}
	{/foreach}
</table>

<h2>{tr}Server Properties{/tr}</h2>
<table class="normal">
	<tr>
		<th>{tr}Property{/tr}</th>
		<th>{tr}Value{/tr}</th>
		<th>{tr}Tiki Fitness{/tr}</th>
		<th>{tr}Explanation{/tr}</th>
	</tr>
	{cycle values="even,odd" print=false}
	{foreach from=$server_properties key=key item=item}
		<tr class="{cycle}">
			<td class="text">{$key}</td>
			<td class="text">{$item.value}</td>
			<td class="text">
				{if $item.fitness eq 'good'}
					{icon _id=accept alt="$item.fitness" style="vertical-align:middle"}
				{elseif $item.fitness eq 'bad'}
					{icon _id=exclamation alt="$item.fitness" style="vertical-align:middle"}
				{elseif $item.fitness eq 'ugly'}
					{icon _id=error alt="$item.fitness" style="vertical-align:middle"}
				{elseif $item.fitness eq 'unknown'}
					{icon _id=error alt="$item.fitness" style="vertical-align:middle"}
				{/if}
				{$item.fitness}
			</td>
			<td class="text">{$item.message}</td>
		</tr>
	{foreachelse}
		{norecords _colspan=4}
	{/foreach}
</table>

<h2>{tr}PHP scripting language properties{/tr}</h2>
<table class="normal">
	<tr>
		<th>{tr}Property{/tr}</th>
		<th>{tr}Value{/tr}</th>
		<th>{tr}Tiki Fitness{/tr}</th>
		<th>{tr}Explanation{/tr}</th>
	</tr>
	{cycle values="even,odd" print=false}
	{foreach from=$php_properties key=key item=item}
		<tr class="{cycle}">
			<td class="text">{$key}</td>
			<td class="text">{$item.setting}</td>
			<td class="text">
				{if $item.fitness eq 'good'}
					{icon _id=accept alt="$item.fitness" style="vertical-align:middle"}
				{elseif $item.fitness eq 'bad'}
					{icon _id=exclamation alt="$item.fitness" style="vertical-align:middle"}
				{elseif $item.fitness eq 'ugly'}
					{icon _id=error alt="$item.fitness" style="vertical-align:middle"}
				{elseif $item.fitness eq 'unknown'}
					{icon _id=error alt="$item.fitness" style="vertical-align:middle"}
				{/if}
				{$item.fitness}
			</td>
			<td class="text">{$item.message}</td>
		</tr>
	{foreachelse}
		{norecords _colspan=4}
	{/foreach}
</table>

<h2>{tr}PHP security properties{/tr}</h2>
<table class="normal">
	<tr>
		<th>{tr}Property{/tr}</th>
		<th>{tr}Value{/tr}</th>
		<th>{tr}Tiki Fitness{/tr}</th>
		<th>{tr}Explanation{/tr}</th>
	</tr>
	{cycle values="even,odd" print=false}
	{foreach from=$security key=key item=item}
		<tr class="{cycle}">
			<td class="text">{$key}</td>
			<td class="text">{$item.setting}</td>
			<td class="text">
				{if $item.fitness eq 'good' or $item.fitness eq 'safe'}
					{icon _id=accept alt="$item.fitness" style="vertical-align:middle"}
				{elseif $item.fitness eq 'bad' or $item.fitness eq 'risky'}
					{icon _id=exclamation alt="$item.fitness" style="vertical-align:middle"}
				{elseif $item.fitness eq 'ugly'}
					{icon _id=error alt="$item.fitness" style="vertical-align:middle"}
				{elseif $item.fitness eq 'unknown'}
					{icon _id=error alt="$item.fitness" style="vertical-align:middle"}
				{/if}
				{$item.fitness}
			</td>
			<td class="text">{$item.message}</td>
		</tr>
	{foreachelse}
		{norecords _colspan=4}
	{/foreach}
</table>

<h2>{tr}MySQL Variable Information{/tr}</h2>
<table class="normal">
	<tr>
		<th>{tr}Property{/tr}</th>
		<th>{tr}Value{/tr}</th>
	</tr>
	{cycle values="even,odd" print=false}
	{foreach from=$mysql_variables key=key item=item}
		<tr class="{cycle}">
			<td class="text">{$key}</td>
			<td class="text">{$item.value}</td>
		</tr>
	{foreachelse}
		{norecords _colspan=2}
	{/foreach}
</table>

<h2>{tr}PHP Info{/tr}</h2>
For more detailed information about your PHP installation see <a href="tiki-phpinfo.php">Admin->phpinfo</a>.
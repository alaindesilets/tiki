{* $Id: mod-calendar_new.tpl 12242 2008-03-30 13:22:01Z luciash $ *}
{if $show_calendar_module eq 'y'}
{tikimodule error=$module_params.error title=$tpl_module_title name=$name flip=$module_params.flip decorations=$module_params.decorations nobox=$module_params.nobox notitle=$module_params.notitle}
{if $viewlist eq 'list'}
	{include file='tiki-calendar_listmode.tpl'}
{else}
	{include file='tiki-calendar_nav.tpl'}

	<table cellpadding="0" cellspacing="0" border="0" class="caltable" style="text-align:center;">
		<tr>
			{section name=dn loop=$daysnames_abr}
				<th class="days" width="14%">{$daysnames_abr[dn]|ucfirst}</th>
			{/section}
		</tr>
		{cycle values="odd,even" print=false}
		{section name=w loop=$cell}
			<tr>
				{section name=d loop=$weekdays}
					{assign var=day_cursor value=$cell[w][d].day|tiki_date_format:"%d"}
					{assign var=month_cursor value=$cell[w][d].day|tiki_date_format:"%m"}
					{assign var=day_today value=$smarty.now|tiki_date_format:"%d"}
					{assign var=month_today value=$smarty.now|tiki_date_format:"%m"}

					{if $cell[w][d].focus}
						{cycle values="calodd,caleven" print=false}
					{else}
						{cycle values="caldark" print=false}
					{/if}
					<td class="{if $cell[w][d].day eq $smarty.session.CalendarFocusDate}calfocuson{else}{cycle advance=false}{/if}{if isset($cell[w][d].items[0]) and ($cell[w][d].items[0].modifiable eq "y" || $cell[w][d].items[0].visible eq 'y')} focus{/if}" width="14%" style="text-align:center; font-size:0.8em;">

						{if isset($cell[w][d].items[0])}
							{assign var=over value=$cell[w][d].items[0].over}{else}{assign var=over value=""}
						{/if}
						{if $month_cursor neq $focusmonth }
							<span style="color:lightgrey">{$day_cursor}</span>
						{elseif isset($cell[w][d].items[0]) and ($cell[w][d].items[0].modifiable eq "y" || $cell[w][d].items[0].visible eq 'y')}
							<a style="text-decoration: underline; font-weight: bold" href="{$myurl}?todate={$cell[w][d].day}&amp;viewmode=week" {if $prefs.calendar_sticky_popup eq "y" and $cell[w][d].items[0].calitemId}{popup sticky=true fullhtml="1" text=$over|escape:"javascript"|escape:"html"}
								{else}
									{popup fullhtml="1" text=$over|escape:"javascript"|escape:"html"}
								{/if}
								>
								{$day_cursor}
							</a>
						{else}
							{$day_cursor}
						{/if}

					</td>
				{/section}
			</tr>
		{/section}
	</table>
{/if}
{/tikimodule}
{/if}

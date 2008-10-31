{title admpage="calendar"}{tr}Admin Calendars{/tr}{/title}

{if $calendarId}
	<div class="navbar">
		{button _text="{tr}Create Calendar{/tr}" href="tiki-admin_calendars.php?show=mod"}
	</div>
{/if}

{if $prefs.feature_tabs eq 'y'}
	{cycle name=tabs values="1,2,3" print=false advance=false reset=true}
	<div class="tabs">
		 <span id="tab{cycle name=tabs advance=false assign=tabi}{$tabi}" class="tabmark"><a href="javascript:tikitabs({cycle name=tabs},3);">{tr}List of Calendars{/tr}</a></span>
		 <span id="tab{cycle name=tabs advance=false assign=tabi}{$tabi}" class="tabmark"><a href="javascript:tikitabs({cycle name=tabs},3);">{if $calendarId}{tr}Edit Calendar{/tr}{else}{tr}Create Calendar{/tr}{/if}</a></span>
	</div>
{/if}

{cycle name=content values="1,2,3" print=false advance=false reset=true}
{* --- tab with list --- *}
<div id="content{cycle name=content assign=focustab}{$focustab}"{if $prefs.feature_tabs eq 'y'} class="tabcontent" style="display:{if $focustab eq $cookietab}block{else}none{/if};"{/if}>
<h2>{tr}List of Calendars{/tr}</h2>
{if count($calendars) gt 0}
{include file='find.tpl' _sort_mode='y'}

<table class="normal">
<tr>
<th><a href="tiki-admin_calendars.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'calendarId_desc'}calendarId_asc{else}calendarId_desc{/if}">{tr}ID{/tr}</a></th>
<th><a href="tiki-admin_calendars.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'name_desc'}name_asc{else}name_desc{/if}">{tr}Name{/tr}</a></th>
<th><a href="tiki-admin_calendars.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'customlocations_desc'}customlocations_asc{else}customlocations_desc{/if}">{tr}Loc{/tr}</a></th>
<th><a href="tiki-admin_calendars.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'customparticipants_desc'}customparticipants_asc{else}customparticipants_desc{/if}">{tr}Participants{/tr}</a></th>
<th><a href="tiki-admin_calendars.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'customcategories_desc'}customcategories_asc{else}customcategories_desc{/if}">{tr}Cat{/tr}</a></th>
<th><a href="tiki-admin_calendars.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'customlanguages_desc'}customlanguages_asc{else}customlanguages_desc{/if}">{tr}Lang{/tr}</a></th>
<th><a href="tiki-admin_calendars.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'customurl_desc'}customurl_asc{else}customurl_desc{/if}">{tr}Url{/tr}</a></th>
<th><a href="tiki-admin_calendars.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'custompriorities_desc'}custompriorities_asc{else}custompriorities_desc{/if}">{tr}Prio{/tr}</a></th>
<th><a href="tiki-admin_calendars.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'customsubscription_desc'}customsubscription_asc{else}customsubscription_desc{/if}">{tr}Subscription{/tr}</a></th>
<th><a href="tiki-admin_calendars.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'personal_desc'}personal_asc{else}personal_desc{/if}">{tr}Perso{/tr}</a></th>
<th>&nbsp;</th>
<th>&nbsp;</th>
</tr>
{cycle values="odd,even" print=false}
{foreach key=id item=cal from=$calendars}
<tr class="{cycle}">
<td>{$id}</td>
<td>
	<a class="tablename" href="tiki-admin_calendars.php?calendarId={$id}" title="{tr}Edit{/tr}">{$cal.name|escape}</a>{if $cal.show_calname eq 'y'} {icon _id=layers alt="{tr}Show in popup box{/tr}"}{/if}
</td>
<td>{$cal.customlocations}{if $cal.show_location eq 'y'}{icon _id=layers alt="{tr}Show in popup box{/tr}"}{/if}</td>
<td>{$cal.customparticipants}{if $cal.show_participants eq 'y'}{icon _id=layers alt="{tr}Show in popup box{/tr}"}{/if}</td>
<td>{$cal.customcategories}{if $cal.show_category eq 'y'}{icon _id=layers alt="{tr}Show in popup box{/tr}"}{/if}</td>
<td>{$cal.customlanguages}{if $cal.show_language eq 'y'}{icon _id=layers alt="{tr}Show in popup box{/tr}"}{/if}</td>
<td>{$cal.customurl}{if $cal.show_url eq 'y'}{icon _id=layers alt="{tr}Show in popup box{/tr}"}{/if}</td>
<td>{$cal.custompriorities}</td>
<td>{$cal.customsubscription}</td>
<td>{$cal.personal}</td>
<td>
	<a title="{tr}Permissions{/tr}" class="link" href="tiki-objectpermissions.php?objectName={$cal.name|escape:"url"}&amp;objectType=calendar&amp;permType=calendar&amp;objectId={$id}">{if $cal.individual gt 0}{icon _id='key_active' alt='{tr}Permissions{/tr}'}</a>{$cal.individual}{else}{icon _id='key' alt='{tr}Permissions{/tr}'}</a>{/if}
</td>
<td>
	<a title="{tr}Edit{/tr}" class="link" href="tiki-admin_calendars.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;calendarId={$id}">{icon _id='page_edit'}</a>
	<a title="{tr}View Calendar{/tr}" class="link" href="tiki-calendar.php?calIds[]={$id}">{icon _id='magnifier' alt="{tr}View{/tr}"}</a>
	<a title="{tr}Delete{/tr}" class="link" href="tiki-admin_calendars.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;drop={$id}" title="{tr}Delete{/tr}">{icon _id='cross' alt='{tr}Delete{/tr}'}</a>
	<a title="{tr}Add Event{/tr}" class="link" href="tiki-calendar_edit_item.php?calendarId={$id}">{icon _id='add' alt="{tr}Add Event{/tr}"}</a>
</td>
</tr>
{/foreach}
</table>
<br />

{pagination_links cant=$cant step=$maxRecords offset=$offset}{/pagination_links}

{else}
<b>{tr}No records found{/tr}</b>
{/if}
</div>

{* --- tab with form --- *}
<div id="content{cycle name=content assign=focustab}{$focustab}"{if $prefs.feature_tabs eq 'y'} class="tabcontent" style="display:{if $focustab eq $cookietab}block{else}none{/if};{/if}">
<h2>{tr}Create/Edit Calendars{/tr}</h2>

<form action="tiki-admin_calendars.php" method="post">
<input type="hidden" name="calendarId" value="{$calendarId|escape}" />
<table class="normal">
{if $tiki_p_view_categories eq 'y'}
{include file=categorize.tpl}
{/if}
<tr class="formcolor"><td>{tr}Name{/tr}:</td><td><input type="text" name="name" value="{$name|escape}" />
{tr}Show in popup box{/tr}
<input type="checkbox" name="show[calname]" value="on"{if $show_calname eq 'y'} checked="checked"{/if} />
</td></tr>
<tr class="formcolor"><td>{tr}Description{/tr}:</td><td><textarea name="description" rows="5" wrap="virtual" style="width:100%;">{$description|escape}</textarea>
<br />
{tr}Show in popup box{/tr}
<input type="checkbox" name="show[description]" value="on"{if $show_description eq 'y'} checked="checked"{/if} />
</td></tr>
<tr class="formcolor"><td>{tr}Custom Locations{/tr}:</td><td>
<select name="customlocations">
<option value='y' {if $customlocations eq 'y'}selected="selected"{/if}>{tr}Yes{/tr}</option>
<option value='n' {if $customlocations eq 'n'}selected="selected"{/if}>{tr}No{/tr}</option>
</select>
{tr}Show in popup box{/tr}
<input type="checkbox" name="show[location]" value="on"{if $show_location eq 'y'} checked="checked"{/if} />
</td></tr>
<tr class="formcolor"><td>{tr}Custom Participants{/tr}:</td><td>
<select name="customparticipants">
<option value='y' {if $customparticipants eq 'y'}selected="selected"{/if}>{tr}Yes{/tr}</option>
<option value='n' {if $customparticipants eq 'n'}selected="selected"{/if}>{tr}No{/tr}</option>
</select>
{tr}Show in popup box{/tr}
<input type="checkbox" name="show[participants]" value="on"{if $show_participants eq 'y'} checked="checked"{/if} />
</td></tr>
<tr class="formcolor"><td>{tr}Custom Categories{/tr}:</td><td>
<select name="customcategories">
<option value='y' {if $customcategories eq 'y'}selected="selected"{/if}>{tr}Yes{/tr}</option>
<option value='n' {if $customcategories eq 'n'}selected="selected"{/if}>{tr}No{/tr}</option>
</select>
{tr}Show in popup box{/tr}
<input type="checkbox" name="show[category]" value="on"{if $show_category eq 'y'} checked="checked"{/if} />
</td></tr>
<tr class="formcolor"><td>{tr}Custom Languages{/tr}:</td><td>
<select name="customlanguages">
<option value='y' {if $customlanguages eq 'y'}selected="selected"{/if}>{tr}Yes{/tr}</option>
<option value='n' {if $customlanguages eq 'n'}selected="selected"{/if}>{tr}No{/tr}</option>
</select>
{tr}Show in popup box{/tr}
<input type="checkbox" name="show[language]" value="on"{if $show_language eq 'y'} checked="checked"{/if} />
</td></tr>
<tr class="formcolor"><td>{tr}Custom URL{/tr}:</td><td>
<select name="options[customurl]">
<option value='y' {if $customurl eq 'y'}selected="selected"{/if}>{tr}Yes{/tr}</option>
<option value='n' {if $customurl eq 'n'}selected="selected"{/if}>{tr}No{/tr}</option>
</select>
{tr}Show in popup box{/tr}
<input type="checkbox" name="show[url]" value="on"{if $show_url eq 'y'} checked="checked"{/if} />
</td></tr>
{if $prefs.feature_newsletters eq 'y'}
<tr class="formcolor"><td>{tr}Custom Subscription List{/tr}:</td><td>
<select name="customsubscription">
<option value='y' {if $customsubscription eq 'y'}selected="selected"{/if}>{tr}Yes{/tr}</option>
<option value='n' {if $customsubscription eq 'n'}selected="selected"{/if}>{tr}No{/tr}</option>
</select>
</td></tr>
{/if}
<tr class="formcolor"><td>{tr}Custom Priorities{/tr}:</td><td>
<select name="custompriorities">
<option value='y' {if $custompriorities eq 'y'}selected="selected"{/if}>{tr}Yes{/tr}</option>
<option value='n' {if $custompriorities eq 'n'}selected="selected"{/if}>{tr}No{/tr}</option>
</select>
</td></tr>
<tr class="formcolor"><td>{tr}Personal Calendar{/tr}:</td><td>
<select name="personal">
<option value='y' {if $personal eq 'y'}selected="selected"{/if}>{tr}Yes{/tr}</option>
<option value='n' {if $personal eq 'n'}selected="selected"{/if}>{tr}No{/tr}</option>
</select>
</td></tr>
<tr class="formcolor"><td>{tr}Start of day{/tr}:</td><td>
<select name="startday_Hour">{foreach item=h from=$hours}<option value="{$h}"{if $h eq $startday} selected="selected"{/if}>{$h}</option>{/foreach}</select>{tr}h{/tr}
</td></tr>
<tr class="formcolor"><td>{tr}End of day{/tr}:</td><td>
<select name="endday_Hour">{foreach item=h from=$hours}<option value="{$h}"{if $h eq $endday} selected="selected"{/if}>{$h}</option>{/foreach}</select>{tr}h{/tr}
</td></tr>
<tr class="formcolor"><td>{tr}Custom foreground color{/tr}:</td><td>
<input type="text" name="options[customfgcolor]" value="{$customfgcolor}" size="6" />
</td></tr>
<tr class="formcolor"><td>{tr}Custom background color{/tr}:</td><td>
<input type="text" name="options[custombgcolor]" value="{$custombgcolor}" size="6" />
</td></tr>
<tr class="formcolor"><td>{tr}Status{/tr}</td><td>
<select name="customstatus">
<option value='y' {if $info.customstatus ne 'n'}selected="selected"{/if}>{tr}Yes{/tr}</option>
<option value='n' {if $info.customstatus eq 'n'}selected="selected"{/if}>{tr}No{/tr}</option>
</select><br />
{tr}Default event status{/tr}:
{html_options name='options[defaulteventstatus]' options=$eventstatus selected=$defaulteventstatus}<br />
{tr}Show in popup box{/tr}<input type="checkbox" name="show[status]" value="on"{if $info.show_status eq 'y'} checked="checked"{/if} />
{tr}Show in calendar view{/tr}<input type="checkbox" name="show[status_calview]" value="on"{if $info.show_status_calview ne 'n'} checked="checked"{/if} />
</td></tr>
<tr class="formcolor">
<td>{tr}Group of users alerted when calendar event is modified{/tr}</td>
<td>
<select id="groupforAlert" name="groupforAlert">
<option value="">&nbsp;</option>
{foreach key=k item=i from=$groupforAlertList}
<option value="{$k}" {$i}>{$k}</option>
{/foreach}
</select></td>
</tr>
<tr class="formcolor">
<td>{tr}Allows to select each user for small groups{/tr}</td>
<td>
<input type="checkbox" name="showeachuser" {if $showeachuser eq 'y'}checked="checked"{/if}></td>
<td>
</tr>

<tr class="formcolor"><td>&nbsp;</td><td><input type="submit" name="save" value="{tr}Save{/tr}" /></td></tr>
</table>
<br />
{if $calendarId}{$name} : {/if}
{tr}Delete events older than:{/tr} <input type="text" name="days" value="0"/> {tr}days{/tr} <input type="submit" name="clean" value="{tr}Delete{/tr}" />
</form>

</div>

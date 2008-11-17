{title help="Content+Templates"}{tr}Admin templates{/tr}{/title}

{remarksbox type="tip" title="Tip"}Use the Administration page of each enabled feature to allow the use of content templates.{/remarksbox}

{if $preview eq 'y'}
	<h2>{tr}Preview{/tr}</h2>
	<div class="wikitext">{$parsed}</div>
{/if}

{if $templateId > 0}
	<h2>{tr}Edit this template:{/tr} {$info.name}</h2>
	<a href="tiki-admin_content_templates.php">{tr}Create new template{/tr}</a>
{else}
	<h2>{tr}Create new template{/tr}</h2>
{/if}

<form action="tiki-admin_content_templates.php" method="post">
{if $prefs.feature_wysiwyg eq 'y' and $prefs.wysiwyg_optional eq 'y'}
	<div class="navbar">
		{if $wysiwyg ne 'y'}
			{button href="?templateId=$templateId&amp;wysiwyg=y" _text="{tr}Use wysiwyg editor{/tr}"}
		{else}
			{button href="?templateId=$templateId&amp;wysiwyg=n" _text="{tr}Use normal editor{/tr}"}
		{/if}
	</div>
{/if}

<input type="hidden" name="templateId" value="{$templateId|escape}" />
	<table class="normal">
		<tr>
			<td class="formcolor">{tr}Name{/tr}:</td>
			<td class="formcolor">
				<input type="text" maxlength="255" size="40" name="name" value="{$info.name|escape}" />
			</td>
		</tr>
		<tr>
			<td class="formcolor">{tr}Use in{/tr}:</td>
			<td class="formcolor">
				{if $prefs.feature_cms_templates eq 'y'}
					<input type="checkbox" name="section_cms" {if $info.section_cms eq 'y'}checked="checked"{/if} /> 
					{tr}CMS{/tr} ({tr}Articles{/tr}
					<br />
				{/if}
				{if $prefs.feature_wiki_templates eq 'y'}
					<input type="checkbox" name="section_wiki" {if $info.section_wiki eq 'y'}checked="checked"{/if} />
					{tr}Wiki{/tr}
					<br />
				{/if}
				{if $prefs.feature_newsletters eq 'y'}
					<input type="checkbox" name="section_newsletters" {if $info.section_newsletters eq 'y'}checked="checked"{/if} />
					{tr}Newsletters{/tr}
					<br />
				{/if}
				{if $prefs.feature_events eq 'y'}
					<input type="checkbox" name="section_events" {if $info.section_events eq 'y'}checked="checked"{/if} />
					{tr}Events{/tr}
					<br />
				{/if}
				{if $prefs.feature_html_pages eq 'y'}
					<input type="checkbox" name="section_html" {if $info.section_html eq 'y'}checked="checked"{/if} />
					{tr}HTML pages{/tr}
					<br />
				{/if}
				{if ($prefs.feature_cms_templates ne 'y') and ($prefs.feature_wiki_templates ne 'y') and ($prefs.feature_newsletters ne 'y') and ($prefs.feature_events ne 'y') and ($prefs.feature_html_pages ne 'y')}
					{tr}No features are configured to use templates.{/tr}
				{/if}
			</td>
		</tr>

		{if $wysiwyg ne 'y' and $prefs.quicktags_over_textarea eq 'y'}
			<tr>
				<td class="formcolor"><label>{tr}Quicktags{/tr}</label></td>
				<td class="formcolor">
					{include file=tiki-edit_help_tool.tpl area_name='editwiki'}
				</td>
			</tr>
		{/if}

		<tr>
			{assign var=area_name value="editwiki"}
			{if $wysiwyg ne 'y'}
				<td class="formcolor">{tr}Template{/tr}:
					<br />
					<br />
					{tr}Edit{/tr}:
					<br />
					<br />
					{include file="textareasize.tpl" area_name='editwiki' formId='editpageform' ToolbarSet='Tiki'}
					<br />
					<br />
					{if $prefs.quicktags_over_textarea neq 'y'}
						{include file=tiki-edit_help_tool.tpl area_name='editwiki'}
					{/if}  
				</td>
				<td class="formcolor">
					<textarea id='editwiki' class="wikiedit" name="content" rows="{$rows}" cols="{$cols}" style="WIDTH: 100%;">{$info.content|escape}</textarea>
					<input type="hidden" name="rows" value="{$rows}"/>
					<input type="hidden" name="cols" value="{$cols}"/>
			{else}
				<td colspan="2">
					{editform Meat=$info.content InstanceName='content' ToolbarSet="Tiki"}
			{/if}
			</td>
		</tr>

		<tr>
			<td class="formcolor">&nbsp;</td>
			<td class="formcolor">
				<input type="submit" name="save" value="{tr}Save{/tr}" />
				<input type="submit" name="preview" value="{tr}Preview{/tr}" />
			</td>
		</tr>
	</table>
</form>

<hr />

<h2>{tr}Templates{/tr}</h2>
<div  align="center">
	{if $channels or ($find ne '')}
		{include file='find.tpl' _sort_mode='y'}
	{/if}
	<br />
	<table class="normal">
		<tr>
			<th>
				<a href="tiki-admin_content_templates.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'name_desc'}name_asc{else}name_desc{/if}">{tr}Name{/tr}</a>
			</th>
			<th>
				<a href="tiki-admin_content_templates.php?offset={$offset}&amp;sort_mode={if $sort_mode eq 'created_desc'}created_asc{else}created_desc{/if}">{tr}Last Modified{/tr}</a>
			</th>
			<th>{tr}Sections{/tr}</th>
			<th>{tr}Action{/tr}</th>
		</tr>
		{cycle values="odd,even" print=false advance=false}
		{section name=user loop=$channels}
			<tr>
				<td class="{cycle advance=false}">{$channels[user].name}</td>
				<td class="{cycle advance=false}">{$channels[user].created|tiki_short_datetime}</td>
				<td class="{cycle advance=false}">
					{if count($channels[user].sections) == 0}{tr}Visible in no sections{/tr}{/if}
					{section name=ix loop=$channels[user].sections}
						{$channels[user].sections[ix]} 
						<a title="{tr}Delete{/tr}" class="link" href="tiki-admin_content_templates.php?removesection={$channels[user].sections[ix]}&amp;rtemplateId={$channels[user].templateId}" 
							{icon _id='cross' alt='{tr}Delete{/tr}'}
						</a>
						&nbsp;&nbsp;
					{/section}
				</td>
				<td class="{cycle advance=true}">
					&nbsp;&nbsp;
					<a title="{tr}Edit{/tr}" class="link" href="tiki-admin_content_templates.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;templateId={$channels[user].templateId}">
						{icon _id='page_edit'}
					</a> 
					&nbsp;
					<a title="{tr}Delete{/tr}" class="link" href="tiki-admin_content_templates.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;remove={$channels[user].templateId}" >
						{icon _id='cross' alt='{tr}Delete{/tr}'}
					</a>
				</td>
			</tr>
		{sectionelse}
			<tr>
				<td colspan="4" class="odd">
					{tr}No records found{/tr}
				</td>
			</tr>
		{/section}
	</table>

	<div class="mini">
		{if $prev_offset >= 0}
			[<a class="prevnext" href="tiki-admin_content_templates.php?find={$find}&amp;offset={$prev_offset}&amp;sort_mode={$sort_mode}">{tr}Prev{/tr}</a>]&nbsp;
		{/if}
		{tr}Page{/tr}: {$actual_page}/{$cant_pages}
		{if $next_offset >= 0}
			&nbsp;
			[<a class="prevnext" href="tiki-admin_content_templates.php?find={$find}&amp;offset={$next_offset}&amp;sort_mode={$sort_mode}">{tr}Next{/tr}</a>]
		{/if}
		{if $prefs.direct_pagination eq 'y'}
			<br />
			{section loop=$cant_pages name=foo}
				{assign var=selector_offset value=$smarty.section.foo.index|times:$prefs.maxRecords}
				<a class="prevnext" href="tiki-admin_content_templates.php?find={$find}&amp;offset={$selector_offset}&amp;sort_mode={$sort_mode}">
				{$smarty.section.foo.index_next}</a>
				&nbsp;
			{/section}
		{/if}
	</div>
</div>

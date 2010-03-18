{* $Id$ *}

{remarksbox type="tip" title="{tr}Tip{/tr}"}
	{tr}To add/remove blogs, go to "Create/Edit Blog" under "Blogs" on the application menu, or{/tr} <a class="rbox-link" href="tiki-edit_blog.php">{tr}Click Here{/tr}</a>.
{/remarksbox}

<form action="tiki-admin.php?page=blogs" method="post">
	<div class="heading input_submit_container" style="text-align: right">
		<input type="submit" value="{tr}Change preferences{/tr}" />
	</div>

	{tabset name="admin_blogs"}
		{tab name="{tr}General Settings{/tr}"}
			{preference name=home_blog}
			<fieldset>
				<legend>
					{tr}Features{/tr}{help url="Blog+Config"}
				</legend>
				<input type="hidden" name="blogfeatures" />
				{preference name=feature_blog_rankings}
				{preference name=blog_spellcheck}
				{preference name=feature_blog_heading}

				{if $prefs.feature_categories eq 'y'}
					<div class="adminoptionbox">
						<div class="adminoptionlabel">
							<label for="blog_mandatory_category"> {tr}Force and limit categorization to within subtree of{/tr}:</label>
							<select name="feature_blog_mandatory_category" id="blog_mandatory_category">
								<option value="-1" {if $prefs.feature_blog_mandatory_category eq -1 or $prefs.feature_blog_mandatory_category eq ''}selected="selected"{/if}>{tr}None{/tr}</option>
								<option value="0" {if $prefs.feature_blog_mandatory_category eq 0}selected="selected"{/if}>{tr}All{/tr}</option>
								{section name=ix loop=$catree}
									<option value="{$catree[ix].categId|escape}" {if $catree[ix].categId eq $prefs.feature_blog_mandatory_category}selected="selected"{/if}>{$catree[ix].categpath}</option>
								{/section}
							</select>
						</div>
					</div>
				{/if}
			</fieldset>

			<fieldset>
				<legend>{tr}Comments{/tr}</legend>
				<input type="hidden" name="blogcomprefs" />
				{preference name=feature_blog_comments}
				{preference name=feature_blogposts_comments}
				{preference name=blog_comments_per_page}
				{preference name=blog_comments_default_ordering}
			</fieldset>

			<fieldset>
				<legend>
					{tr}Trackback pings{/tr}{help url="Blog#About_Trackback"}
				</legend>
				{preference name=feature_trackbackpings}
				{preference name=feature_blogposts_pings}
			</fieldset>

			<fieldset>
				<legend>
					{tr}Sharing on social networks{/tr}{help url="Blog#Sharing_Social_Networks"}
				</legend>
				{preference name=feature_blog_sharethis}
				<div class="adminoptionboxchild" id="feature_blog_sharethis_childcontainer">
					{preference name=blog_sharethis_publisher}
				</div>
			</fieldset>

		{/tab}
	
		{tab name="{tr}Blogs Listings{/tr}"}
			<input type="hidden" name="bloglistconf" />
			{preference name=blog_list_order}

			<fieldset>
				<legend>{tr}Select which items to display when listing blogs{/tr}:</legend>
				{preference name=blog_list_title}
				<div class="adminoptionboxchild" id="blog_list_title_childcontainer">
					{preference name=blog_list_title_len}
				</div>
				{preference name=blog_list_description}
				{preference name=blog_list_created}
				{preference name=blog_list_lastmodif}
				{preference name=blog_list_user}
				{preference name=blog_list_posts}
				{preference name=blog_list_visits}
				{preference name=blog_list_activity}
			</fieldset>
		{/tab}
	{/tabset}
	<div class="heading input_submit_container" style="text-align: center">
		<input type="submit" value="{tr}Change preferences{/tr}" />
	</div>
</form>

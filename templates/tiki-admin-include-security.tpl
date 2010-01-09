{* $Id$ *}

{remarksbox type="tip" title="{tr}Tip{/tr}"}
	{tr}Please see the <a class='rbox-link' target='tikihelp' href='http://dev.tikiwiki.org/Security'>Security page</a> on Tiki's developer site.{/tr}
	{tr}See <a href="tiki-admin_security.php" title="Security"><strong>Admin &gt; Security Admin</strong></a> for additional security settings{/tr}.
{/remarksbox}

<form class="admin" id="security" name="security" action="tiki-admin.php?page=security" method="post">
	<div class="heading input_submit_container" style="text-align: right">
		<input type="submit" name="security" value="{tr}Apply{/tr}" />
		<input type="reset" name="securityreset" value="{tr}Reset{/tr}" />
	</div>

		<fieldset>
			<legend>{tr}Security{/tr}</legend>
			{preference name=smarty_security}
			{preference name=feature_purifier}
			{preference name=feature_htmlpurifier_output}
		<fieldset>
			<legend>{tr}CSRF Security{/tr}{help url="Security"}</legend>
			<div class="adminoptionbox">
				{tr}Use these options to protect against cross-site request forgeries (CSRF){/tr}.
			</div>
			{preference name=feature_ticketlib}
			{preference name=feature_ticketlib2}
		</fieldset>
	
		<fieldset>
			<legend>{tr}Spam protection{/tr}</legend>
			{preference name=feature_antibot}
			{preference name=feature_wiki_protect_email}
		</fieldset>		
	
		<fieldset>
			<legend>{tr}Category{/tr}</legend>
				{preference name=feature_search_show_forbidden_cat}
				{preference name=feature_category_reinforce}
		</fieldset>		
	
	
	<div class="input_submit_container" style="margin-top: 5px; text-align: center">
		<input type="submit" name="security" value="{tr}Apply{/tr}" />
	</div>
</form>

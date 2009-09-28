{* $Id$ *}

{remarksbox type="tip" title="{tr}Tip{/tr}"}{tr}Please see the <a class='rbox-link' target='tikihelp' href='http://dev.tikiwiki.org/Performance'>Performance page</a> on Tiki's developer site.{/tr}{/remarksbox}

<form class="admin" id="performance" name="performance" action="tiki-admin.php?page=performance" method="post">
	<div class="heading input_submit_container" style="text-align: right">
		<input type="submit" name="performance" value="{tr}Apply{/tr}" />
		<input type="reset" name="performancereset" value="{tr}Reset{/tr}" />
	</div>

		<fieldset>
			<legend>{tr}Performance{/tr}</legend>
			{preference name=feature_use_minified_scripts}
			{preference name=cachepages}
			{preference name=cacheimages}
			{preference name=feature_obzip}
			<div class="adminoptionboxchild">
				{if $gzip_handler ne 'none'}
					<div class="highlight" style="margin-left:30px;">
						{tr}Output compression is active.{/tr}
						<br />
						{tr}Compression is handled by{/tr}: {$gzip_handler}.
					</div>
				{/if}
			</div>
		</fieldset>
		
		<fieldset>
			<legend>{tr}Search{/tr}</legend>
			{remarksbox type="tip" title="{tr}Tip{/tr}"}
				{tr}Many search options impact performance. Please see <a href="tiki-admin.php?page=search">Search admin panel</a>.{/tr}
			{/remarksbox}
		</fieldset>
	
	<div class="input_submit_container" style="margin-top: 5px; text-align: center">
		<input type="submit" name="performance" value="{tr}Apply{/tr}" />
	</div>
</form>
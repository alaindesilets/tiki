{* $Header: /cvsroot/tikiwiki/tiki/templates/tiki-upload_image.tpl,v 1.24 2004-08-26 19:24:17 mose Exp $ *}
<a href="tiki-upload_image.php?galleryId={$galleryId}" class="pagetitle">{tr}Upload Image{/tr}</a><br /><br />
<!--help links-->
{if $feature_help eq 'y'}
<a href="{$helpurl}ImageGallery" target="tikihelp" class="tikihelp" title="{tr}Image Gallery{/tr}">
<img border='0' src='img/icons/help.gif' alt='{tr}help{/tr}' /></a>
{/if}
<!-- links to edit-->
{if $feature_view_tpl eq 'y'}
<a href="tiki-edit_templates.php?template=tiki-upload_image.tpl" target="tikihelp" class="tikihelp" title="{tr}View tpl{/tr}: {tr}Image Gallery tpl{/tr}">
<img border='0' src='img/icons/info.gif' alt='{tr}edit template{/tr}' /></a>
{/if}

<br /><br />
<!--link button-->

{if $galleryId ne ''}
	<a href="tiki-browse_gallery.php?galleryId={$galleryId}" class="linkbut">
{else}
	<a href="tiki-galleries.php" class="linkbut">
{/if}
{tr}Browse gallery{/tr}</a><br /><br />
{if count($galleries) > 0}
	<div align="center">
	<form enctype="multipart/form-data" action="tiki-upload_image.php" method="post">
	<table class="normal">
	<tr>
	<td class="formcolor">{tr}Image Name{/tr}:</td>
	<td class="formcolor">
	<input type="text" size ="50" name="name" /><br/>{tr}or use filename{/tr}: <input type="checkbox" name="use_filename" />
	</td>
	</tr>
	<tr><td class="formcolor">{tr}Image Description{/tr}:</td><td class="formcolor">
	<textarea rows="5" cols="50" name="description"></textarea></td></tr>
	<tr><td class="formcolor">{tr}Gallery{/tr}:</td><td class="formcolor">
	<select name="galleryId">
	{section name=idx loop=$galleries}
	{if ($galleries[idx].individual eq 'n') or ($galleries[idx].individual_tiki_p_upload_images eq 'y')}
	<option  value="{$galleries[idx].id|escape}" {if $galleries[idx].id eq $galleryId}selected="selected"{/if}>{$galleries[idx].name}</option>
	{/if}
	{/section}
	</select>
	</td></tr>
{include file=categorize.tpl}
	<tr class="formcolor">
	<td  class="formcolor" colspan="2"><b>{tr}Now enter the image URL{/tr}{tr} or upload a local image from your disk{/tr}
	<tr><td class="formcolor">URL:</td><td class="formcolor"><input size="50" type="text" name="url" /></td></tr>
	<tr>
	<td class="formcolor">{tr}Upload from disk{/tr}:</td><td class="formcolor">
	<input type="hidden" name="MAX_FILE_SIZE" value="10000000" />
	<input size="50" name="userfile1" type="file" />
	</td></tr>
	<tr><td class="formcolor">{tr}Thumbnail (optional, overrides automatic thumbnail generation){/tr}:</td><td class="formcolor">
	<input name="userfile2" size ="50" type="file" />
	</td></tr>
	<tr><td class="formcolor">&nbsp;</td><td class="formcolor"><input type="submit" name="upload" value="{tr}upload{/tr}" /></td></tr>
	</table>
	</form>
	</div>
	{if $show eq 'y'}
	<br />
	<hr/>
	<h2>{tr}Upload successful!{/tr}</h2>
	<h3>{tr}The following image was successfully uploaded{/tr}:</h3>
	<div align="center">
	<img src="{$url_show}?id={$imageId}" alt="{tr}Image ID{/tr}" /><br />
	<b>{tr}Thumbnail{/tr}:</b><br />
	<img src="{$url_show}?id={$imageId}&amp;thumb=1" alt="{tr}Image ID thumb{/tr}" /><br /><br />
	<div class="wikitext">
	{tr}You can view this image in your browser using{/tr}: <a class="link" href="{$url_browse}?imageId={$imageId}">{$url_browse}?imageId={$imageId}</a><br /><br />
	{tr}You can include the image in an Wiki page using{/tr}:  <form><textarea rows="3" cols="60" style="width: 90%">{literal}{{/literal}img src={$url_show}?id={$imageId}{literal}}{/literal}</textarea></form>
	</div>
	</div>
	{/if}
{else}
	{tr}You have to create a gallery first!{/tr}
{/if}



{if $feature_help eq "y"}
<div class="simplebox">{tr}Tip{/tr}: {tr}to add/remove image galleries, go to "Image Galleries" on the application menu, or{/tr} <a class="link" href="tiki-galleries.php">{tr}click here{/tr}</a>.</div><br />
{/if}
<div class="cbox">
<div class="cbox-title">{tr}Image galleries{/tr}</div>
<div class="cbox-data">
<div class="simplebox">
<form action="tiki-admin.php?page=gal" method="post">
<table class="admin">
<tr class="form"><td><label>{tr}Home Gallery (main gallery){/tr}</label></td><td>
<select name="home_gallery">
{section name=ix loop=$galleries}
<option value="{$galleries[ix].galleryId|escape}" {if $galleries[ix].galleryId eq $home_gallery}selected="selected"{/if}>{$galleries[ix].name|truncate:20:"...":true}</option>
{/section}
</select>
<td><input type="submit" name="galset" value="{tr}ok{/tr}" /></td></tr>
</table>
</form>
</div>

<div class="simplebox">
{tr}Galleries features{/tr}<br />
<form action="tiki-admin.php?page=gal" method="post">
    <table class="admin">
    <tr class="form"><td><label>{tr}Rankings{/tr}:</label></td><td><input type="checkbox" name="feature_gal_rankings" {if $feature_gal_rankings eq 'y'}checked="checked"{/if}/></td></tr>
    <tr class="form"><td><label>{tr}Comments{/tr}:</label></td><td><input type="checkbox" name="feature_image_galleries_comments" {if $feature_image_galleries_comments eq 'y'}checked="checked"{/if}/></td></tr>
    <tr class="form"><td><label>{tr}Use database to store images{/tr}:</label></td><td><input type="radio" name="gal_use_db" value="y" {if $gal_use_db eq 'y'}checked="checked"{/if}/></td></tr>
    <tr class="form"><td><label>{tr}Use a directory to store images{/tr}:</label></td><td><input type="radio" name="gal_use_db" value="n" {if $gal_use_db eq 'n'}checked="checked"{/if}/> <label>{tr}Directory path{/tr}:</label><br /><input type="text" name="gal_use_dir" value="{$gal_use_dir|escape}" size="50" /> </td></tr>
    <tr class="form"><td><label>{tr}Library to use for processing images{/tr}:</label></td><td><input type="radio" name="gal_use_lib" value="gd" {if $gal_use_lib ne 'imagick'}checked="checked"{/if}/>GD: {$gdlib}</td></tr>
    <tr class="form"><td></td><td><input type="radio" name="gal_use_lib" value="imagick" {if $gal_use_lib eq 'imagick'}checked="checked"{/if}/>Imagick: {$imagicklib}</td></tr>
    <tr class="form"><td><label>{tr}Uploaded image names must match regex{/tr}:</label></td><td><input type="text" name="gal_match_regex" value="{$gal_match_regex|escape}"/></td></tr>
    <tr class="form"><td><label>{tr}Uploaded image names cannot match regex{/tr}:</label></td><td><input type="text" name="gal_nmatch_regex" value="{$gal_nmatch_regex|escape}"/></td></tr>
    <tr><td colspan="2" class="button"><input type="submit" name="galfeatures" value="{tr}Set features{/tr}" /></td></tr>    
    </table>
</form>
</div>
<div class="simplebox">
<a class="link" href="tiki-admin.php?page=gal&amp;rmvorphimg=1">{tr}Remove images in the system gallery not being used in Wiki pages, articles or blog posts{/tr}</a>
</div>
  <div class="simplebox">
	{tr}Gallery listing configuration{/tr}
	<form method="post" action="tiki-admin.php?page=gal">
	<table class="admin">
	<tr class="form">
		<td><label>{tr}Name{/tr}</label></td>
		<td><input type="checkbox" name="gal_list_name" {if $gal_list_name eq 'y'}checked="checked"{/if} /></td>
	</tr>
	<tr class="form">
		<td><label>{tr}Description{/tr}</label></td>
		<td><input type="checkbox" name="gal_list_description" {if $gal_list_description eq 'y'}checked="checked"{/if} /></td>
	</tr>
	<tr class="form">
		<td><label>{tr}Created{/tr}</label></td>
		<td><input type="checkbox" name="gal_list_created" {if $gal_list_created eq 'y'}checked="checked"{/if} /></td>
	</tr>
	<tr class="form">
		<td><label>{tr}Last modified{/tr}</label></td>
		<td><input type="checkbox" name="gal_list_lastmodif" {if $gal_list_lastmodif eq 'y'}checked="checked"{/if} /></td>
	</tr>
	<tr class="form">
		<td><label>{tr}User{/tr}</label></td>
		<td><input type="checkbox" name="gal_list_user" {if $gal_list_user eq 'y'}checked="checked"{/if} /></td>
	</tr>
	<tr class="form">
		<td><label>{tr}Images{/tr}</label></td>
		<td><input type="checkbox" name="gal_list_imgs" {if $gal_list_imgs eq 'y'}checked="checked"{/if} /></td>
	</tr>
	<tr class="form">
		<td><label>{tr}Visits{/tr}</label></td>
		<td><input type="checkbox" name="gal_list_visits" {if $gal_list_visits eq 'y'}checked="checked"{/if} /></td>
	</tr>
	<tr><td colspan="2" class="button"><input type="submit" name="imagegallistprefs" value="{tr}Change preferences{/tr}" /></td></tr>
	</table>	
	</form>	
	</div>

    <div class="simplebox">
    {tr}Image galleries comments settings{/tr}
    <form method="post" action="tiki-admin.php?page=gal">
    <table class="admin">
    <tr class="form"><td><label>{tr}Default number of comments per page{/tr}: </label></td><td><input size="5" type="text" name="image_galleries_comments_per_page" value="{$image_galleries_comments_per_page|escape}" /></td></tr>
    <tr class="form"><td><label>{tr}Comments default ordering{/tr}</label>
    </td><td>
    <select name="image_galleries_comments_default_order">
    <option value="commentDate_desc" {if $image_galleries_comments_default_order eq 'commentDate_desc'}selected="selected"{/if}>{tr}Newest first{/tr}</option>
		<option value="commentDate_asc" {if $image_galleries_comments_default_order eq 'commentDate_asc'}selected="selected"{/if}>{tr}Oldest first{/tr}</option>
    <option value="points_desc" {if $image_galleries_comments_default_order eq 'points_desc'}selected="selected"{/if}>{tr}Points{/tr}</option>
    </select>
    </td></tr>
    <tr><td colspan="2" class="button"><input type="submit" name="imagegalcomprefs" value="{tr}Change preferences{/tr}" /></td></tr>
    </table>
    </form>
    </div>
  </div>
</div>

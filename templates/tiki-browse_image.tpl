{if $popup ne ""}
  <script language='Javascript' type='text/javascript'>
	window.resizeTo({$winx},{$winy});
  </script>
{/if}

{if $popup eq ""}
  <a class="pagetitle" href="tiki-browse_image.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;desp={$prevdesp}&amp;galleryId={$galleryId}&amp;imageId={$imageId}">{tr}Browsing Image{/tr}: {$name}</a>
  <br /><br />
    <a class="linkbut" href="tiki-browse_gallery.php?galleryId={$galleryId}">{tr}return to gallery{/tr}</a>
    {if $tiki_p_admin_galleries eq 'y' or ($user and $user eq $owner)}
      <a class="linkbut" href="tiki-edit_image.php?galleryId={$galleryId}&amp;edit={$imageId}">{tr}edit image{/tr}</a>
    {/if}
{/if}  


{if $popup ne "" }
  <div style="vertical-align: middle" height="{$winy}" align="center">
		{if $imageId ne $firstId}
			<a href="tiki-browse_image.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;desp=0&amp;galleryId={$galleryId}&amp;imageId={$firstId}{if $itype=='s'}&amp;scaled&amp;scalesize={$scalesize}{/if}&amp;popup={$popup}" class="gallink"><img src='img/icons2/nav_first.gif' border='0' alt='{tr}first image{/tr}' title='{tr}first image{/tr}' /></a>    
		{/if}
    {if $scaleinfo.prevscale}
    	<a href="tiki-browse_image.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;desp={$prevdesp}&amp;galleryId={$galleryId}&amp;imageId={$imageId}&amp;scaled&amp;scalesize={$scaleinfo.prevscale}&amp;popup={$popup}" class="gallink"><img src='img/icons2/down.gif' border='0' alt='{tr}smaller{/tr}' title='{tr}smaller{/tr}' /></a>
    {/if}
    {if $itype ne 'o'}
    	<a href="tiki-browse_image.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;desp={$prevdesp}&amp;galleryId={$galleryId}&amp;imageId={$imageId}&amp;popup={$popup}" class="gallink"><img src='img/icons2/nav_dot.gif' border='0' alt='{tr}original size{/tr}' title='{tr}original size{/tr}' /></a>
    {/if}
    {if $scaleinfo.nextscale}
    	<a href="tiki-browse_image.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;desp={$prevdesp}&amp;galleryId={$galleryId}&amp;imageId={$imageId}&amp;scaled&amp;scalesize={$scaleinfo.nextscale}&amp;popup={$popup}" class="gallink"><img src='img/icons2/up.gif' border='0' alt='{tr}bigger{/tr}' title='{tr}bigger{/tr}' /></a>
    {/if}

    {if $previmg ne '' && $desp ne 0}
    	<a href="tiki-browse_image.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;desp={$prevdesp}&amp;galleryId={$galleryId}&amp;imageId={$previmg}{if $itype=='s'}&amp;scaled&amp;xsize={$sxsize}&amp;ysize={$sysize}{/if}&amp;popup={$popup}" class="gallink"><img src='img/icons2/nav_dot_right.gif' border='0' alt='{tr}prev image{/tr}' title='{tr}prev image{/tr}' /></a>
    {/if}
    {if $nextimg ne ''}
    	<a href="tiki-browse_image.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;desp={$nextdesp}&amp;galleryId={$galleryId}&amp;imageId={$nextimg}{if $itype=='s'}&amp;scaled&amp;xsize={$sxsize}&amp;ysize={$sysize}{/if}&amp;popup={$popup}" class="gallink"><img src='img/icons2/nav_dot_left.gif' border='0' alt='{tr}next image{/tr}' title='{tr}next image{/tr}' /></a>
    {/if}
		{if $imageId ne $lastId}
    	<a href="tiki-browse_image.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;desp={$lastdesp}&amp;galleryId={$galleryId}&amp;imageId={$lastId}{if $itype=='s'}&amp;scaled&amp;xsize={$sxsize}&amp;ysize={$sysize}{/if}&amp;popup={$popup}" class="gallink"><img src='img/icons2/nav_last.gif' border='0' alt='{tr}last image{/tr}' title='{tr}last image{/tr}' /></a>    
		{/if}
  </div>
  <br />
{/if}   

  <div class="showimage" {if ($popup) }style="height: 400px"{/if}>
    {if $itype eq 'o'}
    	<img alt="image" src="show_image.php?id={$imageId}" />
    {else}
	    <a href="tiki-browse_image.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;desp={$desp}&amp;galleryId={$galleryId}&amp;imageId={$imageId}&amp;scalesize={$scaleinfo.nextscale}&amp;scaled" title="{tr}Click to zoom{/tr}">
	    <img alt="image" src="show_image.php?id={$imageId}&amp;scaled&amp;scalesize={$scalesize}" /></a>
    {/if}
  </div>
  
{if $popup eq ""}
	<div align="center" >
			{if $imageId ne $firstId}
				<a href="tiki-browse_image.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;desp=0&amp;galleryId={$galleryId}&amp;imageId={$firstId}{if $itype=='s'}&amp;scaled&amp;scalesize={$scalesize}{/if}" class="gallink"><img src='img/icons2/nav_first.gif' border='0' alt='{tr}first image{/tr}' title='{tr}first image{/tr}' /></a>
			{/if}
	    {if $scaleinfo.prevscale}
	    	<a href="tiki-browse_image.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;desp={$desp}&amp;galleryId={$galleryId}&amp;imageId={$imageId}&amp;scaled&amp;scalesize={$scaleinfo.prevscale}" class="gallink"><img src='img/icons2/down.gif' border='0' alt='{tr}smaller{/tr}' title='{tr}smaller{/tr}' /></a>
	    {/if}
	    {if $itype ne 'o'}
	    	<a href="tiki-browse_image.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;desp={$desp}&amp;galleryId={$galleryId}&amp;imageId={$imageId}" class="gallink"><img src='img/icons2/nav_dot.gif' border='0' alt='{tr}original size{/tr}' title='{tr}original size{/tr}' /></a>
	    {/if}
	    {if $scaleinfo.nextscale}
	    	<a href="tiki-browse_image.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;desp={$desp}&amp;galleryId={$galleryId}&amp;imageId={$imageId}&amp;scaled&amp;scalesize={$scaleinfo.nextscale}" class="gallink"><img src='img/icons2/up.gif' border='0' alt='{tr}bigger{/tr}' title='{tr}bigger{/tr}' /></a>
	    {/if}
	    {if $previmg ne '' && $desp ne 0}
	    	<a href="tiki-browse_image.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;desp={$prevdesp}&amp;galleryId={$galleryId}&amp;imageId={$previmg}{if $itype eq 's'}&amp;scaled&amp;scalesize={$scalesize}{/if}" class="gallink"><img src='img/icons2/nav_dot_right.gif' border='0' alt='{tr}prev image{/tr}' title='{tr}prev image{/tr}' /></a>
	    {/if}
	    <a {jspopup height="$winy" width="$winx" href="tiki-browse_image.php?offset=$offset&amp;sort_mode=$sort_mode&amp;desp=$nextdesp&amp;galleryId=$galleryId&amp;imageId=$imageId&amp;popup=1"} class="gallink"><img src='img/icons2/admin_unhide.gif' border='0' alt='{tr}Popup window{/tr}' title='{tr}popup window{/tr}' /></a>
	    {if $nextimg ne ''}
	    	<a href="tiki-browse_image.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;desp={$nextdesp}&amp;galleryId={$galleryId}&amp;imageId={$nextimg}{if $itype eq 's'}&amp;scaled&amp;scalesize={$scalesize}{/if}" class="gallink"><img src='img/icons2/nav_dot_left.gif' border='0' alt='{tr}next image{/tr}' title='{tr}next image{/tr}' /></a>
	    {/if}
	   	{if $imageId ne $lastId}
				<a href="tiki-browse_image.php?offset={$offset}&amp;sort_mode={$sort_mode}&amp;desp={$lastdesp}&amp;galleryId={$galleryId}&amp;imageId={$lastId}{if $itype=='s'}&amp;scaled&amp;xsize={$sxsize}&amp;ysize={$sysize}{/if}" class="gallink"><img src='img/icons2/nav_last.gif' border='0' alt='{tr}last image{/tr}' title='{tr}last image{/tr}' /></a>    
			{/if}
	</div>
{/if}

  
{if $popup eq ""}
	  <br /><br />
      <table class="normal">
      <tr><td class="odd">{tr}Image Name{/tr}:</td><td class="odd">{$name}</td></tr>
      <tr><td class="even">{tr}Created{/tr}:</td><td class="even">{$created|tiki_long_datetime}</td></tr>
      <tr><td class="odd">{tr}Hits{/tr}:</td><td class="odd">{$hits}</td></tr>
      <tr><td class="even">{tr}Description{/tr}:</td><td class="even">{$description}</td></tr>
      {if $feature_maps eq 'y'}
  		<tr><td class="odd">{tr}Latitude (WGS84/decimal degrees){/tr}:</td><td class="odd">{$lat|escape}</td></tr>
  		<tr><td class="even">{tr}Longitude (WGS84/decimal degrees){/tr}:</td><td class="even">{$lon|escape}</td></tr>
  		{/if}
      <tr><td class="odd">{tr}Author{/tr}:</td><td class="odd">{$image_user}</td></tr>
      {if $tiki_p_admin_galleries eq 'y' or ($user and $user eq $owner)}
        <tr><td class="even">{tr}Move image{/tr}:</td><td class="odd">
        <form action="tiki-browse_image.php" method="post">
        <input type="hidden" name="imageId" value="{$imageId|escape}"/>
        <input type="hidden" name="galleryId" value="{$galleryId|escape}"/>
        <select name="newgalleryId">
          {section name=idx loop=$galleries}
            <option value="{$galleries[idx].id|escape}" {if $galleries[idx].id eq $galleryId}selected="selected"{/if}>{$galleries[idx].name}</option>
          {/section}
        </select>
        <input type="submit" name="move_image" value="{tr}move{/tr}" />
        </form>
        </td></tr>
      {/if}
    </table>
<br /><br />    
  <table class="normal">
  <tr>
  	<td class="even">
  	<small>
    {tr}You can view this image in your browser using{/tr}:<br /><br />
    <a class="gallink" href="{$url_browse}?imageId={$imageId}">{$url_browse}?imageId={$imageId}</a><br />
    </small>
    </td>
  </tr>
  <tr>
    <td class="even">
    <small>
    {tr}You can include the image in an HTML page using one of these lines{/tr}:<br /><br />
    &lt;img src="{$url_show}?id={$imageId}" /&gt;<br />
    &lt;img src="{$url_show}?name={$name|escape}" /&gt;<br />
    </small>
    </td>
  </tr>
  <tr>
    <td class="even">
    <small>
    {tr}You can include the image in a tiki page using one of these lines{/tr}:<br /><br />
    {literal}{{/literal}img src={$url_show}?id={$imageId} {literal}}{/literal}<br />
    {literal}{{/literal}img src={$url_show}?name={$name|escape} {literal}}{/literal}<br />
    </small>
    </td>
  </tr>
  </table>
{/if}  


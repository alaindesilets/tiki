<!-- START of {$smarty.template} -->{* $Id$ *}
<!DOCTYPE html 
	PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{if !empty($pageLang)}{$pageLang}{else}{$prefs.language}{/if}" lang="{if !empty($pageLang)}{$pageLang}{else}{$prefs.language}{/if}">
	<head>
{include file="header.tpl"}
	</head>
	<body{if isset($section) and $section eq 'wiki page' and $prefs.user_dbl eq 'y' and $dblclickedit eq 'y' and $tiki_p_edit eq 'y'} ondblclick="location.href='tiki-editpage.php?page={$page|escape:"url"}';"{/if} onload="{if $prefs.feature_tabs eq 'y'}tikitabs({if $cookietab neq ''}{$cookietab}{else}1{/if},50);{/if}{if $msgError} javascript:location.hash='msgError'{/if}"{if $section or $smarty.session.fullscreen eq 'y'} class="{if $section}tiki_{$section}{/if}{if $smarty.session.fullscreen eq 'y'} fullscreen{/if}"{/if}>

<div id="tiki-clean">
  {section name=ix loop=$pages}
    {if $prefs.feature_page_title ne 'n'}<h{math equation="x+1" x=$pages[ix].h}>{if isset($pages[ix].pos)}{$pages[ix].pos} {/if}{$pages[ix].pageName}</h{math equation="x+1" x=$pages[ix].h}>{/if}
    <div class="wikitext">{$pages[ix].parsed}</div>
  <hr />
  {/section}
</div>
{include file="footer.tpl"}
	</body>
</html><!-- END of {$smarty.template} -->

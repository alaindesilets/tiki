<!-- START of {$smarty.template} -->
<!DOCTYPE html 
     PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
  <base href="{$info.url}" />
	<title>{tr}Cached:{/tr} {$info.url}</title>
  </head>
  <body>
<br />
<div align="center">
<table bgcolor="#EAEAEA"  border="0" cellpadding="0" cellspacing="0">
<tr><th>{tr}URL{/tr}</th><td class="text">{$info.url}</td></tr>
<tr><th>{tr}Cached{/tr}</th><td class="text">{$info.refresh|tiki_long_datetime}</td></tr>
<tr><td class="text" colspan="2"><br />{tr}This is a cached version of the page.{/tr} 
<a class="wikicache" href="{$ggcacheurl}">({tr}Click here to view the Google cache of the page instead.{/tr})</a>
</td></tr>
</table>
</div>
<br />
<div class="cachedpage">
{$info.data}
</div>
</body>
</html><!-- END of {$smarty.template} -->

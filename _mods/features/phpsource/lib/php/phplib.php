<?php
/* $Id: phplib.php,v 1.1 2005-02-27 20:31:21 michael_davey Exp $ */

// Set the static content root differently on php.net
$_SERVER['STATIC_ROOT'] = ($MYSITE == 'http://www.php.net/') ?
                         'http://static.php.net/www.php.net' : '';

// Use class names instead of colors
ini_set('highlight.comment', 'comment');
ini_set('highlight.default', 'default');
ini_set('highlight.keyword', 'keyword');
ini_set('highlight.string',  'string');
ini_set('highlight.html',    'html');

// Highlight PHP code
function highlight_php($code, $return = FALSE)
{
   // Using OB, as highlight_string() only supports
   // returning the result from 4.2.0
   ob_start();
   highlight_string($code);
   $highlighted = ob_get_contents();
   ob_end_clean();

   // This should eventually be a php_syntax_check() call when we move to PHP5
   // But use this ugly hack for now to avoid code snippets with bad syntax screwing up the highlighter 
   if(strstr($highlighted,"include/layout.inc</b>")) $highlighted = "<pre>".htmlentities($code)."</pre>";
 
   // Fix output to use CSS classes and wrap well
   $highlighted = '<div class="phpcode">' . str_replace(
       array(
           '&nbsp;',
           '<br />',
           '<font color="',        // for PHP 4
           '<span style="color: ', // from PHP 5.0.0RC1
           '</font>',
           "\n ",
           '  '
       ),
       array(
           ' ',
           "<br />\n",
           '<span class="',
           '<span class="',
           '</span>',
           "\n&nbsp;",
           '&nbsp; '
       ),
       $highlighted
   ) . '</div>';
  
   if ($return) { return $highlighted; }
   else { echo $highlighted; }
}

/* These functions are only used on the new XHTML 1.0 Strict compatible
   pages, and are used as an experiment, but are going to replace the
   commonHeader and commonFooter functions in the future altogether */
function site_header($title = '', $config = array())
{
   global $EXPL_LANG, $SIDEBAR_DATA, $RSIDEBAR_DATA, $PAGE_COLUMNS;
  
   // Default to empty array if improper parameter passed
   if (!is_array($config)) { $config = array(); }
  
   // String defaults
   $lang_input = $base = $meta = $layout_helper = '';
  
   // Count number of columns for layout. The number identifies
   // the layout precisely, as we have no page having a right
   // sidebar and no left sidebar
   $PAGE_COLUMNS = 1;
   if (!empty($SIDEBAR_DATA))  { $PAGE_COLUMNS++; }
   if (!empty($RSIDEBAR_DATA)) { $PAGE_COLUMNS++; }
  
   // Print out lang and charset headers
   if (!isset($config["lang"]))    { $config["lang"] = "en"; }
   if (!isset($config["charset"])) { $config["charset"] = "ISO-8859-1"; }
   header("Content-type: text/html;charset={$config['charset']}");
   header("Content-language: {$config['lang']}");
  
   if (!empty($title)) { $title = ": $title"; }
  
   // This page should not be indexed by robots
   if (in_array("noindex", $config)) {
       $meta .= "\n <meta name=\"robots\" content=\"noindex\" />";
   }
  
   // Decide on onload event handler
   if (!isset($config['onload'])) {
       $config['onload'] = "runOnLoad();";
   }
  
   // Explicit language setting means that we should put that into the form
   if (isset($EXPL_LANG)) {
       $lang_input = "\n  <input type=\"hidden\" name=\"lang\" value=\"$EXPL_LANG\" />";
   }
  
   // Base href setting for URL shortcuts to work
   if (!empty($_SERVER['BASE_HREF'])) {
       $base = "\n <base href=\"{$_SERVER['BASE_HREF']}\" />";
   }
  
   // Define layout helper in case we need it
   if ($PAGE_COLUMNS > 2) {
       $layout_helper = "<div id=\"layout_{$PAGE_COLUMNS}_helper\">";
   }
  
   // Choose name of mirror site specific CSS file
   $mirror_specific_style = ($_SERVER['STATIC_ROOT'] ? 'phpnet' : 'mirror');
  
   print <<<END_HEADER
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
                     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
 <title>PHP{$title}</title>
 <style type="text/css">
  @import url("http://static.php.net/www.php.net/styles/site.css");
  @import url("http://static.php.net/www.php.net/styles/phpnet.css");<style type="text/css">
  @import url("{$_SERVER['STATIC_ROOT']}/styles/site.css");
  @import url("{$_SERVER['STATIC_ROOT']}/styles/{$mirror_specific_style}.css");

 </style>
 <link rel="shortcut icon" href="{$_SERVER['STATIC_ROOT']}/favicon.ico" />
 <script type="text/javascript" src="{$_SERVER['STATIC_ROOT']}/userprefs.js"></script>$base$meta
</head>
<body onload="{$config['onload']}">

<div id="layout_{$PAGE_COLUMNS}">{$layout_helper}
END_HEADER;

   // Print out left column
   if ($PAGE_COLUMNS > 1) {
       echo "\n <div id=\"leftbar\">\n$SIDEBAR_DATA\n </div>";
   }
  
   // Print out right column
   if ($PAGE_COLUMNS > 2) {
       echo "\n <div id=\"rightbar\">\n$RSIDEBAR_DATA\n </div>";
   }

   // Start main page content
   echo "\n <div id=\"content\">\n";
}

// See the comment for site_header() above
function site_footer($config = array())
{
   global $LAST_UPDATED, $PAGE_COLUMNS;
  
   $stats        = "";
   $viewsource    = (isset($_SERVER['BASE_PAGE']) ?
       "<a href=\"/source.php?url=/{$_SERVER['BASE_PAGE']}\">show source</a> |" :
       "");
   $provider_url  = "#";
   $provider_name = "";
   $mirror_text  = 
       "<a href=\"/mirror.php\">This unofficial mirror</a> is operated at:";
   $last_updated  = strftime("%c %Z", $LAST_UPDATED);
   $layout_helper = ($PAGE_COLUMNS > 2 ? "</div>" : "");
   //$functionsjs  = (in_array("functionsjs", $config) ? "\n<script src=\"" . $_SERVER['STATIC_ROOT'] . '/functions.js" type="text/javascript"></script>' : '');
  
   print <<<END_FOOTER

 </div>
 <div class="cleaner">&nbsp;</div>
{$layout_helper}</div>

</body>
</html>
END_FOOTER;
}

// Print an image for a sized spacer
function spacer($width = 1, $height = 1, $return = FALSE, $align = FALSE, $extras = FALSE)
{
   $function = ($return ? "sprintf" : "printf");
   return $function('<img src="%s/images/spacer.gif" width="%d" ' .
                     'height="%d" border="0" alt=""%s%s />',
       $_SERVER['STATIC_ROOT'],
       $width,
       $height,
       ($align  ? " align=\"$align\" " : ""),
       ($extras ? " $extras" : "")
   );
}

// Resize the image using the output of make_image()
// (considering possible HTML/XHTML image tag endings)
function resize_image($img, $width = 1, $height = 1)
{
   // Drop width and height values from image if available
   $str = preg_replace('!width=\"([0-9]+?)\"!i',  '', $img);
   $str = preg_replace('!height=\"([0-9]+?)\"!i', '', $str);
  
   // Return image with new width and height added
   return preg_replace(
       '!/?>$!',
       sprintf(' height="%s" width="%s" />', $height, $width),
       $str
   );
}

// Return an <img /> tag for a given image file available on the server
function make_image($file, $alt = FALSE, $align = FALSE, $extras = FALSE,
                   $dir = '/images', $border = 0, $addsize = TRUE)
{
   // If no / was provided at the start of $dir, add it
   $webdir = $_SERVER['STATIC_ROOT'] . ($dir{0} == '/' ? '' : '/') . $dir;

   // Get width and height values if possible
   if ($addsize && ($size = @getimagesize($_SERVER['DOCUMENT_ROOT'] . "$dir/$file"))) {
       $sizeparams = ' ' . trim($size[3]);
   } else {
       $sizeparams = '';
   }
  
   // Convert right or left alignment to CSS float,
   // but leave other alignments intact (for now)
   if (in_array($align, array("right", "left"))) {
       $align = ' style="float: ' . $align . ';"';
   } elseif ($align) {
       $align = ' align="' . $align . '"';
   } else {
       $align = '';
   }
  
   // Return with image built up
   return sprintf('<img src="%s/%s" alt="%s"%s%s%s />',
       $webdir,
       $file,
       ($alt    ? $alt : ''),
       $sizeparams,
       $align,
       ($extras ? ' ' . $extras              : '')
   );
   return $image;
}

// Print an <img /> tag out for a given file
function print_image($file, $alt = FALSE, $align = FALSE, $extras = FALSE,
                     $dir = '/images', $border = 0)
{
   echo make_image($file, $alt, $align, $extras, $dir, $border);
}

// Shortcut to usual news image printing (right floating
// image from the news dir with an alt and an URL)
function news_image($URL, $image, $alt)
{
   echo "<a href=\"$URL\">" . make_image("news/$image", $alt, "right") . "</a>";
}

// Return HTML code for a submit button image
function make_submit($file, $alt = FALSE, $align = FALSE, $extras = FALSE,
                     $dir = '/images', $border = 0)
{
   // Get an image without size info and convert the
   // border attribute to use CSS, as border="" is not
   // supported on <input> elements in [X]HTML
   $img = make_image($file, $alt, $align, $extras, $dir, 0, FALSE);
   $img = str_replace(
       "border=\"$border\"",
       "style=\"border: {$border}px;\"",
       $img
   );

   // Return with ready input image
   return '<input type="image"' . substr($img, 4);
}

// Return a hiperlink to something within the site
function make_link ($url, $linktext = FALSE, $target = FALSE, $extras = FALSE)
{
   return sprintf("<a href=\"%s\"%s%s>%s</a>",
       $url,
       ($target  ? ' target="' . $target . '"' : ''),
       ($extras  ? ' ' . $extras              : ''),
       ($linktext ? $linktext                  : $url)
   );
}

// Print a hyperlink to something, within the site
function print_link($url, $linktext = FALSE, $target = FALSE, $extras = FALSE)
{
   echo make_link($url, $linktext, $target, $extras);
}

// make_popup_link()
// return a hyperlink to something, within the site, that pops up a new window
//
function make_popup_link ($url, $linktext=false, $target=false, $windowprops="", $extras=false) {
   return sprintf("<a href=\"%s\" target=\"%s\" onclick=\"window.open('%s','%s','%s');return false;\"%s>%s</a>",
       htmlspecialchars($url),
       ($target ? $target : "_new"),
       htmlspecialchars($url),
       ($target ? $target : "_new"),
               $windowprops,
       ($extras ? ' '.$extras : ''),
       ($linktext ? $linktext : $url)
   );
}

// print_popup_link()
// print a hyperlink to something, within the site, that pops up a new window
//
function print_popup_link($url, $linktext=false, $windowprops="", $target=false, $extras=false) {
   echo make_popup_link($url, $linktext, $windowprops, $target, $extras);
}

// Print a link for a downloadable file (including filesize)
function download_link($file, $title, $showsize = TRUE, $mirror = '')
{
   // Construct the download link for this site or a mirror site
   $download_link = "get/$file/from/a/mirror";
   if ($mirror != '') {
       $download_link = $mirror . $download_link;
   } else {
       $download_link = "/" . $download_link;
   }

   // Print out the download link
   print_link($download_link, $title);

   // Size display is required
   if ($showsize) {

       // We have a full path or a relative to the distributions dir
       if ($tmp = strrchr($file, "/")) {
           $local_file = substr($tmp, 1, strlen($tmp));
       } else {
           $local_file = "distributions/$file";
       }

       // Try to get the size of the file
       $size = @filesize($local_file);

       // Print out size in bytes (if size is
       // less then 1Kb, or else in Kb)
       if ($size) {
           echo ' [';
           if ($size < 1024) {
               echo number_format($size, 0, '.', ',') . 'b';
           } else {
               echo number_format($size/1024, 0, '.', ',') . 'Kb';
           }
           echo ']';
       }
   }
}

$enclosed = 0;

# commonheader()
#
#

function commonHeader($title="",$dont_enclose=0,$headers_gone=0) {
   global $MYSITE, $base, $enclosed, $EXPL_LANG, $SIDEBAR_DATA,
           $SEARCH_BASE, $ONLOAD;

   // If no onload event is specified, restore the last search
   if (empty($ONLOAD)) { $ONLOAD = "runOnLoad();"; }

   // Guess what base to use for this page (the first two are just
   // for BC reasons, until we migrate all the code to use the last one)
   unset($PBASE);
   if (!empty($SEARCH_BASE))          { $PBASE = $SEARCH_BASE; }
   if (!empty($_SERVER['BASE_HREF'])) { $PBASE = $_SERVER['BASE_HREF']; }

   // Choose name of mirror site specific CSS file
   $mirror_specific_style = ($_SERVER['STATIC_ROOT'] ? 'phpnet' : 'mirror');
  
   $rssautodiscovery = '';
   if (isset($_SERVER['BASE_PAGE']) && $_SERVER['BASE_PAGE'] == 'index.php') {
     $rssautodiscovery = ' <link rel="alternate" type="application/rss+xml" title="PHP: Hypertext Preprocessor" href="' . $MYSITE . 'news.rss" />' . "\n";
   }

?><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
 <title>PHP<?php if ($title) echo ": $title";?></title>
 <link rel="stylesheet" href="<?php echo $_SERVER['STATIC_ROOT']; ?>/style.css" />
 <link rel="stylesheet" href="<?php echo $_SERVER['STATIC_ROOT'] . "/styles/" . $mirror_specific_style; ?>.css" />
 <link rel="shortcut icon" href="<?php echo $_SERVER['STATIC_ROOT']; ?>/favicon.ico" />
<?php echo $rssautodiscovery; ?>
<script language="Javascript" type="text/javascript" src="<?php echo $_SERVER['STATIC_ROOT']; ?>/userprefs.js"></script>
<?php echo (isset($PBASE) ? ' <base href="' . $PBASE . '" />' : ''); ?></head>
<body bgcolor="#ffffff" text="#000000"
     link="#000099" alink="#0000ff" vlink="#000099"
     onload="<?php echo $ONLOAD; ?>">

<!--UdmComment-->
<table border="0" cellspacing="0" cellpadding="0" width="100%">
 <tr bgcolor="#9999cc">
  <td align="center" rowspan="2" width="126"><a href="/"><?php
   print_image('php.gif', 'PHP', false, 'hspace="3"'); ?></a></td>
  <td>&nbsp;</td>
 </tr>
 <tr bgcolor="#9999cc">
  <td align="right" valign="bottom">
<?php
   print_link('/downloads.php','downloads',false,'class="small"');
   echo " | ";
   print_link('/docs.php', 'documentation', false, 'class="small"');
   echo " | ";
   print_link('/FAQ.php', 'faq', false, 'class="small"');
   echo " | ";
   print_link('/support.php','getting help',false,'class="small"');
   echo " | ";
   print_link('/mailing-lists.php','mailing lists',false,'class="small"');
   echo " | ";
   print_link('http://bugs.php.net/','reporting bugs',false,'class="small"');
   echo " | ";
   print_link('/sites.php','php.net sites',false,'class="small"');
   echo " | ";
   print_link('/links.php','links',false,'class="small"');
   echo " | ";
   print_link ('/my.php', 'my php.net', false, 'class="small"');
     ?>&nbsp;
  </td>
 </tr>
 <tr bgcolor="#333366"><td colspan="2"><?php spacer(); ?></td></tr>
 <tr bgcolor="#666699">
   <td align="right" valign="top" colspan="2" class="quicksearch">
   <form method="post" action="/search.php" class="thin" name="topsearch">
<?php
   if (isset($EXPL_LANG)) {
       echo '<input type="hidden" name="lang" value="'.  $EXPL_LANG . '" />';
     }

   if (isset($base) && $base != $MYSITE) {
   $base = stripslashes($base);
   echo '<input type="hidden" name="base" value="' . $base . '" />';
   }
?>
<small><span title="Keyboard shortcut: Alt+S (Win), Ctrl+S (Apple)"><u>s</u>earch for</span></small>
<input class="small" type="text" name="pattern" value="" size="30" accesskey="s" />
<small>in the</small>
<select name="show" class="small">
<option value="quickref" selected="selected">function list</option>
<option value="wholesite">whole site</option>
<option value="manual">online documentation [en]</option>
<option value="bugdb">bug database</option>
<option value="maillist">general mailing list</option>
<option value="devlist">developer mailing list</option>
<option value="phpdoc">documentation mailing list </option>
</select>
<?php echo make_submit('small_submit_white.gif', 'search', 'bottom'); ?>&nbsp;
</form>
   </td>
 </tr>
 <tr bgcolor="#333366"><td colspan="3"><?php spacer(); ?></td></tr>
</table>
<!--/UdmComment-->

<?php
  if (!$dont_enclose):
   $enclosed = 1;
?>

<table border="0" cellpadding="0" cellspacing="0">
 <tr valign="top">
<?php if (!empty($SIDEBAR_DATA)):?>
  <td width="200" bgcolor="#f0f0f0">
   <table width="100%" cellpadding="2" cellspacing="0" border="0">
   <tr valign="top"><td class="sidebar"><?php echo $SIDEBAR_DATA?></td></tr>
   </table>
  </td>
  <td bgcolor="#cccccc" background="<?php echo $_SERVER['STATIC_ROOT']; ?>/images/checkerboard.gif" width="1"><?php spacer(); ?></td>
<?php endif; // sidebar printed ?>
  <td>
   <table cellpadding="10" cellspacing="0" width="100%">
   <tr><td valign="top">
<?php
  endif; // enclosed in a multiple column layout
}


# commonfooter()
#
#

function commonFooter() {
   global $SCRIPT_NAME, $MYSITE, $LAST_UPDATED, $PHP_SELF,
           $enclosed, $RSIDEBAR_DATA, $page_creation_start;
          
   $URL = (isset($_SERVER['BASE_PAGE']) ? "/" . $_SERVER['BASE_PAGE'] : $SCRIPT_NAME);
   if ($enclosed) {
       echo "</td></tr></table></td>";
       if (!empty($RSIDEBAR_DATA)) { ?>
<td bgcolor="#cccccc" background="<?php echo $_SERVER['STATIC_ROOT']; ?>/images/checkerboard.gif" width="1"><?php spacer(); ?></td>
<td width="185" bgcolor="#f0f0f0">
 <table width="100%" cellpadding="4" cellspacing="0">
  <tr valign="top"><td class="sidebar"><?php echo $RSIDEBAR_DATA?></td></tr>
 </table>
<?php spacer(175); ?>
</td>
<?php        }
       echo "</tr></table>\n";
   }
?>

<!--UdmComment-->
<table border="0" cellspacing="0" cellpadding="0" width="100%">
 <tr bgcolor="#333366"><td><?php spacer(); ?></td></tr>
 <tr bgcolor="#9999cc">
  <td align="right" valign="bottom">
<?php
   print_link("/source.php?url=$URL", 'show source', false, 'class="small"');
   echo " | ";
   print_link('/credits.php', 'credits', false, 'class="small"');
   echo " | ";
   if (have_stats()) {
       print_link('/stats/', 'stats', false, 'class="small"');
       echo " | ";
   }
   print_link('/sitemap.php', 'sitemap', false, 'class="small"');
   echo " | ";
   print_link('/contact.php', 'contact', false, 'class="small"');
   echo " | ";
   print_link('/contact.php#ads', 'advertising', false, 'class="small"');
   echo " | ";
   print_link('/mirrors.php', 'mirror sites', false, 'class="small"');
   echo "&nbsp;";
?>
  </td>
 </tr>
 <tr bgcolor="#333366"><td><?php spacer(); ?></td></tr>
</table>

<table border="0" cellspacing="0" cellpadding="6" width="100%">
 <tr valign="top" bgcolor="#cccccc">
  <td><small><?php echo make_link('/copyright.php', 'Copyright &copy; 2001-2005 The PHP Group'); ?><br />All rights reserved.</small></td>
  <td align="right"><small>
   <?php
   echo (is_official_mirror() ?
       "<a href=\"/mirror.php\">This mirror</a> generously provided by:" :
       "<a href=\"/mirror.php\">This unofficial mirror</a> is operated at:");
   ?>
  <a href="<?php echo mirror_provider_url();?>"><?php echo mirror_provider();?></a><br />
   Last updated: <?php echo strftime("%c %Z", $LAST_UPDATED); ?>
  </small>
  </td>
 </tr>
</table>
<!--/UdmComment-->
</body>
</html>
<?php
}

function sect_to_file($string) {
   $string = strtolower($string);
   $string = str_replace(' ','-',$string);
   $string = str_replace('_','-',$string);
   $func = "function.$string.php";
   $chap = "ref.$string.php";
   $feat = "features.$string.php";
   $struct = "control-structures.$string.php";
   if(@is_file($func)) return $func;
   else if(@is_file($chap)) return $chap;
   else if(@is_file($feat)) return $feat;
   else if(@is_file($struct)) return $struct;
   else return "$string.php";
}

function clean($var) {
  return htmlspecialchars(get_magic_quotes_gpc() ? stripslashes($var) : $var);
}

// Clean out the content of one user note for printing to HTML
function clean_note($text)
{
   // Highlight PHP source
   $text = highlight_php(trim($text), TRUE);

   // Turn urls into links
   $text = preg_replace(
       '!((mailto:|(http|ftp|nntp|news):\/\/).*?)(\s|<|\)|"|\\|\'|$)!',
       '<a href="\1" target="_blank">\1</a>\4',
       $text
   );
  
   return $text;
}

function display_errors($errors)
{
   echo '<div class="errors">';
   if (count($errors) > 1) {
       echo "You need to do the following before your submission will be accepted:<ul>";
       foreach ($errors as $error) {
           echo "<li>$error</li>\n";
       }
       echo "</ul>";
   }
   else {
       echo $errors[0];
   }
   echo '</div>';
}

// Displays an event. Used in event submission
// previews and event information displays
function display_event($event, $include_date = 1)
{
   global $COUNTRIES;
  
   // Weekday names array
   for ($i = 1; $i <= 7; $i++) {
       $days[$i] = strftime('%A', mktime(12, 0, 0, 4, $i, 2001));
   }

   // Recurring possibilities
   $re = array(
         1 => 'First',
         2 => 'Second',
         3 => 'Third',
         4 => 'Fourth',
       -1 => 'Last',
       -2 => '2nd Last',
       -3 => '3rd Last'
   );

   if (!isset($event['start'])) { $event['start'] = ""; }
   if (!isset($event['end'])) { $event['end'] = ""; }
   if (!isset($event['sday'])) { $event['sday'] = ""; }
   if (!isset($event['smonth'])) { $event['smonth'] = ""; }
   if (!isset($event['syear'])) { $event['syear'] = ""; }
   if (!isset($event['eday'])) { $event['eday'] = ""; }
   if (!isset($event['emonth'])) { $event['emonth'] = ""; }
   if (!isset($event['eyear'])) { $event['eyear'] = ""; }

   // Start and end day of this event
   $sday = $event['start'] ? strtotime($event['start'])
           : mktime(0, 0, 1, $event['smonth'], $event['sday'], $event['syear']);
   $eday = $event['end'] ? strtotime($event['end'])
           : mktime(0, 0, 1, $event['emonth'], $event['eday'], $event['eyear']);
?>
<table border="0" cellspacing="0" cellpadding="3" width="100%">
 <tr bgcolor="#dddddd"><td>
<?php
  
   // Print out date if needed
   if ($include_date && ($event['start'] || $event['smonth'])) {
       echo "<b>", date("F j, Y", $sday), "</b>\n";
   }
  
   // Print link in case we have one
   if ($event['url']) { echo '<a href="', htmlentities($event['url']),'">'; }
   // Print event description
   echo "<b>", stripslashes(htmlentities($event['sdesc'])), "</b>";
   // End link
   if ($event['url']) { echo "</a>"; }
 
   // Print extra date info for recurring and multiday events
   switch ($event['type']) {
       case 2:
       case 'multi':
           echo " (", date("Y-m-d",$sday), " to ", date("Y-m-d",$eday), ")";
           break;
       case 3:
       case 'recur':
           echo " (Every ", $re[$event['recur']], " ",
                 $days[$event['recur_day']], " of the month)";
           break;
   }
  
   // Event category
   if(isset($event['category']) && $event['category']) {
       $cat = array("unknown", "User Group Event", "Conference", "Training");
       echo ' [' . $cat[$event['category']] . '] ';   
   }
  
   // Print out country information
   echo ' (' , $COUNTRIES[$event['country']] , ')';
?>
</td></tr>
 <tr bgcolor="#eeeeee"><td>
<?php

   // Print long description
   echo preg_replace("/\r?\n\r?\n/", "<br /><br />", trim($event['ldesc']));
   // If we have an URL, print it out
   if ($event['url']) {
       echo '<br /><br /><b>URL:</b> ',
             '<a href="', htmlentities($event['url']), '">',
             htmlentities($event['url']), '</a>';
   }
?>
</td></tr>
</table>
<?php
}

// Print news links for archives
function print_news_links()
{
   $links = "";
   for ($i = 1998; $i < 2005; $i++) {
       $pagename = "news-$i.php";
       if ($pagename == $_SERVER['BASE_PAGE']) { continue; }
       $links .= '<a href="/news-' . $i . '.php">' . $i . '</a>, ';
   }
   echo substr($links, 0, -2);
}

/* vim: set noet ts=4 sw=4 ft=php: : */

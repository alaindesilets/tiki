<?php
// $Id: /cvsroot/tikiwiki/tiki/tiki-blogs_rss.php,v 1.34 2007-10-12 07:55:24 nyloth Exp $

// Copyright (c) 2002-2007, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

require_once ('tiki-setup.php');
require_once ('lib/tikilib.php');
require_once ('lib/blogs/bloglib.php');
require_once ('lib/rss/rsslib.php');

if ($prefs['feature_blogs'] != 'y') {
	$smarty->assign('msg', tra("This feature is disabled").": feature_blogs");
	$smarty->display("error.tpl");
	die;
}

if ($prefs['rss_blogs'] != 'y') {
        $errmsg=tra("rss feed disabled");
        require_once ('tiki-rss_error.php');
}

$res=$access->authorize_rss(array('tiki_p_read_blog','tiki_p_blog_admin'));
if($res) {
   if($res['header'] == 'y') {
      header('WWW-Authenticate: Basic realm="'.$tikidomain.'"');
      header('HTTP/1.0 401 Unauthorized');
   }
   $errmsg=$res['msg'];
   require_once ('tiki-rss_error.php');
}

$feed = "blogs";
$uniqueid = $feed;
$output = $rsslib->get_from_cache($uniqueid);

if ($output["data"]=="EMPTY") {
	$title =  (!empty($title_rss_blogs)) ? $title_rss_blogs : tra("Tiki RSS feed for weblogs");
	$desc =  (!empty($desc_rss_blogs)) ? $desc_rss_blogs : tra("Last posts to weblogs.");
	$now = date("U");
	$id = "postId";
	$descId = "data";
	$dateId = "created";
	$titleId = "title";
	$authorId = "user";
	$readrepl = "tiki-view_blog_post.php?postId=%s";

        $tmp = $prefs['title_rss_'.$feed];
        if ($tmp<>'') $title = $tmp;
        $tmp = $prefs['desc_rss_'.$feed];
        if ($desc<>'') $desc = $tmp;
	
	$changes = $bloglib -> list_all_blog_posts(0, $prefs['max_rss_blogs'], $dateId.'_desc', '', $now);
	$tmp = array();
	include_once('tiki-sefurl.php');
	foreach ($changes["data"] as $data)  {
      global $bloglib;
      if($prefs['summary_rss_blogs'] == "y") {
         $data["$descId"] = $tikilib->parse_data($bloglib->get_page($data[$descId],1), array('print'=>true));
      } else {
         $data["$descId"] = $tikilib->parse_data($data[$descId], array('print'=>true));
      }
	  $data['sefurl'] = filter_out_sefurl(sprintf($readrepl, $data['postId'], $data['blogId']), $smarty, 'blogpost', $data['title']);
		$tmp[] = $data;
	}
	$changes["data"] = $tmp;
	$tmp = null;
	$output = $rsslib->generate_feed($feed, $uniqueid, '', $changes, $readrepl, $id, '', $title, $titleId, $desc, $descId, $dateId, $authorId);
}
header("Content-type: ".$output["content-type"]);
print $output["data"];

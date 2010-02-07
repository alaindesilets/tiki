<?php
// $Id: /cvsroot/tikiwiki/tiki/tiki-articles_rss.php,v 1.35.2.2 2007-11-28 21:58:37 sylvieg Exp $

// Copyright (c) 2002-2007, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

require_once ('tiki-setup.php');
require_once ('lib/tikilib.php');
require_once ('lib/rss/rsslib.php');

if ($prefs['feature_articles'] != 'y') {
	$smarty->assign('msg', tra("This feature is disabled").": feature_articles");
	$smarty->display("error.tpl");
	die;
}

if ($prefs['rss_articles'] != 'y') {
	$errmsg=tra("rss feed disabled");
	require_once ('tiki-rss_error.php');
}

$res=$access->authorize_rss(array('tiki_p_read_article','tiki_p_admin_cms', 'tiki_p_articles_read_heading'));
if($res) {
   if($res['header'] == 'y') {
      header('WWW-Authenticate: Basic realm="'.$tikidomain.'"');
      header('HTTP/1.0 401 Unauthorized');
   }
   $errmsg=$res['msg'];
   require_once ('tiki-rss_error.php');
}

$feed = "articles";
if (isset($_REQUEST["topic"])) {
    $topic = $_REQUEST["topic"];
    $uniqueid = $feed.".".$topic;
    $topic = (int) ereg_replace("[^0-9]","", $topic);
} elseif (isset($_REQUEST['topicname'])) {
	$topic = $tikilib->fetchtopicId($_REQUEST['topicname']);
	$uniqueid = $feed.".".$topic;
} else {
    $uniqueid = $feed;
    $topic = "";
}

if (isset($_REQUEST["type"])) {
        $uniqueid .= '-'.$type;
        $type = $_REQUEST["type"];
} else {
        $type = '';
}

if (isset($_REQUEST['lang'])) {
	$articleLang = $_REQUEST['lang'];
	$prefs['rssfeed_language'] = $articleLang;
} else {
	$articleLang = '';
}
$uniqueid .= '/'.$articleLang;

if ($topic and !$tikilib->user_has_perm_on_object($user,$topic,'topic','tiki_p_topic_read')) {
	$smarty->assign('errortype', 401);
	$errmsg=tra("Permission denied. You cannot view this section");
	require_once ('tiki-rss_error.php');
}

$output = $rsslib->get_from_cache($uniqueid);

if ($output["data"]=="EMPTY") {
	$tmp = tra("Tiki RSS feed for articles");
	$title = (!empty($title_rss_articles)) ? $title_rss_articles : $tmp;
	$tmp = tra("Last articles.");
	$desc = (!empty($desc_rss_articles)) ? $desc_rss_articles : $tmp;
	$id = "articleId";
	$titleId = "title";
	$descId = "heading";
	$dateId = "publishDate";
	$authorId = "author";
	$readrepl = "tiki-read_article.php?$id=%s";

	$tmp = $prefs['title_rss_'.$feed];
	if ($tmp<>'') $title = $tmp;
	$tmp = $prefs['desc_rss_'.$feed];
	if ($desc<>'') $desc = $tmp;

	$changes = $tikilib -> list_articles(0, $prefs['max_rss_articles'], $dateId.'_desc', '', 0, $tikilib->now, $user, $type, $topic, 'y', '', '', '', '', $articleLang);
	$tmp = array();
	include_once('tiki-sefurl.php');
	foreach ($changes["data"] as $data)  {
		$data["$descId"] = $tikilib->parse_data($data[$descId], array('print'=>true));
		$data["body"] = null;
		$data['sefurl'] = filter_out_sefurl(sprintf($readrepl, $data['articleId']), $smarty, 'article', $data['title']);
		$tmp[] = $data;
	}
	$changes["data"] = $tmp;
	$tmp = null;
	$output = $rsslib->generate_feed($feed, $uniqueid, '', $changes, $readrepl, '', $id, $title, $titleId, $desc, $descId, $dateId, $authorId);
}
header("Content-type: ".$output["content-type"]);
print $output["data"];

<?php
// $Header: /cvsroot/tikiwiki/tiki/tiki-image_galleries_rss.php,v 1.25 2005-01-22 22:54:54 mose Exp $

// Copyright (c) 2002-2005, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

require_once ('tiki-setup.php');
require_once ('lib/tikilib.php');
require_once ('lib/imagegals/imagegallib.php');

if ($rss_image_galleries != 'y') {
        $errmsg=tra("rss feed disabled");
        require_once ('tiki-rss_error.php');
}

if ($tiki_p_view_image_gallery != 'y') {
        $errmsg=tra("Permission denied you cannot view this section");
        require_once ('tiki-rss_error.php');
}

$feed = "imggal";
$title = (!empty($title_rss_image_galleries)) ? $title_rss_image_galleries : tra("Tiki RSS feed for image galleries");
$desc = (!empty($desc_rss_image_galleries)) ? $desc_rss_image_galleries : tra("Last images uploaded to the image galleries.");

$now = date("U");
$id = "imageId";
$titleId = "name";
$descId = "description";
$dateId = "created";
$readrepl = "tiki-browse_image.php?imageId=";
$uniqueid = $feed;

require ("tiki-rss_readcache.php");

if ($output == "EMPTY") {
  $changes = $imagegallib->list_images(0,$max_rss_image_galleries,$dateId.'_desc', '');
  $output = "";
}

require ("tiki-rss.php");

?>

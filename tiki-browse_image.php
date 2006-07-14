<?php

// $Header: /cvsroot/tikiwiki/tiki/tiki-browse_image.php,v 1.37 2006-07-14 11:00:43 sylvieg Exp $

// Copyright (c) 2002-2005, Luis Argerich, Garland Foster, Eduardo Polidor, et. al.
// All Rights Reserved. See copyright.txt for details and a complete list of authors.
// Licensed under the GNU LESSER GENERAL PUBLIC LICENSE. See license.txt for details.

// Initialization
require_once('tiki-setup.php');

include_once("lib/imagegals/imagegallib.php");
include_once ('lib/stats/statslib.php');

if ($feature_categories == 'y') {
	global $categlib;
	if (!is_object($categlib)) {
		include_once('lib/categories/categlib.php');
	}
}

if ($feature_galleries != 'y') {
	$smarty->assign('msg', tra("This feature is disabled").": feature_galleries");

	$smarty->display("error.tpl");
	die;
}

if (!isset($_REQUEST["imageId"])) {
	$smarty->assign('msg', tra("No image indicated"));

	$smarty->display("error.tpl");
	die;
}

// always get gallery from image so no user can fake the galleryid
// and get an image that is truly in another (forbidden) gallery
$_REQUEST["galleryId"] = $imagegallib->get_gallery_from_image($_REQUEST["imageId"]);

if ($_REQUEST["galleryId"] == 0 && $tiki_p_admin_galleries != 'y') {
	$smarty->assign('msg', tra("Permission denied you cannot access this gallery"));

	$smarty->display("error.tpl");
	die;
}

$smarty->assign('individual', 'n');

if ($userlib->object_has_one_permission($_REQUEST["galleryId"], 'image gallery')) {
	$smarty->assign('individual', 'y');

	if ($tiki_p_admin != 'y') {
		// Now get all the permissions that are set for this type of permissions 'image gallery'
		$perms = $userlib->get_permissions(0, -1, 'permName_desc', '', 'image galleries');

		foreach ($perms["data"] as $perm) {
			$permName = $perm["permName"];

			if ($userlib->object_has_permission($user, $_REQUEST["galleryId"], 'image gallery', $permName)) {
				$$permName = 'y';

				$smarty->assign("$permName", 'y');
			} else {
				$$permName = 'n';

				$smarty->assign("$permName", 'n');
			}
		}
	}
} elseif ($tiki_p_admin != 'y' && $feature_categories == 'y') {
	$perms_array = $categlib->get_object_categories_perms($user, 'image gallery', $_REQUEST['galleryId']);
	if ($perms_array) {
		$is_categorized = TRUE;
		foreach ($perms_array as $perm => $value) {
			$$perm = $value;
		}
	} else {
		$is_categorized = FALSE;
	}
	if ($is_categorized && isset($tiki_p_view_categories) && $tiki_p_view_categories != 'y') {
		if (!isset($user)){
			$smarty->assign('msg',$smarty->fetch('modules/mod-login_box.tpl'));
			$smarty->assign('errortitle',tra("Please login"));
		} else {
			$smarty->assign('msg',tra("Permission denied you cannot view this page"));
		}
		$smarty->display("error.tpl");
		die;
	}
}

if ($tiki_p_admin_galleries == 'y') {
	$tiki_p_view_image_gallery = 'y';
	$smarty->assign("tiki_p_view_image_gallery", 'y');
}

if ($tiki_p_view_image_gallery != 'y') {
	$smarty->assign('msg', tra("Permission denied you can not view this section"));
	$smarty->display("error.tpl");
	die;
}

if (isset($_REQUEST['slideshow_p'])) {
	$smarty->assign_by_ref('slideshow_p', $_REQUEST['slideshow_p']);
}
if (isset($_REQUEST['slideshow_n'])) {
	$smarty->assign_by_ref('slideshow_n', $_REQUEST['slideshow_n']);
}

$scalesize = 0;
if (isset($_REQUEST['scalesize'])) {
	$scalesize = $_REQUEST['scalesize'];
}

$scaleinfo = $imagegallib->get_gallery_prevnext_scale($_REQUEST["galleryId"],$scalesize);
// print_r($scaleinfo);
$smarty->assign_by_ref('scaleinfo',$scaleinfo);

if (!isset($_REQUEST["scaled"])) {
	$itype = 'o';

	$scalesize = 0;
} else {
	$itype = 's';
}

$smarty->assign_by_ref('itype', $itype);
$smarty->assign_by_ref('scalesize', $scalesize);

$info = $imagegallib->get_image_info($_REQUEST["imageId"], $itype, $scalesize);
$gal_info = $imagegallib->get_gallery($info["galleryId"]);

if (!isset($_REQUEST["sort_mode"])) {
	$_REQUEST["sort_mode"] = "created_desc";
}

$sort_mode = $_REQUEST["sort_mode"];

$smarty->assign('individual', 'n');

if ($userlib->object_has_one_permission($_REQUEST["galleryId"], 'image gallery')) {
	$smarty->assign('individual', 'y');

	if ($tiki_p_admin != 'y') {
		// Now get all the permissions that are set for this type of permissions 'image gallery'
		$perms = $userlib->get_permissions(0, -1, 'permName_desc', '', 'image galleries');

		foreach ($perms["data"] as $perm) {
			$permName = $perm["permName"];

			if ($userlib->object_has_permission($user, $_REQUEST["galleryId"], 'image gallery', $permName)) {
				$$permName = 'y';

				$smarty->assign("$permName", 'y');
			} else {
				$$permName = 'n';

				$smarty->assign("$permName", 'n');
			}
		}
	}
}

if ($tiki_p_admin_galleries == 'y') {
	$tiki_p_view_image_gallery = 'y';

	$smarty->assign("tiki_p_view_image_gallery", 'y');
	$tiki_p_upload_images = 'y';
	$smarty->assign("tiki_p_upload_images", 'y');
	$tiki_p_create_galleries = 'y';
	$smarty->assign("tiki_p_create_galleries", 'y');
}

if ($tiki_p_view_image_gallery != 'y') {
	$smarty->assign('msg', tra("Permission denied you can not view this section"));

	$smarty->display("error.tpl");
	die;
}

// BUILD NEXT AND PREV IMG WITH THE INFORMATION FROM SORT MODE OFFSET AND DESP
// $images = $tikilib->get_images($offset,$maxRecords,$sort_mode,$find,$_REQUEST["galleryId"]);
// Ver si offset es 0 y desp 0 entonces no hay mas
// VERRRRRRRRRRRRRRRRRr
if (!isset($_REQUEST["desp"])) {
	$_REQUEST["desp"] = 0;
}

if (!isset($_REQUEST["offset"])) {
	$_REQUEST["offset"] = 0;
}

$offset = $_REQUEST["offset"];
$image_prev = $imagegallib->get_images($offset + $_REQUEST["desp"] - 1, 1, $sort_mode, '', $_REQUEST["galleryId"]);

if (count($image_prev["data"]) == 1) {
	$smarty->assign('previmg', $image_prev["data"][0]["imageId"]);
} else {
	$smarty->assign('previmg', '');
}

$image_next = $imagegallib->get_images($offset + $_REQUEST["desp"] + 1, 1, $sort_mode, '', $_REQUEST["galleryId"]);

if (count($image_next["data"]) == 1) {
	$smarty->assign('nextimg', $image_next["data"][0]["imageId"]);
} else {
	$smarty->assign('nextimg', '');
}

$images_count = $imagegallib->get_images($offset,$maxRecords,$sort_mode,'',$_REQUEST["galleryId"]);
$lastdesp = count($images_count["data"]) - 1;
$smarty->assign('lastdesp', $lastdesp);

$smarty->assign('firstId', $imagegallib->get_first_image($sort_mode, '', $_REQUEST['galleryId']));
$smarty->assign('lastId', $imagegallib->get_last_image($sort_mode, '', $_REQUEST['galleryId']));

$smarty->assign('offset', $_REQUEST["offset"]);
$smarty->assign('prevdesp', $_REQUEST["desp"] - 1);
$smarty->assign('nextdesp', $_REQUEST["desp"] + 1);
$smarty->assign('desp', $_REQUEST["desp"]);
$smarty->assign('sort_mode', $_REQUEST["sort_mode"]);
$smarty->assign('galleryId', $_REQUEST["galleryId"]);

$foo = parse_url($_SERVER["REQUEST_URI"]);
$foo1 = str_replace("tiki-browse_image", "tiki-browse_image", $foo["path"]);
$foo2 = str_replace("tiki-browse_image", "show_image", $foo["path"]);
$smarty->assign('url_browse', $tikilib->httpPrefix(). $foo1);
$smarty->assign('url_show', $tikilib->httpPrefix(). $foo2);

$imagegallib->add_image_hit($_REQUEST["imageId"]);
$info = $imagegallib->get_image_info($_REQUEST["imageId"]); //todo: already known???
$gal_info = $imagegallib->get_gallery($info["galleryId"]);
//$smarty->assign_by_ref('theme',$gal_info["theme"]);
//$smarty->assign('use_theme','y');

// Everybody can browse images
if (isset($_REQUEST["move_image"])) {
	check_ticket('browse-image');
	if ($tiki_p_admin_galleries != 'y' && (!$user || $user != $gal_info["user"])) {
		$smarty->assign('msg', tra("Permission denied you cannot move images from this gallery"));

		$smarty->display("error.tpl");
		die;
	}

	if (isset($_REQUEST["newname"]) and $_REQUEST["newname"] != $info["name"]) {
		if ($imagegallib->edit_image($_REQUEST['imageId'], $_REQUEST['newname'], $info['description'],$info['lat'],$info['lon'])) {
			$info['name'] = $_REQUEST['newname'];
		}
	}
	$imagegallib->move_image($_REQUEST["imageId"], $_REQUEST["newgalleryId"]);
}

$smarty->assign_by_ref('owner', $gal_info["user"]);
$smarty->assign_by_ref('defaultscale', $gal_info["defaultscale"]);
$smarty->assign_by_ref('imageId', $_REQUEST["imageId"]);
$smarty->assign_by_ref('name', $info["name"]);
$smarty->assign_by_ref('title', $info["name"]);
$smarty->assign_by_ref('galleryId', $info["galleryId"]);
$smarty->assign_by_ref('description', $info["description"]);
$smarty->assign_by_ref('lat', $info["lat"]);
$smarty->assign_by_ref('lon', $info["lon"]);
$smarty->assign_by_ref('created', $info["created"]);
$smarty->assign_by_ref('filename', $info["filename"]);
$smarty->assign_by_ref('xsize', $info["xsize"]);
$smarty->assign_by_ref('ysize', $info["ysize"]);
$smarty->assign_by_ref('hits', $info["hits"]);
$smarty->assign_by_ref('image_user', $info["user"]);

$galleries = $imagegallib->list_visible_galleries(0, -1, 'lastModif_desc', $user, '');
$smarty->assign_by_ref('galleries', $galleries["data"]);

// Init vars
$smarty->assign('popup', '');
$smarty->assign('popupsize', '');
$winxsize = 0;
$winysize = 0;

// Calculate PopUp Window size for the popup link
$winx = $info['xsize'];

if ($winx < 320) {
	$winx = 320;
}

$winy = $info['ysize'];

if ($winy < 200) {
	$winy = 200;
}

// Give it some more pixels for the links and a little margin
$winx += 40;
$winy += 80;
// Now get'em to the template
$smarty->assign('winx', $winx);
$smarty->assign('winy', $winy);

$section = 'galleries';
include_once('tiki-section_options.php');

if ($feature_theme_control == 'y') {
	$cat_type = 'image gallery';

	$cat_objid = $_REQUEST["galleryId"];
	include('tiki-tc.php');
}

// now set it if needed
if (isset($_REQUEST['popup'])and ($_REQUEST['popup'])) {
	$smarty->assign('popup', 'y');

/* Comment out broken Slideshow-stuff
	if (!isset($_REQUEST["sort_mode"])) {
		if(isset($info['sortorder'])) {
			// default sortorder from gallery settings
			$sort_mode = $info['sortorder'].'_'.$info['sortdirection'];
		} else {
			$sort_mode = 'created_desc';
		}
	} else {
		$sort_mode = $_REQUEST["sort_mode"];
	}

	$smarty->assign_by_ref('sort_mode', $sort_mode);


	if ($_REQUEST["galleryId"] == 0) {
		$info["thumbSizeX"] = 100;

		$info["thumbSizeY"] = 100;
		$info["galleryId"] = 0;
		$info["user"] = 'admin';
		$info["name"] = 'System';
		$info["public"] = 'y';
		$info["description"] = 'System Gallery';
		$info['sortorder'] = 'created';
		$info['sortdirection'] = 'desc';
		$info['galleryimage'] = 'last';
		$smarty->assign('system', 'y');
	} else {
		$info = $imagegallib->get_gallery($_REQUEST["galleryId"]);

		$nextscaleinfo = $imagegallib->get_gallery_next_scale($_REQUEST["galleryId"]);
	}

	if (!isset($info["maxRows"]))
	$info["maxRows"] = 10;

	if (!isset($info["rowImages"]))
	$info["rowImages"] = 5;

	if (!isset($nextscaleinfo['scale'])) {
		$nextscaleinfo['scale'] = 0;

		$nextscaleinfo['scale'] = 0;
	}

	if ($info["maxRows"] == 0)
	$info["maxRows"] = 10;

	if ($info["rowImages"] == 0)
	$info["rowImages"] = 6;

	$maxImages = $info["maxRows"] * $info["rowImages"];
	$smarty->assign_by_ref('maxImages', $maxImages);
	$smarty->assign_by_ref('rowImages', $info["rowImages"]);
	$smarty->assign('rowImages2', $info["rowImages"] - 1);
	$smarty->assign_by_ref('thx', $info["thumbSizeX"]);
	$smarty->assign_by_ref('thy', $info["thumbSizeY"]);
	$smarty->assign_by_ref('name', $info["name"]);
	$smarty->assign('title', $info["name"]);
	$smarty->assign_by_ref('description', $info["description"]);
	$smarty->assign_by_ref('nextscale', $nextscaleinfo['scale']);

	$subgals = $imagegallib->get_subgalleries($offset, $maxImages, $sort_mode, '', $_REQUEST["galleryId"]);
	$remainingImages = $maxImages-count($subgals['data']);
	$newoffset = $offset -$subgals['cant'];
	$images = $imagegallib->get_images($newoffset, $remainingImages, $sort_mode, '', $_REQUEST["galleryId"]);

	$images_slide = $imagegallib->get_images($newoffset, $remainingImages, $sort_mode, '', $_REQUEST["galleryId"]);

	
	$smarty->assign('slide_show',$images_slide);


END Comment out
*/
	$smarty->assign('feature_top_bar', 'n');
	$smarty->assign('feature_left_column', 'n');
	$smarty->assign('feature_right_column', 'n');
	$smarty->assign('feature_bot_bar', 'n');
}
ask_ticket('browse-image');

//add a hit
$statslib->stats_hit($info["name"],"image",$_REQUEST["imageId"]);
if ($feature_actionlog == 'y') {
	include_once('lib/logs/logslib.php');
	$logslib->add_action('Viewed', $_REQUEST['galleryId'], 'image gallery');
}

// Display the template
if (isset($_REQUEST['popup'])and ($_REQUEST['popup'])) {
	$smarty->display("tiki-browse_image.tpl");
} else {
	$smarty->assign('mid', 'tiki-browse_image.tpl');
	$smarty->display("tiki.tpl");
}

?>

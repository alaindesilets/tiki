<?php
// $Header: /cvsroot/tikiwiki/tiki/modules/mod-change_category.php,v 1.6.2.1 2007-12-03 15:57:51 sylvieg Exp $

//this script may only be included - so its better to die if called directly.
// param: id, shy, notop
if (strpos($_SERVER["SCRIPT_NAME"],basename(__FILE__)) !== false) {
  header("location: index.php");
  exit;
}
global $prefs;
global $logslib; require_once('lib/logs/logslib.php');
global $categlib; require_once('lib/categories/categlib.php');
  
// temporary limitation to wiki pages
// params : id (id of parent categ) and shy (show only if page is in categ)
if ($prefs['feature_categories'] == 'y' && (isset($_REQUEST['page']) || isset($_REQUEST['page_ref_if']))) {
	if (empty($_REQUEST['page'])) {
		global $structlib; include_once('lib/structures/structlib.php');
		$page_info = $structlib->s_get_page_info($_REQUEST['page_ref_id']);
		$_REQUEST['page'] = $page_info['page'];
	}
  if (!empty($module_params['id'])) {
    $id = $module_params['id'];
	$cat_parent = $categlib->get_category_name($id);
  } else {
	$id = 0;
	$cat_parent = 0;
  }
  if (isset($module_params['shy'])) {
    $notshy = false;
  } else {
    $notshy = true;
  }

  $cat_type = 'wiki page';
  $cat_objid = $_REQUEST['page'];
  
  $categs = $categlib->list_categs($id);
  $num = count($categs);
  $modcatlist = array();
  $categsid = array();
  for ($i=0;$i<$num;$i++) {
    $categsid[] = $categs[$i]['categId'];
  }
  
  if (isset($_REQUEST["modcatid"]) and $_REQUEST["modcatid"] == $id) {
    $cats = $categlib->get_object_categories($cat_type, $cat_objid);
    $catObjectId = $categlib->is_categorized($cat_type, $_REQUEST['page']);
    $cs ="";
    foreach ($cats as $cs) {
      if (in_array($cs,$categsid)) {
		  $query = "delete from `tiki_category_objects` where `catObjectId`=? and `categId`=?";
		  $result = $tikilib->query($query,array((int) $catObjectId, (int) $cs));
      }
    }
    if ($_REQUEST['modcatchange'] != 0) {
      $categlib->categorize_page($_REQUEST['page'], $_REQUEST['modcatchange']);
      $logslib->add_log('step',"changed ".$_REQUEST['page']." from $cs to ".$_REQUEST['modcatchange']);
    }
    else {
      $logslib->add_log('step',"changed ".$_REQUEST['page']." from $cs to top");
    }
    header('Location: tiki-index.php?page='.urlencode($cat_objid));
    die;
  }

  $incategs = $categlib->get_object_categories($cat_type, $cat_objid);

  for ($i=0;$i<$num;$i++) {
    $cid = $categs[$i]['categId'];
    $modcatlist[$cid] = $categs[$i];
    if (in_array($cid,$incategs)) {
      $modcatlist[$cid]['incat'] = 'y';
      $notshy = true;
    } else {
      $modcatlist[$cid]['incat'] = 'n';
    }
  }

  $smarty->assign('showmodule',$notshy);
  if (isset($changecateg)) /* big pacth... changecateg is not defined somewhere else */
    $smarty->assign('modname',$changecateg.$id);
  else
    $smarty->assign('modname',"change_category");
  $smarty->assign('modcattitle',sprintf(tra('move %s in %s'),$_REQUEST['page'],$cat_parent));
  $smarty->assign('modcatlist',$modcatlist);
  $smarty->assign('modcatid',$id);
}
?>

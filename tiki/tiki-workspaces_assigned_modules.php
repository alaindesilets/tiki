<?php
/*
* @author: Javier Reyes Gomez (jreyes@escire.com)
* @date: 27/01/2006
* @copyright (C) 2006 Javier Reyes Gomez (eScire.com)
* @license http://www.gnu.org/copyleft/lgpl.html GNU/LGPL
*/
require_once ('tiki-setup.php');
include_once ('lib/workspaces/workspacemoduleslib.php');
require_once('lib/workspaces/workspacelib.php');
require_once('lib/workspaces/typeslib.php');
require_once('lib/modules/modlib.php');

if ($tiki_p_admin != 'y' && $tiki_p_configure_modules != 'y') {
	$smarty->assign('msg', tra("You do not have permission to use this feature"));

	$smarty->display("error.tpl");
	die;
}

if (!isset($_SESSION["currentWorkspace"]) && !isset($_REQUEST["wstypeId"])) {
	$smarty->assign('msg', tra("Workspace not selected"));
	$smarty->display("error.tpl");
	die;
}

$wsuser = "";
$workspacesLib = new WorkspaceLib($dbTiki);
$wsTypesLib = new WorkspaceTypesLib($dbTiki);

$title = "";
$wstypeId="";
$wsmodtype="";

if(isset($_REQUEST["wstypeId"]) && $_REQUEST["wsmodtype"]=="workspace"){
	$wstypeId=$_REQUEST["wstypeId"];
	$workspace = $workspacesLib->get_workspace_by_id($_REQUEST["wstypeId"]);
	if (isset($workspace)){
		$wsuser = "WSUSER-".$workspace["code"];
		$wstypeId = $_REQUEST["wstypeId"];
		$wsmodtype  = "workspace";
		$title = "Workspace: (".$workspace["code"].") ".$workspace["name"];
		$type = $workspace["type"];
	}
}elseif(isset($_REQUEST["wstypeId"]) && $_REQUEST["wsmodtype"]=="workspace type"){
	$wstype = $wsTypesLib->get_workspace_type_by_id($_REQUEST["wstypeId"]);
	if (isset($wstype)){
		$wsuser = "WSTUSER-".$wstype["code"];
		$wstypeId = $_REQUEST["wstypeId"];
		$wsmodtype  = "workspace type";
		$title = "Workspace Type: ".$wstype["name"];
	}	
}elseif(isset($_SESSION["currentWorkspace"])){
	$workspace = $workspacesLib->get_workspace_by_id($_SESSION["currentWorkspace"]["wstypeId"]);
	if (isset($workspace)){
		$wsuser = "WSUSER-".$workspace["code"];
		$wstypeId = $_REQUEST["wstypeId"];
		$wsmodtype  = "workspace";
		$title = "Workspace: (".$workspace["code"].") ".$workspace["name"];
		$type = $workspace["type"];
	}
}

if (!isset($wstypeId) || $wstypeId=="") {
	$smarty->assign('msg', tra("Workspace not selected"));
	$smarty->display("error.tpl");
	die;
}

$max_columns = $max_columns = array_pop(array_keys($wsmoduleslib->get_ws_assigned_modules_by_cols($wstypeId,$wsmodtype)));

$smarty->assign('title', $title);

if (isset($_REQUEST["recreate"])) {
	check_ticket('user-modules');
	assign_wstype_modules($wstypeId,$wsmodtype,$wsmoduleslib);
}
if (isset($_REQUEST["clean"])) {
	check_ticket('user-modules');
	clean_assigned_modules($wstypeId,$wsmodtype,$wsmoduleslib);
}

if (isset($_REQUEST["unassign"])) {
	check_ticket('user-modules');
	$wsmoduleslib->unassign_workspace_module($_REQUEST["moduleId"]);
}

if (isset($_REQUEST["assign"]) && isset($_REQUEST["moduleId"]) && $_REQUEST["moduleId"]!="" ) {
	check_ticket('user-modules');
	//$wsmoduleslib->update_workspace_module($_REQUEST["module"],$_REQUEST["position"],$_REQUEST["order"],$_REQUEST["title"],$_REQUEST["cache_time"],$_REQUEST["rows"],$_REQUEST["params"],$_REQUEST["groups"],$_REQUEST["moduleId"]);
	$params = get_request_params();
	$wsmoduleslib->update_workspace_module($_REQUEST["module"],$_REQUEST["position"],$_REQUEST["order"],$_REQUEST["title"],"","",$params,"",$_REQUEST["style_title"],$_REQUEST["style_data"],$_REQUEST["moduleId"]);
}else if(isset($_REQUEST["assign"])){
	check_ticket('user-modules');
	$params = get_request_params();
	//$wsmoduleslib->assign_workspace_module($_REQUEST["module"],$_REQUEST["position"],$_REQUEST["order"],$wsmodtype,$wstypeId,$_REQUEST["title"],$_REQUEST["cache_time"],$_REQUEST["rows"],$_REQUEST["params"],$_REQUEST["groups"]);
	$wsmoduleslib->assign_workspace_module($_REQUEST["module"],$_REQUEST["position"],$_REQUEST["order"],$wsmodtype,$wstypeId,$_REQUEST["title"],"","",$params,"",$_REQUEST["style_title"],$_REQUEST["style_data"]);
}else if (isset($_REQUEST["edit"])) {
	$editmod = $wsmoduleslib->get_workspace_assigned_module($_REQUEST["edit"]);
	if (isset($editmod) && $editmod!=""){
		$arrayparams = get_module_params($editmod["name"]);
		if ($editmod["params"] && $editmod["params"]!="" && isset($arrayparams) && count($arrayparams)>0){
			parse_str($editmod["params"], $module_params);
			foreach ($arrayparams as $key => $param) {
				if (isset($module_params[$key])){
					$arrayparams[$key]["defaultValue"] = $module_params[$key];
				}else{
					$arrayparams[$key]["defaultValue"] ="";
				}
			}
			$smarty->assign('arrayparams', $arrayparams);
		}
		$smarty->assign('module', $editmod);
	}
}else if(isset($_REQUEST["selectModule"]) && $_REQUEST["selectModule"]=="y"){
	$phpfile = 'modules/conf/modconf-'.$_REQUEST["module"].'.php';
	$module = array();
	$module["name"] = $_REQUEST["module"];
	if (file_exists($phpfile)) {
		include ($phpfile);
		//$fun = create_function('', "module_".$_REQUEST["module"]."_help");
        //$ret = $fun();
        $funHelp = "module_".$_REQUEST["module"]."_help";
        $funTitle = "module_".$_REQUEST["module"]."_title";
        $funParams = "module_".$_REQUEST["module"]."_params";
        $help = $funHelp();
        $title = $funTitle();
        $params = $funParams();
        $module["title"] = $title;
        $module["help"] = $help;
        $smarty->assign('arrayparams', $params);
	}
	$smarty->assign('module', $module);
}
	
if (isset($_REQUEST["up"]) && isset($_REQUEST["moduleId"])) {
	check_ticket('user-modules');
	$wsmoduleslib->up_workspace_module($_REQUEST["moduleId"]);
}

if (isset($_REQUEST["down"]) && isset($_REQUEST["moduleId"])) {
	check_ticket('user-modules');
	$wsmoduleslib->down_workspace_module($_REQUEST["moduleId"]);
}

if (isset($_REQUEST["left"]) && isset($_REQUEST["moduleId"])) {
	check_ticket('user-modules');
	$module = $wsmoduleslib->get_workspace_assigned_module($_REQUEST["moduleId"]);
	if (isset($module) && $module["position"]>1){
		$wsmoduleslib->set_column_workspace_module($_REQUEST["moduleId"], $module["position"]-1);
	}
}

if (isset($_REQUEST["right"]) && isset($_REQUEST["moduleId"])) {
	check_ticket('user-modules');
	$module = $wsmoduleslib->get_workspace_assigned_module($_REQUEST["moduleId"]);
	if (isset($module)){
		$wsmoduleslib->set_column_workspace_module($_REQUEST["moduleId"], $module["position"]+1);
	}
}

$orders = array();

for ($i = 1; $i < 20; $i++) {
	$orders[] = $i;
}

$smarty->assign_by_ref('orders', $orders);

$assignables = $modlib->get_all_modules();
sort ($assignables);

if (count($assignables) > 0) {
	$smarty->assign('canassign', 'y');
} else {
	$smarty->assign('canassign', 'n');
}

//print_r($assignables);
$modules = $wsmoduleslib->get_ws_assigned_modules_by_cols($wstypeId,$wsmodtype);

$max_columns = array_pop(array_keys($modules));

$columns = array();
for($i=1;$i<=$max_columns+1;$i++){
	$columns[$i] = tra("Column ").$i;
} 

//array("1" => "Column 1", "2" => "Column 2", "3" => "Column 3","4" => "Column 4");
//$modules = $wsmoduleslib->get_workspace_assigned_modules($wstypeId,$wsmodtype);

$smarty->assign('modules_l', $wsmoduleslib->get_workspace_assigned_modules_pos($wstypeId,$wsmodtype, '1'));
$smarty->assign('modules_r', $wsmoduleslib->get_workspace_assigned_modules_pos($wstypeId,$wsmodtype, '2'));
$smarty->assign('columns',$columns);
$smarty->assign_by_ref('assignables', $assignables);
$smarty->assign_by_ref('modules', $modules);
$smarty->assign("wstypeId",$wstypeId);
$smarty->assign("wsmodtype",$wsmodtype);
//print_r($modules);
include_once ('tiki-mytiki_shared.php');

ask_ticket('user-modules');

$smarty->assign('mid', 'tiki-workspaces_assigned_modules.tpl');
$smarty->display("tiki.tpl");


function clean_assigned_modules($wstypeId,$wsmodtype,$wsmoduleslib){
	$modules = $wsmoduleslib->get_workspace_assigned_modules($wstypeId,$wsmodtype);	
	foreach ($modules as $key => $module) {
			$wsmoduleslib->unassign_workspace_module($module["moduleId"]);
	}
}

function assign_wstype_modules($wstypeId,$wsmodtype,$wsmoduleslib){
	clean_assigned_modules($wstypeId,$wsmodtype,$wsmoduleslib);
	$modules = $wsmoduleslib->get_workspace_assigned_modules($wstypeId,$wsmodtype);
	foreach ($modules as $key => $module) {
		$wsmoduleslib->assign_workspace_module($module["name"], $module["position"], $module["ord"],$wsmodtype,$wstypeId,$module["title"],$module["cache_time"],$module["rows"],$module["params"],$module["groups"]);
	}	
}

function get_module_params($module_name){
	$phpfile = 'modules/conf/modconf-'.$module_name.'.php';
	if (file_exists($phpfile)) {
		include ($phpfile);
        $funParams = "module_".$module_name."_params";
        $params = $funParams();
		return $params;
	}
	return null;
}

function get_request_params(){
	if (!isset($_REQUEST["params"])){
		$arrayparams = get_module_params($_REQUEST["module"]);
		if (isset($arrayparams) && count($arrayparams)>0){
			$params="";
			foreach ($arrayparams as $key => $param) {
				if($params!=""){
					$params.="&";
				}
				if (isset($_REQUEST["module_param_".$key])){
					$params .= $key."=".$_REQUEST["module_param_".$key];
				}
			}
			return $params;
		}else{
			return "";
		}
	}else{
		return $_REQUEST["params"];
	}
}
?>
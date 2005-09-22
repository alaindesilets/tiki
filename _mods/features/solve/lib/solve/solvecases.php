<?php
/**
 * @version $Id: solvecases.php,v 1.2 2005-09-22 09:35:00 michael_davey Exp $
 * @package TikiWiki
 * @subpackage Solve
 * @copyright (C) 2005 the Tiki community
 * @license http://www.gnu.org/copyleft/lgpl.html GNU/LGPL
 */

$access->check_script($_SERVER["SCRIPT_NAME"],basename(__FILE__));

require_once ( 'lib/solve/db/vtiger_portal_configuration.php' );
require_once ( "lib/solve/db/vtiger_portal_case_fields.php" );

define('_MYNAMEIS', 'cases');

require_once( "lib/vtiger/vtiger.php" );

require_once('lib/tikiaccesslib.php'); 
$access->check_user($user);

$presentation = new TikiPresentation();
// we already have $option from solve.php global section
$task = solve_get_param( $_REQUEST, 'task' );
$sortBy = solve_get_param( $_REQUEST, 'order_by' );
$dbtable = new VtigerCaseFields();
$config = new SolveConfiguration( 'TikiWiki', $presentation, $option, $task, $sortBy, $dbtable );

$caseApp = new VtigerAppCase($config, $user);

$caseID = solve_get_param( $_REQUEST, 'caseID' );
$caseID = $caseID == null ? 0 : $caseID;

$caseApp->login();

if(isset($SoapError) && isset( $caseApp->$SoapError) &&  $caseApp->$SoapError )
    $task = "error";

$caseApp->setSessionStartCallback('startCrmSession');
$caseApp->setSessionStopCallback('stopCrmSession');

// Session management, logs into the soap server and gets the session ID
$caseApp->startSession();

switch( $task ) {
    case "new":
        $access->check_page($user, array('feature_crm'), array('vtiger_p_create_cases'));
        $columns = $dbtable->getColumnData($caseApp);
        
        $presentation->Render($columns,null,null,'cases');
        break;
    case "search":
        $access->check_page($user, array('feature_crm'), array('vtiger_p_search_cases'));
        $columnData = $dbtable->getColumnData($caseApp);
        $columns = $columnData['selected'];
        $searchcolumns = array();
        foreach($columns as $column) {
            if($column['searchable'] == 1) {
                if( isset( $_REQUEST[$column['field']]) && $_REQUEST[$column['field']] != null && $_REQUEST[$column['field']] != '' ) {
                    $searchcolumns[$column['field']] = $_REQUEST[$column['field']];
                } else {
                    $searchcolumns[$column['field']] = '';
                }
            }
        }

        $bugs = $caseApp->search($searchcolumns);
        
        $presentation->RenderList($bugs, $searchcolumns, $columnData);
        break;
    case "edit":
        $access->check_page($user, array('feature_crm'), array('vtiger_p_edit_cases'));
        $columns = $dbtable->getColumnData($caseApp);
        
        if(isset($caseID) && ! $caseID) {
            $presentation->Render($columns,null,null,'cases');
        } else {
            list($thisbug,$notes) = $caseApp->get($caseID);
            $presentation->Render($columns, $thisbug, $notes, 'cases');
        }
        break;
    case "newnote":
        $access->check_page($user, array('feature_crm'), array('vtiger_p_edit_cases'));
        // First add the new note
        $cases = $caseApp->createNote($_POST['caseID'], $_POST, $_FILES);
        
        //echo $cases . "<br />";

        // broke error checking
        if($caseApp->SoapError) {
            //echo $Comm->getErrorText();
            $access->redirect("solve/" . _MYNAMEIS . "/edit/{$_POST['caseID']}",'There was an error processing your request.');
        }
        $access->redirect("solve/" . _MYNAMEIS . "/edit/{$_POST['caseID']}",'Note saved!');
        break;
    case "error":
        echo $config->getBrokeMessage();
        break;
    case "saveedit":
        $access->check_page($user, array('feature_crm'), array('vtiger_p_edit_cases'));
        if( $_POST['button']=='Save' ) {
            $cases = $caseApp->modify($_POST);
            $access->redirect("solve/" . _MYNAMEIS . "/edit/{$cases['id']}",'Case saved!');
        } else {
            $access->redirect("solve/$option", "New case is cancelled.");
        }
        break;
    case "savenew":
        $access->check_page($user, array('feature_crm'), array('vtiger_p_create_cases'));
        if( $_POST['button']=='Save' ) {
            $cases = $caseApp->create($_POST);
            $access->redirect("solve/" . _MYNAMEIS . "/edit/{$cases['id']}",'Case saved!');
        } else {
            $access->redirect("solve/$option", "New case is cancelled.");
        }
        break;
    case "download":
        $access->check_page($user, array('feature_crm'), array('vtiger_p_view_cases'));
        if(!empty($_REQUEST['noteid'])) {
			$theFile = $caseApp->getNoteAttachment($_REQUEST['moduleid'],$_REQUEST['noteid']);
            $file = base64_decode($theFile['file']);

            $discard = ob_end_clean();
            $content_dispo_header = "Content-Disposition: attachment; filename=\"".$theFile['filename']."\"";

            header($content_dispo_header);
            header("Content-Type: application/force-download");
            header( "Expires: Mon, 26 Jul 1997 05:00:00 GMT" );
            header( "Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT" );
            header("Expires: 0");
            header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
            header("Pragma: public");
            header("Content-Length: ".strlen($file));
			echo $file;
            die();
		} else {
            $access->redirect("solve/$option", "No File To Download.");
        }
        break;
    case "refresh":
		$caseApp->stopSession();
        $caseApp->startSession();
        break;
	case "home":
    default:
header( 'Expires: Mon, 26 Jul 1997 05:00:00 GMT' );

        $access->check_page($user, array('feature_crm'), array('vtiger_p_list_cases'));
        $bugs = $caseApp->getAll();
        
        $columns = $dbtable->getColumnData($caseApp);
        
        //if($caseApp->err) {
            //echo $Comm->getErrorText();
            //return true;
        //}
        
        $presentation->RenderList($bugs, null, $columns, 'home');
        break;
}

$caseApp->logout();

// Session management function
function startCrmSession(&$caseApp) {
    if(!isset($_SESSION)){
        session_start();
    }
    // Check to see if we already have a crm session
    if(isset($_SESSION['crm_session'])){
        $caseApp->setCrmSessionID($_SESSION['crm_session']);
    } else {
        // If not, create one and get going
        $caseApp->createSession();
        $_SESSION['crm_session'] = $caseApp->getCrmSessionID();
    }
}

function stopCrmSession(&$caseApp) {
    if(!isset($_SESSION)){
        session_start();
    }
    if(empty($caseApp->sessionID) && isset($_SESSION['crm_session'])){
        $caseApp->setCrmSessionID($_SESSION['crm_session']);
    }
    $caseApp->closeSession();
    unset($_SESSION['crm_session']);
}

?>

<?php
/**
 * $Header: /cvsroot/tikiwiki/tiki/tiki-admin_integrator_rules.php,v 1.12 2003-11-08 19:50:32 zaufi Exp $
 *
 * Admin interface for rules management
 *
 */

require_once('tiki-setup.php');
require_once('lib/integrator/integrator.php');

// Check permissions
if ($tiki_p_admin_integrator != 'y')
{
    $smarty->assign('msg', tra("You dont have permission to use this feature"));
    $smarty->display("styles/$style_base/error.tpl");
    die;
}

// Setup local variables from request or set default values
$repID       = (isset ($_REQUEST["repID"])
             && strlen($_REQUEST["repID"])  > 0) ? $_REQUEST["repID"]       :  0;
$ruleID      = (isset ($_REQUEST["ruleID"])
             && strlen($_REQUEST["ruleID"]) > 0) ? $_REQUEST["ruleID"]      :  0;
$ord         = (isset ($_REQUEST["ord"])
             && strlen($_REQUEST["ord"])    > 0) ? $_REQUEST["ord"]         :  0;
$srcrep      = (isset ($_REQUEST["srcrep"])
             && strlen($_REQUEST["srcrep"]) > 0) ? $_REQUEST["srcrep"]      :  0;
$srch        =  isset ($_REQUEST["srch"])        ? $_REQUEST["srch"]        : '';
$repl        =  isset ($_REQUEST["repl"])        ? $_REQUEST["repl"]        : '';
$description =  isset ($_REQUEST["description"]) ? $_REQUEST["description"] : '';
$rxmod       =  isset ($_REQUEST["rxmod"])       ? $_REQUEST["rxmod"]       : '';
$file        =  isset ($_REQUEST["file"])        ? $_REQUEST["file"]        : '';
$type        =  isset ($_REQUEST["type"])        ? ($_REQUEST["type"]      == 'on' ? 'y' : 'n')  : 'n';
$casesense   =  isset ($_REQUEST["casesense"])   ? ($_REQUEST["casesense"] == 'on' ? 'y' : 'n')  : 'n';
$code        =  isset ($_REQUEST["code"])        ? ($_REQUEST["code"]      == 'on' ? 'y' : 'n')  : 'n';
$html        =  isset ($_REQUEST["html"])        ? ($_REQUEST["html"]      == 'on' ? 'y' : 'n')  : 'n';
$all         =  isset ($_REQUEST["all"])         ? ($_REQUEST["all"]       == 'on' ? 'y' : 'n')  : 'n';

if (!isset($_REQUEST["repID"]) || $repID <= 0)
{
    $smarty->assign('msg', tra("No repository"));
    $smarty->display("styles/$style_base/error.tpl");
    die;
}
// Check if copy button pressed
if (isset($_REQUEST["copy"]) && ($srcrep > 0))
    $integrator->copy_rules($srcrep, $repID);

// Check if 'save' button pressed ...
if (isset($_REQUEST["save"]))
{
    // ... and all mandatory paramaters r OK
    if (strlen($srch)  > 0)
        $integrator->add_replace_rule($repID, $ruleID, $ord, $srch, $repl,
                                      $type, $casesense, $rxmod, $description);
    else
    {
        $smarty->assign('msg', tra("Search is mandatory field"));
        $smarty->display("styles/$style_base/error.tpl");
        die;
    }
}
// Check if 'preview' button pressed ...
if (isset($_REQUEST["preview"]))
{
    // Prepeare rule data
    $rule = array();
    $rule["repID"]       = $repID;
    $rule["ruleID"]      = $ruleID;
    $rule["ord"]         = $ord;
    $rule["srch"]        = $srch;
    $rule["repl"]        = $repl;
    $rule["type"]        = $type;
    $rule["casesense"]   = $casesense;
    $rule["rxmod"]       = $rxmod;
    $rule["description"] = $description;

    // Reassign values in form
    $smarty->assign('ruleID',      $rule["ruleID"]);
    $smarty->assign('ord',         $rule["ord"]);
    $smarty->assign('srch',        $rule["srch"]);
    $smarty->assign('repl',        $rule["repl"]);
    $smarty->assign('type',        $rule["type"]);
    $smarty->assign('casesense',   $rule["casesense"]);
    $smarty->assign('rxmod',       $rule["rxmod"]);
    $smarty->assign('description', $rule["description"]);

    // Have smth to show?
    if (($html != 'y' || $code != 'y'))
    {
        // Get repository configuration data
        $rep = $integrator->get_repository($repID);
        // Check if file given and present at configured location
        $f = $integrator->get_rep_file($rep, $file);
        if ((substr($rep["path"], 0, 7) != 'http://')
         && (substr($rep["path"], 0, 8) != 'https://')
         && !file_exists($f))
        {
            $smarty->assign('msg', tra("File not found ").$f);
            $smarty->display("styles/$style_base/error.tpl");
            die;
        }
        // Get file content to string
        $data = @file_get_contents($f);
        if (isset($php_errormsg)) $data .= "ERROR: ".$php_errormsg;
        else
        {
            // Should we apply all configured rules or only current one?
            if ($all == 'y')
            {
                $rules = $integrator->list_rules($repID);
                if (is_array($rules))
                    foreach ($rules as $r)
                        if ($r["ruleID"] !== $ruleID)
                            $data = $integrator->apply_rule($rep, $r, $data);
            }
            // Apply rule
            $data = $integrator->apply_rule($rep, $rule, $data);
        }
        $smarty->assign_by_ref('preview_data', $data);
    }
}

// Whether some action requested?
if (isset($_REQUEST["action"]))
{
    switch ($_REQUEST["action"])
    {
    case 'edit':
        if ($ruleID != 0)
        {
            $rule = $integrator->get_rule($ruleID);
            $smarty->assign('ruleID',      $rule["ruleID"]);
            $smarty->assign('ord',         $rule["ord"]);
            $smarty->assign('srch',        $rule["srch"]);
            $smarty->assign('repl',        $rule["repl"]);
            $smarty->assign('type',        $rule["type"]);
            $smarty->assign('casesense',   $rule["casesense"]);
            $smarty->assign('rxmod',       $rule["rxmod"]);
            $smarty->assign('description', $rule["description"]);
        }
        break;
    case 'rm':
        if ($ruleID != 0) $integrator->remove_rule($ruleID);
        break;
    default:
        $smarty->assign('msg', tra("Requested action in not supportted on repository"));
        $smarty->display("styles/$style_base/error.tpl");
        die; break;
    }
}
// Get repository name
$r = $integrator->get_repository($repID);
$smarty->assign('name', $r["name"]);

// Reassign checkboxes
$smarty->assign('file', $file);
$smarty->assign('code', $code);
$smarty->assign('html', $html);
$smarty->assign('all',  $all);

// Fill list of rules
$rules = $integrator->list_rules($repID);
$smarty->assign_by_ref('rules', $rules);
$smarty->assign('repID', $repID);

// Fill list of possible source repositories
$allreps = $integrator->list_repositories(false);
$reps = array();
foreach($allreps as $rep) $reps[$rep["repID"]] = $rep["name"];
$smarty->assign_by_ref('reps', $reps);

// Display the template
$smarty->assign('mid','tiki-admin_integrator_rules.tpl');
$smarty->display("styles/$style_base/tiki.tpl");

?>
<?php
$access->check_script($_SERVER["SCRIPT_NAME"],basename(__FILE__));
$feed = tra("Error Message");
$title = tra("Tiki RSS Feed Error Message: $errmsg");
$desc = $errmsg;
$id = "errorMessage";
$titleId = "title";
$descId = "description";
$dateId = "lastModif";
$authorId = "";
$readrepl = "";
$uniqueid=$feed;

$changes=array("data"=>array());

$output = $rsslib->generate_feed($feed, $uniqueid, '', $changes, $readrepl, '', $id, $title, $titleId, $desc, $descId, $dateId, $authorId);

header("Content-type: ".$output["content-type"]);
print $output["data"];

die;
?>

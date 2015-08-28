<?php
/**
* Download page
*/

$page = 'survey-and-methodology';

require("../common.php");

//read download.md
include('../Parsedown.php');
$mdurl = TEXT_URL . lang($page) . "/survey-and-methodology/survey-and-methodology.md";
$contents = file_get_contents($mdurl);
$Parsedown = new Parsedown();
$smarty->assign('main_text',$Parsedown->text($contents));

$smarty->display($page . '.tpl');

?>

<?php
/**
* Download page
*/

$page = 'survey-and-methodology';

require("../../inc/common.php");

//read download.md
include('../../inc/Parsedown.php');
$mdurl = TEXT_URL . lang($page) . "/survey-and-methodology/survey-and-methodology.md";
$contents = file_get_contents($mdurl);
$Parsedown = new Parsedown();
$smarty->assign('main_text',$Parsedown->text($contents));

$smarty->display($page . '.tpl');

?>

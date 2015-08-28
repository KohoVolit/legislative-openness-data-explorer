<?php
/**
* Download page
*/

$page = 'about';

require("../common.php");

//read download.md
include('../Parsedown.php');
$mdurl = TEXT_URL . lang($page) . "/about/about.md";
$contents = file_get_contents($mdurl);
$Parsedown = new Parsedown();
$smarty->assign('main_text',$Parsedown->text($contents));

$smarty->display($page . '.tpl');

?>

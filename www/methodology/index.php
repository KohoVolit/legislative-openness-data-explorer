<?php
/**
* Download page
*/

$page = 'methodology';

require("../common.php");

//read download.md
include('../Parsedown.php');
$mdurl = TEXT_URL . lang($page) . "/methodology/methodology.md";
$contents = file_get_contents($mdurl);
$Parsedown = new Parsedown();
$smarty->assign('main_text',$Parsedown->text($contents));

$smarty->display($page . '.tpl');

?>

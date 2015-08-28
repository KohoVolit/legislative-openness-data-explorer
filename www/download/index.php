<?php
/**
* Download page
*/

$page = 'download';

require("../common.php");

//read download.md
include('../Parsedown.php');
$mdurl = TEXT_URL . lang($page) . "/download/download.md";
$contents = file_get_contents($mdurl);
$Parsedown = new Parsedown();
$smarty->assign('mid_text',$Parsedown->text($contents));

$smarty->display($page . '.tpl');

?>

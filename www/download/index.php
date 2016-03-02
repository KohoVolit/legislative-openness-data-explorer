<?php
/**
* Download page
*/

$relative_path = "../";
require($relative_path . 'settings.php');

include ($relative_path . "cache.php");

$page = 'download';

require($relative_path . "common.php");

//read download.md
include($relative_path . 'Parsedown.php');
$mdurl = TEXT_URL . lang($page) . "/download/download.md";
$contents = file_get_contents($mdurl);
$Parsedown = new Parsedown();
$smarty->assign('mid_text',$Parsedown->text($contents));

//source files
$smarty->assign('csv_link',SOURCE);
$smarty->assign('xlsx_link',str_replace('output=csv','output=xlsx',SOURCE));


$smarty->display($page . '.tpl');

?>

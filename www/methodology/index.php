<?php
/**
* Download page
*/

$relative_path = "../";
require($relative_path . 'settings.php');

include ($relative_path . "cache.php");

$page = 'methodology';
$relative_path = "../";

require($relative_path . "common.php");

//read download.md
include($relative_path . 'Parsedown.php');
$mdurl = TEXT_URL . lang($page) . "/methodology/methodology.md";
$contents = file_get_contents($mdurl);
$Parsedown = new Parsedown();
$smarty->assign('main_text',$Parsedown->text($contents));

$smarty->display($page . '.tpl');

?>

<?php
/**
* Download page
*/

$relative_path = "../";
require($relative_path . 'settings.php');

include ($relative_path . "cache.php");

$page = 'good-practices';

require($relative_path . "common.php");

$best_practices = best_practices($page);
#print_r($best_practices['examples']);die();

$smarty->assign('categories',$best_practices['categories']);
$smarty->assign('examples',$best_practices['examples']);
$smarty->assign('filter',$best_practices['filter']);
$smarty->assign('relative_path',$relative_path);
$smarty->display($page . '.tpl');

?>

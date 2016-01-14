<?php
/**
* Download page
*/

$page = 'good-practices';

require("../common.php");

$best_practices = best_practices($page);
#print_r($best_practices['examples']);die();

$smarty->assign('categories',$best_practices['categories']);
$smarty->assign('examples',$best_practices['examples']);
$smarty->assign('filter',$best_practices['filter']);
$smarty->display($page . '.tpl');

?>

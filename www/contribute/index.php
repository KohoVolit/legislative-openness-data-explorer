<?php
/**
* Download page
*/

$relative_path = "../";
require($relative_path . 'settings.php');

include ($relative_path . "cache.php");

$page = 'contribute';

require($relative_path . "common.php");

$smarty->assign('relative_path',$relative_path);

$smarty->display($page . '.tpl');

?>

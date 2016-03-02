<?php
/**
* Download page
*/

$relative_path = "../";
require($relative_path . 'settings.php');

include ($relative_path . "cache.php");

$page = 'contribute';

require($relative_path . "common.php");

$smarty->display($page . '.tpl');

?>

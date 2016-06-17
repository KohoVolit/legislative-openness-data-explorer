<?php

/**
* Updates parliaments, questions and data at the server
* Note: directory inc/ MUST be writable by the web server (www-data)
*/

$page = 'generate-texts';

$relative_path = "";
require($relative_path . 'settings.php');

require($relative_path . "common.php");

$tmp = system("python3 " . APP_PATH . "helpers/data_translation.py");
// echo "python3 " . APP_PATH . "helpers/data_translation.py";
// print_r($tmp);die();


$smarty->assign('relative_path',$relative_path);

$smarty->display($page . '.tpl');

?>

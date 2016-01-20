<?php

/**
* Updates parliaments, questions and data at the server
* Note: directory inc/ MUST be writable by the web server (www-data)
*/

$page = 'update';

require("common.php");

$tmp = system("python3 " . APP_PATH . "inc/source2parliaments.py");

$tmp = system("python3 " . APP_PATH . "inc/source2questions.py");

$tmp = system("python3 " . APP_PATH . "inc/source2data.py");

$smarty->display($page . '.tpl');

?>

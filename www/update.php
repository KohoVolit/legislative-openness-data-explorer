<?php

/**
* Updates parliaments, questions and data at the server
* Note: directory inc/ MUST be writable by the web server (www-data)
*/

$page = 'update';

$relative_path = "";
require($relative_path . 'settings.php');

$tmp = system("python3 " . APP_PATH . "inc/source2parliaments.py");

$tmp = system("python3 " . APP_PATH . "inc/source2questions.py");

$tmp = system("python3 " . APP_PATH . "inc/source2data.py");

//clear cache
$files = glob(APP_PATH . '/www/cache/*'); // get all file names
foreach($files as $file){ // iterate files
  if(is_file($file))
    unlink($file); // delete file
}

$smarty->display($page . '.tpl');

?>

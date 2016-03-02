<?php
/**
* Clears cache
* Note: directory www/cache/ MUST be writable by the web server (www-data)
*/

$page = 'clear-cache';

$relative_path = "";
require($relative_path . 'settings.php');

require($relative_path . "common.php");

//clear cache
$files = glob(APP_PATH . '/www/cache/*'); // get all file names
foreach($files as $file){ // iterate files
  if(is_file($file))
    unlink($file); // delete file
}

$smarty->assign('relative_path',$relative_path);

$smarty->display($page . '.tpl');

?>

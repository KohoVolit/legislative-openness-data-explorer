<?php
/**
* Common code and functions
*/

/**
* common code
*/

error_reporting(E_ALL);
//error_reporting(0);

require('settings.php');

//set up Smarty
require(SMARTY_PATH);
$smarty = new Smarty();
$smarty->setTemplateDir(APP_PATH . 'smarty/templates');
$smarty->setCompileDir(APP_PATH . 'smarty/templates_c');

//get language
$lang = lang($page);
$smarty->assign('lang',$lang);

//include texts
    //page specific
$handle = fopen(TEXT_PATH . $lang . DIRECTORY_SEPARATOR . $page . DIRECTORY_SEPARATOR . 'texts.csv', "r");
$texts_specific = csv2array($handle);
    //meta
$handle = fopen(TEXT_PATH . $lang . DIRECTORY_SEPARATOR . 'meta' . DIRECTORY_SEPARATOR . 'texts.csv', "r"); 
$texts_meta = csv2array($handle);
    //header
$handle = fopen(TEXT_PATH . $lang . DIRECTORY_SEPARATOR . 'header' . DIRECTORY_SEPARATOR . 'texts.csv', "r"); 
$texts_header = csv2array($handle);
    //join 
$smarty->assign('t',array_merge($texts_header,array_merge($texts_specific,$texts_meta)));

//create header
$i = 0;
$header = [];
foreach($texts_header as $k=>$row) {
    if ($i > 0){
        $header[] = $row;
    }
    $i++;
}
$smarty->assign('header',$header);

//
$smarty->assign('app_url',APP_URL);

//include 

//print_r(csv2array($handle));

/**
* creates correct link
*/
#function link($page,$link) {
##    if ($page == 'frontpage')
##        $chunk = '';
##    else
##        $chunk = $page . DIRECTORY_SEPARATOR;
#    $out = APP_URL . $link;
#    return $out;
#}

/**
* set language
*/
function lang($page) {
    if (isset($_GET['lang']) and (is_readable(TEXT_PATH . $_GET['lang'] . $page . DIRECTORY_SEPARATOR . 'texts.csv')))
        return $_GET['lang'];
    else //default language
        return 'en';
}

/**
* reads csv file into associative array
* 
*/
function csv2array($handle, $pre = "") {
    $array = $fields = [];
    if ($handle) {
        while (($row = fgetcsv($handle, 4096)) !== false) {
            if (empty($fields)) {
                $fields = $row;
                continue;
            }
            foreach ($row as $k=>$value) {
                $array[$row[0]][$pre.$fields[$k]] = $value;
            }
        }
        if (!feof($handle)) {
            /*echo "Error: unexpected fgets() fail\n";*/
        }
    } 
    return $array;  
}

/**
* joining paths
*/
?>


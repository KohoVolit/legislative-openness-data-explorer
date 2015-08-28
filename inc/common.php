<?php
/**
* Common code and functions
*/

/**
* common code
*/

error_reporting(E_ALL);
//error_reporting(0);

session_start();

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
$header = [];
foreach($texts_header as $k=>$row) {
    $header[] = $row;
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
    if (isset($_GET['lang']) and (is_readable(TEXT_PATH . $_GET['lang'] . DIRECTORY_SEPARATOR . $page . DIRECTORY_SEPARATOR . 'texts.csv')))
        {
            $_SESSION["lang"] = $_GET['lang'];
            return $_GET['lang'];
        }
    else 
        {
        if (isset($_SESSION['lang']))
            return $_SESSION['lang'];
        else //default language
            return 'en';
        }
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

/**
* FUNCTIONS FOR BEST PRACTICES
*/
function best_practices($page) {
    //read categories
    $lang = lang($page);
    $handle = fopen(TEXT_PATH . $lang . DIRECTORY_SEPARATOR . 'meta' . DIRECTORY_SEPARATOR . 'categories.csv', "r"); 
    $categories = csv2array($handle);

    //read and sort list of examples
    $handle = fopen(TEXT_PATH . $lang . DIRECTORY_SEPARATOR . $page . DIRECTORY_SEPARATOR . 'examples.csv', "r"); 
    $examples = csv2array($handle);
    foreach ($examples as $key => $row)
        $s[$key]  =  (float) $row['weight'];
    array_multisort($s, SORT_ASC, $examples);

    //read examples, parse categories
    include('Parsedown.php');
    $Parsedown = new Parsedown();
    foreach($examples as $key => $example) {
        $url = TEXT_PATH . $lang . DIRECTORY_SEPARATOR . $page . DIRECTORY_SEPARATOR .  'examples' . DIRECTORY_SEPARATOR . $example['code'] . '.md';
        if (is_readable($url)) {
            $contents = file_get_contents($url);
            $parsed = parse_text($Parsedown->text($contents));
            $examples[$key]['text'] = $parsed['text'];
            $examples[$key]['header'] = $parsed['header'];
            $examples[$key]['teaser'] = $parsed['teaser'];
            $examples[$key]['rest'] = $parsed['rest'];
            
            $examples[$key]['categories'] = parse_categories($examples[$key]['categories'],$categories);
        } else {
            unset($examples[$key]);
        }
    }

    //filter category
    $filter = false;
    if (isset($_GET['category'])) {
        if (isset($categories[$_GET['category']])) {
            foreach ($examples as $key=>$example) {
                $in = false;
                foreach($example['categories'] as $cat) {
                    if($cat == $_GET['category'])
                        $in = true;
                }
                if (!$in)
                    unset($examples[$key]);
            }
            $filter = $categories[$_GET['category']];
        }
    }
    $out = [
        'categories' => $categories,
        'examples' => $examples,
        'filter' => $filter
    ];
    return $out;
}

function parse_categories($text,$categories) {
    $out = explode(';',$text);
    foreach ($out as $key=>$row) {
        if (!isset($categories[$row]))
            unset($out[$key]);
    }
    return $out;
}

// parses text of an example into array
function parse_text($html) {
    $out = [];
    $ar = explode("</",$html);
    $out['header'] = trim(substr(trim($ar[0]),4));
    $ar = explode('<p>',$html);
    $out['teaser'] = trim(substr(trim($ar[1]),0,-4));
    array_shift($ar);
    array_shift($ar);
    $out['rest'] = '<p>'.implode('<p>',$ar);
    $out['text'] = $html;
    return $out;
}

?>


<?php
/**
* Download page
*/

$page = 'best-practices';

require("../../inc/common.php");

//read categories
$handle = fopen(TEXT_PATH . $lang . DIRECTORY_SEPARATOR . 'meta' . DIRECTORY_SEPARATOR . 'categories.csv', "r"); 
$categories = csv2array($handle);

//read and sort list of examples
$handle = fopen(TEXT_PATH . $lang . DIRECTORY_SEPARATOR . $page . DIRECTORY_SEPARATOR . 'examples.csv', "r"); 
$examples = csv2array($handle);
foreach ($examples as $key => $row)
    $s[$key]  =  (float) $row['weight'];
array_multisort($s, SORT_ASC, $examples);

//read examples, parse categories
include('../../inc/Parsedown.php');
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

#print_r($s);
#print_r($categories);print_r($examples);die();

$smarty->assign('categories',$categories);
$smarty->assign('examples',$examples);
$smarty->assign('filter',$filter);
$smarty->display($page . '.tpl');

// parses categories into array
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

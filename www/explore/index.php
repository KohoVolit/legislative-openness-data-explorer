<?php
/**
* Download page
*/

$page = 'explore';

require("../../inc/common.php");

//read data and questions
$questions = json_decode(file_get_contents(APP_PATH . "inc/questions.json"));
$data = json_decode(file_get_contents(APP_PATH . "inc/data.json"));

//read categories
$handle = fopen(TEXT_PATH . $lang . DIRECTORY_SEPARATOR . 'meta' . DIRECTORY_SEPARATOR . 'categories.csv', "r"); 
$categories = csv2array($handle);

//filter questions
foreach($questions as $key=>$question) {
    if ($question->category == '')
        unset($questions->$key);
}

//read download.md
#include('../../inc/Parsedown.php');
#$mdurl = TEXT_URL . lang($page) . "/download/download.md";
#$contents = file_get_contents($mdurl);
#$Parsedown = new Parsedown();
#$smarty->assign('mid_text',$Parsedown->text($contents));

#print_r($categories);print_r($questions);die();

$pars = ['p','q','c','cc'];
foreach ($pars as $par) {
    if (!isset($_GET[$par]))
        $_GET[$par] = [];
}

$smarty->assign('get',$_GET);
$smarty->assign('categories',$categories);
$smarty->assign('data',$data);
$smarty->assign('questions',$questions);

$smarty->display($page . '.tpl');

?>

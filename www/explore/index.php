<?php
/**
* Download page
*/

$relative_path = "../";
require($relative_path . 'settings.php');

include ($relative_path . "cache.php");

$page = 'explore';

require($relative_path . "common.php");

//read data
$questions = json_decode(file_get_contents(APP_PATH . "inc/questions.json"));
$categories = json_decode(file_get_contents(APP_PATH . "inc/categories.json"));
$data = json_decode(file_get_contents(APP_PATH . "inc/data.json"));
$parliaments = json_decode(file_get_contents(APP_PATH . "inc/parliaments.json"));
//echo (microtime(true) - $start . "<br>");die();

// prepare parliaments for dialog
$parliaments_ar = parliaments4dialog($parliaments);
$regions = array_keys($parliaments_ar);

// prepare questions/categories for dialog
$questions_ordered = prepare_questions($questions);
$categories_used_codes = array_keys($questions_ordered);
$categories_used = prepare_categories($categories_used_codes,$categories);


// ensure that GET parameters are arrays
$pars = ['p','q','c','cc'];
foreach ($pars as $par) {
    if (!isset($_GET[$par]))
        $_GET[$par] = [];
    else {
        if (!is_array($_GET[$par]))
            $_GET[$par] = [$_GET[$par]];
    }
}

//filter and sort parliaments
$parliaments_selected = filter_parliaments($parliaments);
usort($parliaments_selected, 'compare_countries');

//filter and sort questions
#print_r($questions);die();
$questions_selected = filter_questions($questions);
#print_r($questions_selected);die();
usort($questions_selected, 'compare_weights');
usort($questions_selected, 'compare_category_weights');

//ensure GET[rot] is ok
if (!(isset($_GET['rot']) and (in_array($_GET['rot'],[1,2])))) {
    if(count($questions_selected)>=count($parliaments_selected))
        $_GET['rot'] = 2;
    else
        $_GET['rot'] = 1;
    $force_rot = false;
} else
    $force_rot = true;
//select data
$data_selected = select_data($data,$parliaments_selected,$questions_selected);


//get best practices
$best_practices = best_practices('good-practices');

//read info.md
//include('../Parsedown.php');
$mdurl = TEXT_URL . lang($page) . "/explore/info.md";
$contents = file_get_contents($mdurl);
$Parsedown = new Parsedown();

$smarty->assign('info_text',ltrim($Parsedown->text($contents),'<p>'));


//filters data by parameters cc and p
//$data = filter_data($data,$questions,$_GET);

//filter questions, put into array and sort them
//$questions_order = filter_questions($questions);

#print_r($data_selected);die();
#print_r($questions_selected);die();



$smarty->assign('get',$_GET);
$smarty->assign('query_string',$_SERVER['QUERY_STRING']);
$smarty->assign('force_rot',$force_rot);
$smarty->assign('parliaments',$parliaments_ar);
$smarty->assign('regions',$regions);
$smarty->assign('questions',$questions_ordered);
$smarty->assign('categories',$categories);
$smarty->assign('data_selected',$data_selected);
$smarty->assign('parliaments_selected',$parliaments_selected);
$smarty->assign('questions_selected',$questions_selected);

$smarty->assign('bp_categories',$best_practices['categories']);
$smarty->assign('bp_examples',$best_practices['examples']);
#$smarty->assign('bp_filter',$best_practices['filter']);


$smarty->display($page . '.tpl');





#function compare_regions($a, $b) { 
#    if($a->region == $b->region) {
#        return 0;
#    } 
#    return ($a->region < $b->region) ? -1 : 1;
#}



?>

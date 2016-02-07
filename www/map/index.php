<?php
/**
* Map page
*/

$page = 'map';

require("../common.php");

//read data
$questions = json_decode(file_get_contents(APP_PATH . "inc/questions.json"));
$categories = json_decode(file_get_contents(APP_PATH . "inc/categories.json"));
$data = json_decode(file_get_contents(APP_PATH . "inc/data.json"));
$parliaments = json_decode(file_get_contents(APP_PATH . "inc/parliaments.json"));

// prepare parliaments for dialog
$parliaments_ar = parliaments4dialog($parliaments);
$regions = array_keys($parliaments_ar);

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

$selected_countries = selected_countries($parliaments_selected);

// prepare questions/categories (add weight)
$questions_ordered = prepare_questions($questions);
$categories_used_codes = array_keys($questions_ordered);
$categories_used = prepare_categories($categories_used_codes,$categories);

//filter and sort questions
$questions_selected = filter_questions($questions);
usort($questions_selected, 'compare_weights');
usort($questions_selected, 'compare_category_weights');

//get 1st question only:
foreach ($questions_selected as $qs) {
    $question_id = $qs->id;
    break;
}

//select data
$data_selected = select_data($data,$parliaments_selected,$questions_selected);

//add color to selected countries
foreach ($parliaments_selected as $key => $ps) {
    $country_code = $ps->country_code;
    if (isset($selected_countries[$country_code]['color'])) {
        if (isset($question_id) and (isset($data_selected[$ps->id][$question_id]->value))) {
            if (min($data_selected[$ps->id][$question_id]->value, $selected_countries[$country_code]['color']) > 0)
                $selected_countries[$country_code]['color'] = min($data_selected[$ps->id][$question_id]->value, $selected_countries[$country_code]['color']);
            else 
                $selected_countries[$country_code]['color'] = max($data_selected[$ps->id][$question_id]->value, $selected_countries[$country_code]['color']);
        }
    } else {
        if (isset($question_id) and (isset($data_selected[$ps->id][$question_id]->value)))
            $selected_countries[$country_code]['color'] = $data_selected[$ps->id][$question_id]->value;
        else
            $selected_countries[$country_code]['color'] = 0;
    }
    //print_r($data_selected[$ps->id]);die();
}

//title
if (isset($question_id) and isset($questions->$question_id))
    $title = $questions->$question_id->question;
else
    $title = '';

$smarty->assign('title',$title);
$smarty->assign('get',$_GET);
#$smarty->assign('force_rot',$force_rot);
$smarty->assign('parliaments',$parliaments_ar);
$smarty->assign('regions',$regions);
$smarty->assign('questions',$questions_ordered);
$smarty->assign('categories',$categories);
$smarty->assign('data_selected',$data_selected);
$smarty->assign('parliaments_selected',$parliaments_selected);
$smarty->assign('questions_selected',$questions_selected);
$smarty->assign('countries',json_encode($selected_countries));

#$smarty->assign('bp_categories',$best_practices['categories']);
#$smarty->assign('bp_examples',$best_practices['examples']);
#$smarty->assign('bp_filter',$best_practices['filter']);


$smarty->display($page . '.tpl');

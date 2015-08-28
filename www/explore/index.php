<?php
/**
* Download page
*/
#$start = microtime(true);
$page = 'explore';

require("../../inc/common.php");

//read data
$questions = json_decode(file_get_contents(APP_PATH . "inc/questions.json"));
$categories = json_decode(file_get_contents(APP_PATH . "inc/categories.json"));
$data = json_decode(file_get_contents(APP_PATH . "inc/data.json"));
$parliaments = json_decode(file_get_contents(APP_PATH . "inc/parliaments.json"));

#echo (microtime(true) - $start . "<br>");

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
$questions_selected = filter_questions($questions);
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
$best_practices = best_practices('best-practices');




//filters data by parameters cc and p
//$data = filter_data($data,$questions,$_GET);

//filter questions, put into array and sort them
//$questions_order = filter_questions($questions);

#print_r($data_selected);die();



$smarty->assign('get',$_GET);
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

//select data for table
function select_data($data,$parliaments_selected,$questions_selected) {
    $data_selected = [];
    foreach($parliaments_selected as $p) {
        $row = [];
        $p_id = $p->id;
        foreach($questions_selected as $q) {
            $q_id = $q->id;
            $row[$q->id] = $data->$p_id->$q_id;
        }
        $data_selected[$p->id] = $row;
    }
    return $data_selected;
}



// prepares parliaments for dialog
function parliaments4dialog($parliaments) {
    $parliaments_ar = [];
    foreach($parliaments as $row) {
        if (!isset($parliaments_ar[$row->region]))
            $parliaments_ar[$row->region] = [];
        $parliaments_ar[$row->region][] = $row;
    }
    ksort($parliaments_ar);
    foreach($parliaments_ar as $k=>$region) {
        usort($parliaments_ar[$k], 'compare_countries');
    }
    return $parliaments_ar;
}



#function compare_regions($a, $b) { 
#    if($a->region == $b->region) {
#        return 0;
#    } 
#    return ($a->region < $b->region) ? -1 : 1;
#}
function compare_countries($a, $b) { 
    if($a->country == $b->country) {
        return 0;
    } 
    return ($a->country < $b->country) ? -1 : 1;
}

// filter questions according to $_GET['q'] and $_GET['c']
function filter_questions($questions) {
    $out = [];
    if ((count($_GET['q']) == 0) and (count($_GET['c']) == 0))
        $dontfilter = true;
    else
        $dontfilter = false;
    foreach ($questions as $question) {
        if ($question->category_code != "") {
            if ($dontfilter)
                $out[$question->id] = $question;
            else {
                if (in_array($question->id,$_GET['q']))
                    $out[$question->id] = $question;
                else {
                    if ((in_array($question->category_code,$_GET['c'])) and ($question->category_code != ''))
                        $out[$question->id] = $question;
                }
            }
        }
    } 
    return $out;
}


// filters parliaments according to $_GET['p'] and $_GET['cc']
function filter_parliaments($parliaments) {
    $out = [];
    if ((count($_GET['p']) == 0) and (count($_GET['cc']) == 0))
        $dontfilter = true;
    else
        $dontfilter = false;
    foreach ($parliaments as $parliament) {
        if ($dontfilter)
            $out[$parliament->id] = $parliament;
        else {
            if (in_array($parliament->id,$_GET['p']))
                $out[$parliament->id] = $parliament;
            else {
                if (in_array($parliament->country_code,$_GET['cc']))
                    $out[$parliament->id] = $parliament;
            }
        }
    } 
    return $out;
}

//filter questions and sort them
//produces array 
function prepare_questions($questions) {
    $out = [];
    $sort = [];
    //filter out questions without category, add them to $out by category
    foreach($questions as $key=>$question) {
        if ($question->category_code != '') {
            if (!isset($out[$question->category_code]))
                $out[$question->category_code] = [];
            $out[$question->category_code][] = $question;
            $sort[$question->category_code] = $question->category_weight;
        }
    }
    array_multisort($sort, SORT_ASC, $out);
    foreach($out as $k=>$category) {
        usort($out[$k], 'compare_weights');
    }
    return $out;
    $out = [];
}

function compare_weights($a, $b) { 
    if($a->weight == $b->weight) {
        return 0;
    } 
    return ($a->weight < $b->weight) ? -1 : 1;
}

function compare_category_weights($a, $b) { 
    if($a->category_weight == $b->category_weight) {
        return 0;
    } 
    return ($a->category_weight < $b->category_weight) ? -1 : 1;
}

// prepare categories for dialog
function prepare_categories($codes,$categories) {
    $out = [];
    foreach ($codes as $code) 
        $out[] = $categories->$code;
    return $out;
}

?>

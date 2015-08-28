<?php
/**
* Front page
*/

$page = 'front-page';

require("common.php");

//get countries
$parliaments = json_decode(file_get_contents(APP_PATH . "inc/parliaments.json"));
$selected_countries = selected_countries($parliaments);
//get categories
$categories = json_decode(file_get_contents(APP_PATH . "inc/categories.json"));
$categories_sorted = sort_categories($categories);

//read jumbo.md
include('Parsedown.php');
$mdurl = TEXT_URL . lang($page) . "/front-page/jumbo.md";
$contents = file_get_contents($mdurl);
$Parsedown = new Parsedown();

$smarty->assign('countries',json_encode($selected_countries));
$smarty->assign('categories',$categories_sorted);
$smarty->assign('jumbo_text',ltrim($Parsedown->text($contents),'<p>'));

$smarty->display($page . '.tpl');


function selected_countries($parliaments) {
    $out = [];
    foreach ($parliaments as $p) {
        $out[$p->country_code] = ["name"=>$p->country,"code"=>$p->country_code];
    }
    return $out;
}

function sort_categories($categories) {
    $out = [];
    foreach ($categories as $c) 
        $out[] = $c;
    usort($out, 'compare_weights');
    return $out;
}

function compare_weights($a, $b) { 
    if($a->weight == $b->weight) {
        return 0;
    } 
    return ($a->weight < $b->weight) ? -1 : 1;
}

?>

<?php
/**
* Common code and functions
*/

/**
* common code
*/


session_start();

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

$smarty->assign('page',$page);

//set theme
$themes = ['readable','cerulean','cosmo','custom','cyborg','darkly','flatly','journal','lumen', 'paper','readable','sandstone','simplex','slate','spacelab','superhero','united', 'yeti'];
if (isset($_GET['theme']) and in_array($_GET['theme'],$themes)) {
    $smarty->assign('bootswatch',$_GET['theme']);
} else {
    $smarty->assign('bootswatch',$themes[0]);
}   

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

        $file_headers = @get_headers($url);
        if(strpos($file_headers[0], '404')) {
            $exists = false;
        }
        else {
            $exists = true;
        }
        if ($exists) {
            $contents = file_get_contents($url);
            $parsed = parse_text($Parsedown->text($contents));
            $examples[$key]['text'] = $parsed['text'];
            $examples[$key]['header'] = $parsed['header'];
            $examples[$key]['teaser'] = $parsed['teaser'];
            $examples[$key]['rest'] = $parsed['rest'];
            $examples[$key]['body'] = $parsed['body'];
            
            $examples[$key]['categories'] = parse_categories($examples[$key]['categories'],$categories);
        } else {
            unset($examples[$key]);
        }
    }

    //filter category
    $filter = false;
    $get_category = false;
    if (!isset($_GET['category'])) {
        if (isset($_GET['c']))
            $get_category = $_GET['c'];
    } else
        $get_category = [$_GET['category']];
    
    if ($get_category) {
        foreach ($examples as $key=>$example) {
            $in = false;
            foreach($example['categories'] as $cat) {
                if (in_array($cat, $get_category))
                    $in = true;
            }
            if (!$in)
                unset($examples[$key]);
        }
        foreach ($get_category as $gc) {
            $filter[] = $categories[$gc];
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
        $out[$key] = trim($out[$key]);
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
    $out['body'] = implode('<p>',$ar);
    array_shift($ar);
    $out['rest'] = '<p>'.implode('<p>',$ar);
    $out['text'] = $html;
    return $out;
}

/**
FUNCTIONS FOR EXPLORE and MAP
*/

function compare_countries($a, $b) { 
    if($a->country == $b->country) {
        return 0;
    } 
    return ($a->country < $b->country) ? -1 : 1;
}


//select data for table or map
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

// filter questions according to $_GET['q'] and $_GET['c']
function filter_questions($questions) {
    $out = [];
    if ((count($_GET['q']) == 0) and (count($_GET['c']) == 0))
        $dontfilter = true;
    else
        $dontfilter = false;
    foreach ($questions as $question) {
        if (isset($question->categories)) {
            if ($dontfilter)
                $out[$question->id] = $question;
            else {
                if (in_array($question->id,$_GET['q']))
                    $out[$question->id] = $question;
                else {
                    foreach ($question->categories->codes as $code) {
                        if ((in_array($code,$_GET['c'])) and ($_GET['q'] != ''))
                            $out[$question->id] = $question;
                    }
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
        if (isset($question->categories)) {
            $code = $question->categories->codes[0];
            if (!isset($out[$code]))
                $out[$code] = [];
            $out[$code][] = $question;
            $sort[$code] = $question->categories->weight;
            $questions->$key->weight = $questions->$key->categories->weight;
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


function selected_countries($parliaments) {
    $out = [];
    foreach ($parliaments as $p) {
        $out[$p->country_code] = ["name"=>$p->country,"code"=>$p->country_code];
    }
    return $out;
}


// prepare categories for dialog
function prepare_categories($codes,$categories) {
    $out = [];
    foreach ($codes as $code) 
        $out[] = $categories->$code;
    return $out;
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

?>


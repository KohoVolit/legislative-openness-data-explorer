<?php
/**
* Download page
*/

$relative_path = "../";
require($relative_path . 'settings.php');

include ($relative_path . "cache.php");

$page = 'about';

require($relative_path . "common.php");

//read download.md
include($relative_path . 'Parsedown.php');
$mdurl = TEXT_URL . lang($page) . "/about/about.md";
$contents = file_get_contents($mdurl);
$Parsedown = new Parsedown();
$main_text = $Parsedown->text($contents);


//prepare headers for menu
$text_ar = explode("\n",$Parsedown->text($contents));
$levels = [];
$hs = [];
foreach($text_ar as $key=>$row) {
    for ($level = 2; $level <= 6; $level++) {
        $m = preg_match("#<h$level>(.*?)</h$level>#",$row,$match);
        if ($m) {
            $levels[$level] = $level;
            $hs[] = [
                "level" => $level,
                "header" => $match[1],
            ];
            $slug = slugify($match[1]);
            $text_ar[$key] = "<a name='$slug' id='$slug' class='h$level'>".$match[0]."</h$level></a>";
        }
    }
}
$smarty->assign('main_text',implode("\n",$text_ar));

asort($levels);
$h2level = [];
$i = 0;
foreach($levels as $key => $l) {
    $h2level[$key] = $i;
    $i++;
}
$current = 0;
$headers = [];
$i = 0;
foreach($hs as $h) {
    if ($h2level[$h["level"]] == 0) {
        $headers[$i] = [
            "header" => $h["header"],
            "slug" => slugify($h["header"]),
            "children" => []
        ];
        $i++;
    }
    if ($h2level[$h["level"]] == 1) {
        $headers[$i-1]['children'][] = [
            "header" => $h["header"],
            "slug" =>slugify($h["header"])
        ];
    }
}

$smarty->assign('headers',$headers);

$smarty->assign('relative_path',$relative_path);

$smarty->display($page . '.tpl');





function slugify($text)
{ 
  // replace non letter or digits by -
  $text = preg_replace('~[^\\pL\d]+~u', '-', $text);

  // trim
  $text = trim($text, '-');

  // transliterate
  $text = iconv('utf-8', 'us-ascii//TRANSLIT', $text);

  // lowercase
  $text = strtolower($text);

  // remove unwanted characters
  $text = preg_replace('~[^-\w]+~', '', $text);

  if (empty($text))
  {
    return 'n-a';
  }

  return $text;
}

?>

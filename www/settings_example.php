<?php
/**
* Settings of the application
*/


//error_reporting(E_ALL);
error_reporting(0);

//full path to Smarty.class.php
const SMARTY_PATH = "/usr/local/lib/php/Smarty/Smarty.class.php";

//full path to the application
const APP_PATH = "/home/michal/project/legislative-openness-data-explorer/";

//full path to the texts
const TEXT_PATH = "/home/michal/project/legislative-openness-data-explorer-texts/";

//url of the application
const APP_URL = "http://localhost/michal/project/legislative-openness-data-explorer/www/";

//url of the texts
const TEXT_URL = "https://raw.githubusercontent.com/KohoVolit/legislative-openness-data-explorer-texts/master/";

//cache time in hours
const CACHE_TIME = 1000;

//data source (google csv file)
const SOURCE = "https://docs.google.com/spreadsheet/ccc?key=1iABzv1hjXP0Ky9Jm_tggyfLzU_B0s0RiCy_nOkGBMAg&output=csv"

// available languages
$LANGUAGES = [
    'en' => 'English',
    'es' => 'Español'
]

?>

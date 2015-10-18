<!DOCTYPE html>
<html lang="{$t['iso_lang']['text']}">

  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="{$t['website_description']['text']}">
    <meta name="keywords" content="{$t['website_keywords']['text']}">
    <meta name="author" content="{$t['website_author']['text']}">
    <link type="image/x-icon" href="/images/favicon.ico" rel="shortcut icon">
    
    <meta property="og:image" content="{$t['og:image']['text']}"/>
	<meta property="og:title" content="{$t['og:title']['text']}"/>
	<meta property="og:url" content="{$t['og:url']['text']}"/>
	<meta property="og:site_name" content="{$t['og:site_name']['text']}"/>
	<meta property="og:type" content="website"/>

{*    <link href="//maxcdn.bootstrapcdn.com/bootswatch/3.3.5/spacelab/bootstrap.min.css" rel="stylesheet">*}
{*    <link href="//netdna.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css" rel="stylesheet">*}
{*    <link href="{$app_url}libs/bootstrap.min.css" rel="stylesheet">*}
    <link href="//cdn.bootcss.com/bootswatch/3.3.5/{$bootswatch}/bootstrap.min.css" rel="stylesheet">
    <link href="{$app_url}libs/font-awesome.min.css" rel="stylesheet">
    <link href="{$app_url}project.css" rel="stylesheet">
    <script src="{$app_url}libs/jquery-1.11.3.min.js"></script>
    <script src="{$app_url}libs/bootstrap.min.js"></script>
{*    <script src="//code.jquery.com/jquery-1.11.3.min.js"></script>*}
{*    <script src="//netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>*}
{*    <script src="../jquery.stickytableheaders.min.js"></script>*}
    <title>{$t['title']['text']}</title>
    
    {block name=additionalHead}{/block} 
    
    {block name=lastHead}{/block}
  </head>
  <body>
    {include "header.tpl"}
    
    <div class="container">
        <!-- Page Content -->
        {block name=body}{/block}
        <!-- /Page Content -->
        {include "footer.tpl"}
    </div>
    
    
    {block name=js}{/block}
    <!-- google analytics -->
    <script type="text/javascript">
      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', "{$t['google_tracking_id']['text']}"]);
      _gaq.push(['_trackPageview']);
      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://' : 'http://') + 'stats.g.doubleclick.net/dc.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();
    </script>
    <!-- /google analytics -->
  </body>
</html>

{extends file='main.tpl'}
{block name=additionalHead}
<link rel="stylesheet" href="{$app_url}libs/leaflet.css">
<script>
/* correct height of buttons */
$(function() {
    var h = $("#equal-heights").height();
    if (h<200) { //so it does not change heights in case of mobiles
        $(".equal-height").each(function() {
            $(this).outerHeight(h);
        })
    }
})    
</script>
{/block}
{block name=body}
    <script>
        countries = {$countries} ;
    </script>

{*    <h1>{$t['title']['text']}</h1>*}
    <div class="jumbotron">
        <p>
{*        <i class="fa fa-certificate fa-2x text-success"></i>*}
         {$jumbo_text}
    </div>
    <!-- map and categories -->
    <div class="row">
        <div class="col-md-3">
            <div class="list-group" id="next-map-container">
                {foreach $categories as $category}
                    <a href="explore?c={$category->code}" class="list-group-item">
                        <h4><div class="row"><div class="col-xs-2"><i class="fa fa-{$category->icon}" style="font-size:1.1em"></i></div><div class="col-xs-10"> {$category->name}</div></h4>
                    </a>
                {/foreach}
            </div>
{*            <p><i class="fa fa-info-circle"></i> {$t['under_categories']['text']}*}
        </div>
        <div class="col-md-9">
            <div id="worldmap-container">
                <div id="worldmap"></div>
                <p>
                <p><i class="fa fa-info-circle"></i> {$t['under_map']['text']}
            </div>
        </div>
    </div>
    <!-- /map and categories -->
    <hr>
    
    <!-- big links -->
    <div class="row">
        <div id="equal-heights" style="overflow:hidden">
            <!-- explore -->
            <div class="col-md-4">

                    <a href="explore" class="btn btn-info btn-lg btn-block active equal-height" role="button" style="white-space: normal;">
                        <h3><strong>{mb_convert_case({$t['explore']['text']}, 0, "UTF-8")}</strong></h3>
                        <small>{$t['explore_description']['text']}</small>
                    </a>

            </div>
            <!-- download -->
            <div class="col-md-4">
                <a href="download" class="btn btn-info btn-lg btn-block active" role="button" style="white-space: normal;">
                    <h3><strong>{mb_convert_case({$t['download']['text']}, 0, "UTF-8")}</strong></h3>
                    <small>{$t['download_description']['text']}</small>
                </a>
            </div>
            <!-- contribute -->
            <div class="col-md-4">
                <a href="contribute" class="btn btn-info btn-lg btn-block active" role="button" style="white-space: normal;">
                    <h3><strong>{mb_convert_case({$t['contribute']['text']}, 0, "UTF-8")}</strong></h3>
                    <small>{$t['contribute_description']['text']}</small>
                </a>
            </div>
        </div>
    </div>

<!-- map js -->
<script src="{$app_url}libs/chroma.min.js"></script>
<script src="{$app_url}libs/topojson.v1.min.js"></script>
<script src="{$app_url}libs/leaflet.js"></script>
<script src="{$app_url}libs/d3.v3.min.js"></script>
<script src="{$app_url}front-page/map.js"></script>
{/block}

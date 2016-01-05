{extends file='main.tpl'}
{block name=additionalHead}
<link rel="stylesheet" href="{$app_url}libs/leaflet.css">
{/block}
{block name=body}
    <script>
        countries = {$countries};
    </script>

    <h1>{$title}</h1>
    

        <div id="worldmap-container">
            <div id="worldmap"></div>
            <p><i class="fa fa-info-circle"></i> 
        </div>


<!-- map js -->
<script src="{$app_url}libs/chroma.min.js"></script>
<script src="{$app_url}libs/topojson.v1.min.js"></script>
<script src="{$app_url}libs/leaflet.js"></script>
<script src="{$app_url}libs/d3.v3.min.js"></script>
<script src="{$app_url}map/map.js"></script>
{/block}

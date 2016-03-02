{extends file='main.tpl'}
{block name=additionalHead}
<link rel="stylesheet" href="{$app_url}libs/leaflet.css">
{/block}
{block name=body}
    <script>
        countries = {$countries};
        qid = {$qid};
    </script>

    <h1>{$title}</h1>

    <div class="row">
        <div class="col-sm-4">
            <button class="btn btn-default btn-lg btn-block" data-toggle="modal" data-target="#choose-questions-modal"><strong><span class="caret"></span> {$t['choose_question']['text']}</strong></button>
        </div>
        
    </div>    
    

    <form id="map-form">
        <div class="selects">
        <!-- choose questions -->
            {include "map_choose-questions.tpl"}
        <!-- /choose questions --> 
        </div>
 
        {foreach $regions as $region}
            {foreach $parliaments[$region] as $row}
                {if (in_array($row->id,$get['p']) or in_array($row->country_code,$get['cc']))}
                    <input type="hidden" name="p[]" value="{$row->id}">
                {/if}
            {/foreach}
        {/foreach} 

    </form>

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

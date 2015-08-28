{extends file='main.tpl'}
{block name=additionalHead}
<script src="{$app_url}libs/jquery.stickytableheaders.min.js"></script>
{/block}
{block name=body}

    <script>
        //shows and hides 
        $(function() {
            $(".show-details").click(function(){
                $("#"+this.id+"-body").show(100);
                $("#"+this.id).hide();
            });
        })
        $(function () {
            $("#explore-table").stickyTableHeaders();
        });
        $(function () {
          $('[data-toggle="popover"]').popover()
        });
        $(function () {
            $( "#submit-rotate" ).click(function( event ) {
                $("#rot").val(function() {
                    {$nrot = ($get['rot']) % 2 + 1}
                    return "{$nrot}";
                });
                $("explore-form").submit();
            });
            $( "#reset-rotate" ).click(function( event ) {
                $("#rot").val("");
                $("explore-form").submit();
            });
        });
        //shows and hides forms
        $(function() {
            $("#show-suggest-edits").click(function(){
                $(".suggest-edits-hidden").show(1000);
                $(".suggest-edits-hide").hide(1000);
            });
            $("#hide-suggest-edits").click(function(){
                $(".suggest-edits-hidden").hide(1000);
                $(".suggest-edits-hide").show(1000);
            });

        })
{*        //shows and hides *}
{*        $(function() {*}
{*            $(".read-more").click(function(){*}
{*                $("#"+this.id+"-rest").show(100);*}
{*                $("#"+this.id).hide();*}
{*            });*}
{*        })*}
    </script>

    <h1>{$t['title']['text']}</h1>

    <!-- buttons -->    
    <div class="row">
        <div class="col-sm-2"></div>
        <div class="col-sm-4">
            <button class="btn btn-default btn-lg btn-block" data-toggle="modal" data-target="#choose-chambers-modal"><strong><span class="caret"></span> {$t['choose_chambers']['text']}</strong></a>
        </div>
        
        <div class="col-sm-4">
            <button class="btn btn-default btn-lg btn-block" data-target="#choose-categories-modal" data-toggle="modal"><strong><span class="caret"></span> {$t['choose_categories']['text']}</strong></a>
        </div>
    </div>
    
    <form id="explore-form">
    <!-- choose categories -->
        {include "explore_choose-categories.tpl"}
    <!-- /choose categories -->
    
    <!-- choose chambers -->
        {include "explore_choose-chambers.tpl"}
    <!-- /choose chambers -->  
    
    <!-- table -->
        <h3>{$t['data']['text']}</h3>
        <button class="btn btn-default btn-sm" id="submit-rotate">
            <i class="fa fa-rotate-right"></i> {$t['rotate']['text']}
        </button>
        <input type="hidden" name="rot" id="rot" value="{$get['rot']}">
        {if $force_rot}
        <button class="btn btn-primary btn-sm" id="reset-rotate">
            <i class="fa fa-close"></i> {$t['reset_rotate']['text']}
        </button>
        {/if}
    </form>
        {include "explore_table.tpl"}
    <!-- table -->
    
    <!-- suggest edit -->
        {include "explore_suggest.tpl"}
    <!-- /suggest edit -->
    <hr>
    <!-- best practices -->
        {include "explore_best-practices.tpl"}
    <!-- /best practices

{/block}

{extends file='main.tpl'}
{block name=body}

    <script>
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
            $("#show-add-best-practices").click(function(){
                $(".add-best-practices-hidden").show(1000);
                $(".add-best-practices-hide").hide(1000);
            });
            $("#hide-add-best-practices").click(function(){
                $(".add-best-practices-hidden").hide(1000);
                $(".add-best-practices-hide").show(1000);
            });
            
        })
    </script>

{*    <h1>{$t['title']['text']}</h1>*}
    
    <!-- Add Data -->
    <div class="jumbotron text-center">
        <h2>{$t['add_data']['text']}</h2>
        <p>{$t['add_data_text']['text']}
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <a href="{$t['add_data_button']['link']}" type="button" class="btn btn-success btn-lg btn-block" target="_blank"><strong>{$t['add_data_button']['text']} <i class="fa fa-external-link"></i></strong></a>
            </div>
        </div>
    </div>
    
    <!-- Suggest Edits -->
    <div class="jumbotron text-center">
        <h2>{$t['suggest_edits']['text']}</h2>
        <p>{$t['suggest_edits_text']['text']}
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <button id="show-suggest-edits" type="button" class="btn btn-success btn-lg btn-block suggest-edits-hide"><strong>{$t['suggest_edits_button']['text']} </strong></button>
            </div>
        </div>
        <p style="display:none" class="suggest-edits-hidden"><iframe src="{$t['suggest_edits_google_form']['link']}" width="100%" height="750" frameborder="0" marginheight="0" marginwidth="0">...</iframe>
        <p class="pull-right suggest-edits-hidden" style="display:none"><a href="#" id="hide-suggest-edits">{$t['suggest_edits_form_hide']['text']}</a>
    </div>
    
    <!-- Add Best Practices -->
    <div class="jumbotron text-center">
        <h2>{$t['add_best_practices']['text']}</h2>
        <p>{$t['add_best_practices_text']['text']}
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <button id="show-add-best-practices"type="button" class="btn btn-success btn-lg btn-block add-best-practices-hide"><strong>{$t['add_best_practices_button']['text']} </strong></button>
            </div>
        </div>
        <p style="display:none" class="add-best-practices-hidden"><iframe src="{$t['add_best_practices_google_form']['link']}" width="100%" height="750" frameborder="0" marginheight="0" marginwidth="0">...</iframe>
        <p class="pull-right add-best-practices-hidden" style="display:none"><a href="#" id="hide-add-best-practices">{$t['add_best_practices_form_hide']['text']}</a>
    </div>
    

{/block}

{extends file='main.tpl'}
{block name=body}

    <script>
        //shows and hides 
        $(function() {
            $(".read-more").click(function(){
                $("#"+this.id+"-rest").show(100);
                $("#"+this.id).hide();
            });
        })
    </script>

    <h1>{$t['title']['text']}</h1>
    <h3>{$t['categories']['text']}</h3>
    {foreach $categories as $category}
        {if ($category@iteration - 1) is div by 4}
            <div class="row">
        {/if}
                <div class="col-sm-3"><h5><a href="?category={$category['code']}"><i class="fa fa-{$category['icon']}"></i> {$category['name']}</a></h5></div>
        {if ($category@iteration) is div by 4}
            </div>
        {/if}
    {/foreach}
        {if ($category@iteration + 0) is not div by 4}
            </div>
        {/if}
    <h3>{$t['examples']['text']}
        {if $filter}: {$filter['name']} <i class="fa fa-{$filter['icon']}"></i> <small><a href="?">{$t['all']['text']}</a></small>{/if}
    </h3>
    {if count($examples) > 0}
        {foreach $examples as $example}
            <div class="well well-lg">
                <h4>{$example['header']}
                    {foreach $example['categories'] as $cat}
                        <a href="?category={$categories[$cat]['code']}" title="{$categories[$cat]['name']}"><i class="fa fa-{$categories[$cat]['icon']}"></i></a>
                    {/foreach}
                </h4>

                <p>{$example['teaser']}
                <p><a href="#" id="example-{$example['code']}" class="read-more"  onclick="return false">{$t['read_more']['text']}</a>
                <div id="example-{$example['code']}-rest" style="display:none">
                    {$example['rest']}
                </div>
            </div>
        {/foreach}
    {else}
        <div class="alert alert-info" role="alert">
            <p><i class="fa fa-info-circle"></i> {$t['no_examples']['text']} <a href="?">{$t['see_all_examples']['text']}</a>
        </div> 
    {/if}
    
{*    <!-- Add Data -->*}
{*    <div class="jumbotron">*}
{*        <h2>{$t['add_data']['text']}</h2>*}
{*        <p>{$t['add_data_text']['text']}*}
{*        <div class="row">*}
{*            <div class="col-md-3"></div>*}
{*            <div class="col-md-6">*}
{*                <a href="{$t['add_data_button']['link']}" type="button" class="btn btn-success btn-lg btn-block" target="_blank"><strong>{$t['add_data_button']['text']} <i class="fa fa-external-link"></i></strong></a>*}
{*            </div>*}
{*        </div>*}
{*    </div>*}
{*    *}
{*    <!-- Suggest Edits -->*}
{*    <div class="jumbotron">*}
{*        <h2>{$t['suggest_edits']['text']}</h2>*}
{*        <p>{$t['suggest_edits_text']['text']}*}
{*        <div class="row">*}
{*            <div class="col-md-3"></div>*}
{*            <div class="col-md-6">*}
{*                <button id="show-suggest-edits" type="button" class="btn btn-success btn-lg btn-block suggest-edits-hide"><strong>{$t['suggest_edits_button']['text']} </strong></button>*}
{*            </div>*}
{*        </div>*}
{*        <p style="display:none" class="suggest-edits-hidden"><iframe src="{$t['suggest_edits_google_form']['link']}" width="100%" height="750" frameborder="0" marginheight="0" marginwidth="0">...</iframe>*}
{*        <p class="pull-right suggest-edits-hidden" style="display:none"><a href="#" id="hide-suggest-edits">{$t['suggest_edits_form_hide']['text']}</a>*}
{*    </div>*}
{*    *}
{*    <!-- Add Best Practices -->*}
{*    <div class="jumbotron">*}
{*        <h2>{$t['add_best_practices']['text']}</h2>*}
{*        <p>{$t['add_best_practices_text']['text']}*}
{*        <div class="row">*}
{*            <div class="col-md-3"></div>*}
{*            <div class="col-md-6">*}
{*                <button id="show-add-best-practices"type="button" class="btn btn-success btn-lg btn-block add-best-practices-hide"><strong>{$t['add_best_practices_button']['text']} </strong></button>*}
{*            </div>*}
{*        </div>*}
{*        <p style="display:none" class="add-best-practices-hidden"><iframe src="{$t['add_best_practices_google_form']['link']}" width="100%" height="750" frameborder="0" marginheight="0" marginwidth="0">...</iframe>*}
{*        <p class="pull-right add-best-practices-hidden" style="display:none"><a href="#" id="hide-add-best-practices">{$t['add_best_practices_form_hide']['text']}</a>*}
{*    </div>*}
    

{/block}

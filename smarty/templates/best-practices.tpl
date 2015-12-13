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
        {if $filter}: 
            {foreach $filter as $f}
                {$f['name']} <i class="fa fa-{$f['icon']}"></i> <small><a href="?">{$t['all']['text']}</a></small>
            {/foreach}
        {/if}
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
{/block}

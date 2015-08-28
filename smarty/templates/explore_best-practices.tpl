{if count($bp_examples) > 0}
    <h3>{$t['best_practices']['text']}</h3>
    <div class="row">
    {foreach $bp_examples as $example}
        {if $example@iteration > 3}
            {break}
        {/if}
        <div class="col-sm-4">
            <div class="well well-lg">
                <h4>{$example['header']}
                    {foreach $example['categories'] as $cat}
                        <a href="?category={$bp_categories[$cat]['code']}" title="{$bp_categories[$cat]['name']}"><i class="fa fa-{$bp_categories[$cat]['icon']}"></i></a>
                    {/foreach}
                </h4>

                <p>{$example['teaser']}
                <p><a href="../best-practices" id="example-{$example['code']}">{$t['read_more']['text']}</a>
{*                <div id="example-{$example['code']}-rest" style="display:none">*}
{*                    {$example['rest']}*}
{*                </div>*}
            </div>
        </div>
    {/foreach}
    </div>
{/if}

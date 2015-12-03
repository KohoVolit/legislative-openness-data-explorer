{extends file='main.tpl'}
{block name=body}
<div class="row">
    <div class="col-md-9" role="main">
        {$main_text}
    </div>
    <div id='navbar-example' class="col-md-3" role="complementary">
        <nav class="bs-docs-sidebar hidden-print hidden-xs hidden-sm affix">
            <ul class="nav bs-docs-sidenav">
            {foreach $headers as $h0}
                <li><a href="#{$h0['slug']}">{$h0["header"]}</a>
                {if count($h0["children"]) > 0}
                    <ul class="nav">
                    {foreach $h0["children"] as $h1}
                        <li><a href="#{$h1['slug']}">{$h1["header"]}</a>
                    {/foreach}
                    </ul>
                {/if}
            {/foreach}
            </ul>
        </nav>
    </div>
</div>
{/block}

{$it = $data_selected[$p->id][$q->id]}

<div class="text-info">
{if (count($it->texts) > 0 or count($it->options)>0)}
    
    <div data-toggle="tooltip" data-trigger="hover" title="{foreach $it->options as $o}
            {$o};
        {/foreach}
        {foreach $it->texts as $ittext}
            {$ittext}
            {if !($ittext@last)}; {/if}
        {/foreach}">
    <div style="cursor:pointer" class="center-block" data-toggle="popover" data-placement="left" title="{$t['details']['text']}:" data-content="
        {foreach $it->options as $o}
            {$o}
            {if !($o@last)}<br>{/if}
        {/foreach}
        {foreach $it->texts as $ittext}
            {$ittext}
            {if !($ittext@last)}; {/if}
        {/foreach}
        ">
{/if}
{if $it->value !== ""}
        <i class="fa fa-circle traffic-color-{$it->value} fa-2x"></i></div>
{/if}
{if (count($it->texts) > 0 or count($it->options)>0)}
    </div>
    </div>
{/if}
</div>

{*{foreach $it->options as $o}*}
{*    <small>{$o}</small>*}
{*    {if !($o@last)}<br>{/if}*}
{*{/foreach}*}
{*{if count($it->options) == 0}*}
{*    {foreach $it->options as $o}*}
{*        <small>{$o}</small>*}
{*        {if !($o@last)}<br>{/if}*}
{*    {/foreach}*}
{*{else}*}
{*    {if count($it->texts) > 0}*}
{*        <div style="cursor:pointer" class="text-info"><button tabindex="0" data-toggle="popover" data-trigger="focus" title="{$t['details']['text']}:" data-content="*}
{*        {foreach $it->options as $o}*}
{*            <small>{$o}</small>*}
{*            {if !($o@last)}<br>{/if}*}
{*        {/foreach}*}
{*        {foreach $it->texts as $ittext}*}
{*            {$ittext}*}
{*            {if !($ittext@last)}; {/if}*}
{*        {/foreach}*}
{*        " class="fa fa-info-circle"></button>*}
{*        </div>*}
{*    {/if}*}
{*{/if}*}

<table id="explore-table" class="table table-bordered table-hover">
{if $get['rot'] == 1}
    <thead>
        <tr class="bg-primary">
                <th>
            {foreach $questions_selected as $q}
                <th style="vertical-align:top">
                    {* {foreach $q->categories->icons as $key=>$icon}
                        <i class="fa fa-{$icon}" title="{$q->categories->names[$key]}"></i>
                    {/foreach} *}
                 <small>{call name=td td=$td text=$q->question}</small>
            {/foreach}
    <tbody>
    {foreach $parliaments_selected as $p}
        <tr>
            <td><strong>{call name=td td=$td text=$p->country}</strong>: {call name=td td=$td text=$p->name}
        {foreach $questions_selected as $q}
            <td>
                {include "explore_table_cell.tpl"}
        {/foreach}
    {/foreach}

{else}
    <thead>
        <tr class="bg-primary">
                <th>
            {foreach $parliaments_selected as $p}
              <th style="vertical-align:top">{call name=td td=$td text=$p->country}: <small>{call name=td td=$td text=$p->name}</small>
            {/foreach}
    <tbody>
    {foreach $questions_selected as $q}
        <tr>
            <td>
                {* {foreach $q->categories->icons as $key=>$icon}
                        <i class="fa fa-{$icon}" title="{$q->categories->names[$key]}"></i>
                {/foreach} *}
                {call name=td td=$td text=$q->question}
        {foreach $parliaments_selected as $p}
            <td align="center">
                {include "explore_table_cell.tpl"}
        {/foreach}
    {/foreach}
{/if}
</table>

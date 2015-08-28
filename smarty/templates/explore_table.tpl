<table id="explore-table" class="table table-bordered table-hover">
{if $get['rot'] == 1}
    <thead>
        <tr class="bg-primary">
                <th>
            {foreach $questions_selected as $q}
                <th style="vertical-align:top"><i class="fa fa-{$q->category_icon}" title="{$q->category_name}"></i> <small>{$q->question}</small>
            {/foreach}
    <tbody>
    {foreach $parliaments_selected as $p}
        <tr>
            <td><strong>{$p->country}</strong>: {$p->name}
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
                <th style="vertical-align:top">{$p->country}: <small>{$p->name}</small>
            {/foreach}
    <tbody>
    {foreach $questions_selected as $q}
        <tr>
            <td><i class="fa fa-{$q->category_icon}" title="{$q->category_name}"></i> {$q->question}
        {foreach $parliaments_selected as $p}
            <td>
                {include "explore_table_cell.tpl"}
        {/foreach}
    {/foreach}
{/if}
</table>



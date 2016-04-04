{$it = $data_selected[$p->id][$q->id]}

<div class="modal fade" id="info-modal-{$p->id}-{$q->id}" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">

        <h5 class="modal-title" id="info-modal-title"><strong>{$p->country}</strong>: {$p->name}</h5>
        <h4 class="modal-title" id="info-moda-title">{$q->question}</h4>
      </div>

      <div class="modal-body left">
        <ul class="modal-ul">
          {$tmp = []}
          {foreach $q->subquestions as $sk=>$sq}
            {$tmp[] = $sk}
            <span style="display:none">{sort($tmp)}</span>
          {/foreach}
          {foreach $tmp as $k}
           <li>
            <div class="row modal-row">
                <div {if $q->subquestions->$k->subquestion != ""}class="col-md-6{/if}">
                    <i class="fa fa-circle-o"></i> {$q->subquestions->$k->subquestion}
                </div>
                <div class="col-md-6 modal-break-word">
                {$tmp = 0}
                {foreach $it->subquestions->$k as $st}{if $st != ""}{if ($tmp > 0)};{/if}
                        <strong>{$st}</strong>{$tmp = $tmp + 1}{/if}{/foreach}
                </div>
            </div>
          {/foreach}
        </ul>
      </div>

      <div class="modal-footer">
        <a href="{$t['suggest_edits_google_form_modal']['link']}{$t['suggest_edits_google_form_modal_entry_1']['text']}={$p->country|urlencode}:+{$p->name|urlencode}&{$t['suggest_edits_google_form_modal_entry_2']['text']}={$q->question|urlencode}" target="_blank" type="button" class="btn btn-default">{$t['suggest_edits_button']['text']}</a>
        <button type="button" class="btn btn-primary" data-dismiss="modal">{$t['close']['text']}</button>
      </div>

    </div>
  </div>
</div>

<div class="text-info">
{*{if (count($it->texts) > 0 or count($it->options)>0)}*}
{*    *}
{*    <div data-toggle="tooltip" data-trigger="hover" title="{foreach $it->options as $o}*}
{*            {$o};*}
{*        {/foreach}*}
{*        {foreach $it->texts as $ittext}*}
{*            {$ittext}*}
{*            {if !($ittext@last)}; {/if}*}
{*        {/foreach}">*}
{*    <div style="cursor:pointer" class="center-block" data-toggle="popover" data-placement="left" title="{$t['details']['text']}:" data-content="*}
{*        {foreach $it->options as $o}*}
{*            {$o}*}
{*            {if !($o@last)}<br>{/if}*}
{*        {/foreach}*}
{*        {foreach $it->texts as $ittext}*}
{*            {$ittext}*}
{*            {if !($ittext@last)}; {/if}*}
{*        {/foreach}*}
{*        ">*}
{*{/if}*}
{if $it->value !== ""}
     <a href="" data-target="#info-modal-{$p->id}-{$q->id}" data-toggle="modal" title="{$t['details']['text']}">
        <i class="fa fa-circle traffic-color-{$it->value} fa-2x"></i>
     </a>
{/if}
{*{if (count($it->texts) > 0 or count($it->options)>0)}*}
{*    </div>*}
{*    </div>*}
{*{/if}*}
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

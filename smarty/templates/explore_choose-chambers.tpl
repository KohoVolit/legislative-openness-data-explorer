<div class="modal fade" id="choose-chambers-modal" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="{$t['close']['text']}"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">{$t['choose_chambers']['text']}</h4>
      </div>
      
      <div class="modal-body">
        

            <h3>{$t['choose_chambers']['text']}</h3>
            
            {foreach $regions as $region}
                <h4>{$region}</h4>
                <table class="table table-hover">
                  <tbody>
                    {foreach $parliaments[$region] as $row}
                      {if ($row@iteration - 1) is div by 2}
                        <tr>
                      {/if}
                        <td class="col-sm-6">
                        <input type="checkbox" name="p[]" value="{$row->id}"
                        {if (in_array($row->id,$get['p']) or (($row->country_code == $get['cc']) and ($row->country_code != '')))}
                            checked
                        {/if}
                        > <strong>{$row->country}</strong>: {$row->name}
                    {/foreach} 
                  </tbody>
                </table>
            {/foreach}
                
                <div class="row">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-8">
                        <input type="submit" value="{$t['explore']['text']}" class="btn btn-success btn-block btn-lg">
                    </div>
                </div>
                

      </div>

    </div>
  </div>
</div>

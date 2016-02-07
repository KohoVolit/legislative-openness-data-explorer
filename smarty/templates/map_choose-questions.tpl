<div class="modal fade" id="choose-questions-modal" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="{$t['close']['text']}"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">{$t['choose_question']['text']}</h4>
      </div>
      
      <div class="modal-body">
            <!-- questions -->
            <div>
                {foreach $categories as $category}
                    <h4>{$category->name}</h4>
                    <table class="table table-hover">
                      <tbody>
                        {if (isset($questions[$category->code]))}
                        {foreach $questions[$category->code] as $question}
                          {if ($question@iteration - 1) is div by 2}
                            <tr>
                          {/if} 
                            <td class="col-sm-6">
                            <input type="radio" name="q[]" value="{$question->id}"
                                {if ($question->id == $questions_selected[0]->id)}
                                    checked
                                {/if}> 
                                {foreach $question->categories->icons as $icon}
                                    <i class="fa fa-{$icon}"></i>
                                {/foreach}
                                     {$question->question}
                        {/foreach}
                        {/if}
                      </tbody>
                    </table>
                    <div class="row">
                        <div class="col-sm-2"></div>
                        <div class="col-sm-8">
                            <input type="submit" value="{$t['explore']['text']}" class="btn btn-success btm-lg btn-block">
                        </div>
                    </div>
                {/foreach}
               
                
            </div>
            <!-- /questions -->
                
      </div>

    </div>
  </div>
</div>

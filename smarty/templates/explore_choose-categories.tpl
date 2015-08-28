<div class="modal fade" id="choose-categories-modal" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="{$t['close']['text']}"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">{$t['choose_categories']['text']}</h4>
      </div>
      
      <div class="modal-body">
            <!-- categories -->
            {foreach $categories as $category}
                {if ($category@iteration - 1) is div by 3}
                    <div class="row">
                {/if}
                        <div class="col-sm-4">
                            <h3><input type="checkbox" name="c[]" value="{$category->code}"
                            {if in_array($category->code,$get['c'])}
                                checked
                            {/if}
                            > {$category->name} <i class="fa fa-{$category->icon}"></i></h3></div>
                {if ($category@iteration) is div by 3}
                    </div>
                {/if}
            {/foreach}
            {if ($category@iteration) is not div by 3}
                </div>
            {/if}
            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <input type="submit" value="{$t['explore']['text']}" class="btn btn-success btn-lg btn-block">
                </div>
            </div>
            <!-- /categories -->
            <hr>
            <a href="#" id="categories-show-details" class="show-details" onclick="return false">{$t['select_individual_questions']['text']} ...</a>
            <!-- questions -->
            <div style="display:none" id="categories-show-details-body">
                <h3>{$t['select_individual_questions']['text']}</h3>
                {foreach $categories as $category}
                    <h4>{$category->name}</h4>
                    <table class="table table-hover">
                      <tbody>
                        {foreach $questions[$category->code] as $question}
                          {if ($question@iteration - 1) is div by 2}
                            <tr>
                          {/if} 
                            <td class="col-sm-6">
                            <input type="checkbox" name="q[]" value="{$question->id}"
                                {if in_array($question->id,$get['q'])}
                                    checked
                                {/if}> <i class="fa fa-{$question->category_icon}"></i> {$question->question}
                        {/foreach} 
                      </tbody>
                    </table>
                {/foreach}
                <div class="row">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-8">
                        <input type="submit" value="{$t['explore']['text']}" class="btn btn-success btm-lg btn-block">
                    </div>
                </div>
                
            </div>
            <!-- /questions -->
                
      </div>

    </div>
  </div>
</div>

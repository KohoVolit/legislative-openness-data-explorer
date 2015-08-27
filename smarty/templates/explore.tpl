{extends file='main.tpl'}
{block name=additionalHead}
    <script src="{$app_url}libs/bootstrap.min.js"></script>
{/block} 
{block name=body}

    <script>
        //shows and hides 
        $(function() {
            $(".show-details").click(function(){
                $("#"+this.id+"-body").show(100);
                $("#"+this.id).hide();
            });
        })
    </script>

    <h1>{$t['title']['text']}</h1>

    <!-- buttons -->    
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-4">
            <button class="btn btn-default btn-lg btn-block" data-toggle="modal" data-target="#choose-chambers-modal"><strong><span class="caret"></span> {$t['choose_chambers']['text']}</strong></a>
        </div>
        
        <div class="col-md-4">
            <button class="btn btn-default btn-lg btn-block" data-target="#choose-categories-modal" data-toggle="modal"><strong><span class="caret"></span> {$t['choose_categories']['text']}</strong></a>
        </div>
    </div>
    
    <form>
    <!-- choose categories -->
    <div class="modal fade" id="choose-categories-modal" tabindex="-1" role="dialog">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-label="{$t['close']['text']}"><span aria-hidden="true">&times;</span></button>
              <h4 class="modal-title">{$t['choose_categories']['text']}</h4>
          </div>
          
          <div class="modal-body">
                {foreach $categories as $category}
                    {if ($category@iteration - 1) is div by 3}
                        <div class="row">
                    {/if}
                            <div class="col-sm-4">
                                <h3><input type="checkbox" name="c[]" value="{$category['code']}"
                                {if in_array($category['code'],$get['c'])}
                                    checked
                                {/if}
                                > {$category['name']} <i class="fa fa-{$category['icon']}"></i></h3></div>
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
                        <input type="submit" value="{$t['explore']['text']}" class="btn btn-success btn-block">
                    </div>
                </div>
                <hr>
                <a href="#" id="categories-show-details" class="show-details" onclick="return false">{$t['select_individual_questions']['text']} ...</a>
                <div style="display:none" id="categories-show-details-body">
                    <h3>{$t['select_individual_questions']['text']}</h3>
                    
                    <table class="table table-hover">
                      <tbody>
                        {foreach $questions as $question}
                          {if ($question@iteration - 1) is div by 2}
                            <tr>
                          {/if} 
                          {$cat = $question->category}
                            <td>
                            <input type="checkbox" name="q[]" value="{$question->id}"
                                {if in_array($question->id,$get['q'])}
                                    checked
                                {/if}> <i class="fa fa-{$categories[$cat]['icon']}"></i> {$question->question}
                        {/foreach} 
                      </tbody>
                    </table>
                    <div class="row">
                        <div class="col-sm-2"></div>
                        <div class="col-sm-8">
                            <input type="submit" value="{$t['explore']['text']}" class="btn btn-success btn-block">
                        </div>
                    </div>
                    
                </div>
                    
          </div>

        </div>
      </div>
    </div>
    <!-- /choose categories -->
    
    <!-- choose chambers -->
    <div class="modal fade" id="choose-chambers-modal" tabindex="-1" role="dialog">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal" aria-label="{$t['close']['text']}"><span aria-hidden="true">&times;</span></button>
              <h4 class="modal-title">{$t['choose_chambers']['text']}</h4>
          </div>
          
          <div class="modal-body">
            

                <h3>{$t['choose_chambers']['text']}</h3>
                
                <table class="table table-hover">
                  <tbody>
                    {foreach $data as $row}
                      {if ($row@iteration - 1) is div by 2}
                        <tr>
                      {/if}
                        <td>
                        <input type="checkbox" name="p[]" value="{$row->id}"
                        {if (in_array($row->id,$get['p']) or ($row->data->{0}->texts[0] == $get['cc']))}
                            checked
                        {/if}
                        > <strong>{$row->data->{2}->texts[0]}</strong>: {$row->data->{9}->texts[0]}
                    {/foreach} 
                  </tbody>
                </table>
                    <div class="row">
                        <div class="col-sm-2"></div>
                        <div class="col-sm-8">
                            <input type="submit" value="{$t['explore']['text']}" class="btn btn-success btn-block">
                        </div>
                    </div>
                    

          </div>

        </div>
      </div>
    </div>
    <!-- /choose chambers -->  
    </form> 

{/block}

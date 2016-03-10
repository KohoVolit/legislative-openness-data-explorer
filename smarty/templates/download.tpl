{extends file='main.tpl'}
{block name=body}
    <h1>{$t['title']['text']}</h1>
    <div class="jumbotron">
        <p>{$mid_text}
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-4">
                <a href="{$t['csv_link']['link']}" type="button" class="btn btn-success btn-lg btn-block"><strong>{$t['button_download']['text']}</strong></a>
            </div>
            <div class="col-md-4">
                <a href="{$t['xls_link']['link']}" type="button" class="btn btn-success btn-lg btn-block"><strong>{$t['download_excel']['text']}</strong></a>
            </div>
        </div>
    </div>

{/block}

{extends file='main.tpl'}
{block name=body}
    <h1>{$t['title']['text']}</h1>
    <div class="jumbotron">
        <p>{$mid_text}
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <a href="data.csv" type="button" class="btn btn-success btn-lg btn-block"><strong>{$t['button_download']['text']}</strong></a>
                <div class="pull-right"><p><small><a href="data.xls">{$t['download_excel']['text']}</a></small></div>
            </div>
        </div>
    </div>

{/block}

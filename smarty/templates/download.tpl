{extends file='main.tpl'}
{block name=body}
    <h1>{$t['title']['text']}</h1>
    <div class="jumbotron">
        <p>All of the collected data is made available under a public domain data license. All are encouraged to download and reuse the data. For more information on the data and research methodology, please see this page.
        <form method="get" action="data.csv">
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <button type="submit" class="btn btn-success btn-lg btn-block"><strong>{$t['button_download']['text']}</strong></button>
                </div>
            </div>
        </form>
    </div>

{/block}

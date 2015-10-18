<nav class="navbar navbar-inverse">
  <div class="container">
    <div class="navbar-header">
    
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse">
        <span class="sr-only">...</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="../">{$t['brand']['text']}</a>
    </div>

    <div class="collapse navbar-collapse" id="navbar-collapse">
      <ul class="nav navbar-nav">
        {foreach $header as $row}
            <li
            {if $page == $row['link']}
                class="active" style="font-size:1.2em"
                {/if}
            ><a href="{$app_url}{$row['link']}">{$row['text']}</a></li>
        {/foreach}
      </ul>

{*      <ul class="nav navbar-nav navbar-right">*}
{*        <li><a href="{$text['settings_link']}">{$text['settings_address']}</a></li>*}
{*      </ul>*}
    </div>
  </div>
</nav>

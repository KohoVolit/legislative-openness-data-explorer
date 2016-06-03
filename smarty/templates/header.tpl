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

     <ul class="nav navbar-nav navbar-right">
         <li class="dropdown small">
             <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">{$LANGUAGES[$lang]} <span class="caret"></span></a>
             <ul class="dropdown-menu">
                 {foreach $LANGUAGES as $k=>$l}
                    <li><a href="?lang={$k}">{$l}</a></li>
                 {/foreach}
             </ul>
        </li>
     </ul>
    </div>
  </div>
</nav>

<footer class="footer">
    <div class="row">
         <div class="col-md-6">
            <ul class="footer-links">
             {foreach $header as $row}
                <li
                {if $page == $row['link']}
                    class="active" style="font-size:1.2em"
                    {/if}
                ><a href="{$app_url}{$row['link']}">{$row['text']}</a></li>
                {if (!$row@last)}
                    <li>·</li>
                {/if}
            {/foreach}
            </ul>
         </div>
         <div class="col-md-6">
             <ul class="footer-links pull-right">
              <li><a href="http://ndi.org"><img src="{$relative_path}images/ndi.png" alt="NDI" title="NDI" /></a></li>
              <li> </li>
              <li><a href="http://kohovolit.eu"><img src="{$relative_path}images/kohovolit.eu.png" alt="KohoVolit.eu" title="KohoVolit.eu" /></li>
            </ul>
         </div>
     </div>
      <div class="row">
         <div class="col-md-6">  
            <ul class="footer-links">
              <li><a href="https://creativecommons.org/licenses/by/4.0/" target="_blank"><i class="fa fa-creative-commons"></i> CC Attribution 4.0 International License</a></li>
              <li>·</li>
              <li><a href="https://github.com/KohoVolit/legislative-openness-data-explorer/"><i class="fa fa-github"></i> Source</a></li>
            </ul>
        </div>
    </div>
</footer>

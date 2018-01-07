<div class="box" >
  <div class="box-content">
      <div class="box-category" id="prices_module">
          <ul class="ui-accordion ui-widget ui-helper-reset ui-accordion-icons" role="tablist">
              <li class="ui-accordion-li-fix">
                  <a href="#" class="kids ui-accordion-header ui-helper-reset ui-state-default ui-corner-all" role="tab" aria-expanded="false" aria-selected="false">
                      <?php echo $heading_title; ?>
                  </a>
                  <ul class="ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom ui-accordion ui-widget ui-accordion-icons">
                      <? foreach ($categories as $category) :?>
                         <? foreach ($downloads as $download) :?>
                            <? if ($category['download'] == $download['download_id'] ) :?>
                              <li class="ui-accordion-li-fix">
                                  <a href="<?php echo $href.$download['download_id']; ?>" title="<?php echo $tooltip_download; ?>"><?php echo $category['category']; ?></a>
                              </li>
                            <? endif ?>
                        <? endforeach ?>
                      <? endforeach ?>
                  </ul>
              </li>
          </ul>
      </div>
  </div>
</div>
<script type="text/javascript"><?php echo $scripts; ?></script>
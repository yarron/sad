
<div id="column-left">
<div class="box">
<div id="search">
        <input type="text" name="search" placeholder="<?php echo $text_search; ?>" value="<?php echo $search; ?>" />
    </div>
</div>
<?php if ($modules) { ?>
  <?php foreach ($modules as $module) { ?>
  <?php echo $module; ?>
  <?php } ?>
  <?php } ?> 
  <div id="flower"></div>
</div>



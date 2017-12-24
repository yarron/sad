<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h1><?php echo $heading_title_d; ?></h1>
  <?php if(!empty($discounts)) { ?>
      <?php echo html_entity_decode($description['before']); ?>
      <ul>
          <?php foreach($discounts as $discount) { ?>
          <li><?php echo html_entity_decode($discount['description']); ?></li>
          <?php } ?>
      </ul>
      <?php echo html_entity_decode($description['after']); ?>
   <?php } else { ?>
      <span><?php echo $not_discounts; ?> </span>
   <?php }  ?>
    <?php if($text_date_end) { ?>
    <div><b>Окончание скидок:</b> <output><span><?php echo $text_date_end; ?> </span> 00:00</output></div>
    <?php }  ?>
</div>
<?php echo $footer; ?>
<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <div>
    <div style="width: 32px;height:32px; float: left;">
    <?php if (isset($prev)) { ?>
      <a href="<?php echo $prev; ?>"><img src="catalog/view/theme/default/image/prev.png" /></a>
    <?php } ?>
    </div>
    <div style="width: 32px;height:32px; float: right; ">
    <?php if (isset($next)) { ?>
        <a href="<?php echo $next; ?>"><img src="catalog/view/theme/default/image/next.png" /></a>
    <?php } ?>    
    </div>
  </div>
  <div class="product-info">
    <?php if ($thumb || $images) { ?>
    <div class="left">
      <?php if ($thumb) { ?>
      <div class="image">
          <?php if($top_product){ ?>
          <img class="top_product" src="/image/hit-small.png" alt="Хит продаж">
          <?php }?>
          <a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="colorbox"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" /></a>
      </div>
      <?php } ?>
      <?php if ($images) { ?>
      <div class="image-additional">
        <?php foreach ($images as $image) { ?>
        <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" class="colorbox"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
        <?php } ?>
      </div>
      <?php } ?>
    </div>
    <?php } ?>
    <div class="right">
	<h1><?php echo $heading_title; ?></h1>
      <div class="description">
        <?php if ($manufacturer) { ?>
        <span><?php echo $text_manufacturer; ?></span> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a><br />
        <?php } ?>
        <span><?php echo $text_model; ?></span> <?php echo $model; ?><br />
        <?php if ($reward) { ?>
        <span><?php echo $text_reward; ?></span> <?php echo $reward; ?><br />
        <?php } ?>
      </div>
      
      <?php if ($download) { ?>
      <div class="download">
      <h2><?php echo $text_list; ?></h2><br />
          <a href="<?php echo $download['href']; ?>"><?php echo $download['name']; ?></a>
      </div>
      <br />
      <?php } ?>
    </div>
     
      <div class="options">
        <h2><?php echo $text_option; ?></h2>
        <br />
        <table border="1">
            <thead>
                <tr>
                    <?if($height):?><td><?php echo $td_height; ?></td><?endif?>
                    <?if($width):?><td><?php echo $td_width; ?></td><?endif?>
                    <?if($location):?><td><?php echo $td_plant; ?></td><?endif?>
                    <?if($length):?><td><?php echo $td_packing; ?></td><?endif?>
                    <td width="70"><?php echo $td_price; ?></td>
                    <td><?php echo $td_buy; ?></td>
                </tr>
            </thead>
            <tbody>

                <tr>
                    <?if($height):?><td><?php echo $height; ?></td><?endif?>
                    <?if($width):?><td><?php echo $width; ?></td><?endif?>
                    <?if($location):?><td><?php echo $location; ?></td><?endif?>
                    <?if($length):?><td><?php echo $length; ?></td><?endif?>
                    <td>
                        <?php if ($price) { ?>
                          <div>
                            <?php if (!$special) { ?>
                            <?php echo $price; ?>
                            <?php } else { ?>
                            <span class="price-old"><?php echo $price; ?></span> <span class="price-new"><?php echo $special; ?></span>
                            <?php } ?>
                            <br />
                            <?php if ($tax) { ?>
                            <span class="price-tax"><?php echo $text_tax; ?> <?php echo $tax; ?></span><br />
                            <?php } ?>
                            <?php if ($points) { ?>
                            <span class="reward"><small><?php echo $text_points; ?> <?php echo $points; ?></small></span><br />
                            <?php } ?>
                            <?php if ($discounts) { ?>
                            <br />
                            <div class="discount">
                              <?php foreach ($discounts as $discount) { ?>
                              <?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?><br />
                              <?php } ?>
                            </div>
                            <?php } ?>
                          </div>
                          <?php } ?>
                    </td>
                    <td>
                        <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
                        <?php if($quantity > 0){ ?>
                          <input type="button" value="<?php echo $button_cart; ?>" class="button"  name="0" id="0" />
                            <?php if ($minimum > 1) { ?>
                            <div class="minimum"><?php echo $text_minimum; ?></div>
                            <?php } ?>
                        <?php } else { ?>
                            <span>Нет в наличии</span>
                        <?php } ?>
                    </td>
                </tr>

                <?php if ($options) { ?>
                <?php foreach ($options as $option) { ?>
                    <?php if ($option['type'] == 'table') { ?>
                    <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
                      <?php if ($option['required']) { ?>
                      <span class="required">*</span>
                      <?php } ?>
                            <?php foreach ($option['option_value'] as $option_value) { ?>
                            <tr>
                                <?php if ($option_value['height']) { ?>
                                    <td><?php echo $option_value['height']; ?></td>
                                <?php } ?>
                                <?php if ($option_value['width']) { ?>
                                    <td><?php echo $option_value['width']; ?></td>
                                <?php } ?>
                                <?php if ($option_value['plant']) { ?>
                                    <td><?php echo $option_value['plant']; ?></td>
                                <?php } ?>
                                <?php if ($option_value['packing']) { ?>
                                    <td><?php echo $option_value['packing']; ?></td>
                                <?php } ?>
                                <?php if ($option_value['price']) { ?>
                                    <td width="80"> <?php echo $option_value['price']; ?></td>
                                <?php } ?>
                                <td>
                                <input type="button" value="<?php echo $button_cart; ?>" class="button"  name="<?php echo $option['product_option_id']; ?>" id="<?php echo $option_value['product_option_value_id']; ?>" />
                                </td>
                            </tr>
                            <?php } ?>   
                        </div>
                    <?php } ?>
                <?php } ?>
                <?php } ?>
                </tbody>
            </table>
      </div>
  </div>
  <div id="tabs" class="htabs"><a href="#tab-description"><?php echo $tab_description; ?></a>
    <?php if ($attribute_groups) { ?>
    <a href="#tab-attribute"><?php echo $tab_attribute; ?></a>
    <?php } ?>

    <?php if ($products) { ?>
    <a href="#tab-related"><?php echo $tab_related; ?> (<?php echo count($products); ?>)</a>
    <?php } ?>
  </div>
  <div id="tab-description" class="tab-content"><?php echo $description; ?></div>
  <?php if ($attribute_groups) { ?>
  <div id="tab-attribute" class="tab-content">
    <table class="attribute">
      <?php foreach ($attribute_groups as $attribute_group) { ?>
      <thead>
        <tr>
          <td colspan="2"><?php echo $attribute_group['name']; ?></td>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
        <tr>
          <td><?php echo $attribute['name']; ?></td>
          <td><?php echo $attribute['text']; ?></td>
        </tr>
        <?php } ?>
      </tbody>
      <?php } ?>
    </table>
  </div>
  <?php } ?>
 
  <?php if ($products) { ?>
  <div id="tab-related" class="tab-content">
    <div class="box-product">
      <?php foreach ($products as $product) { ?>
      <div>
        <?php if ($product['thumb']) { ?>
        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
        <?php if ($product['price']) { ?>
        <div class="price">
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
          <?php } ?>
        </div>
        <?php } ?>
        
        <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button"><?php echo $button_cart; ?></a></div>
      <?php } ?>
    </div>
  </div>
  <?php } ?>
  <?php if ($tags) { ?>
  <div class="tags"><b><?php echo $text_tags; ?></b>
    <?php for ($i = 0; $i < count($tags); $i++) { ?>
    <?php if ($i < (count($tags) - 1)) { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
    <?php } else { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
    <?php } ?>
    <?php } ?>
  </div>
  <?php } ?>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('.colorbox').colorbox({
		overlayClose: true,
		opacity: 0.5,
		rel: "colorbox"
	});
    $('.box-cart').click(function(e){
        e.stopPropagation();
    });

    $('#message-cart,.cart-close,.cart-btn-close').click(function (e) {
        e.stopPropagation();
        $('#message-cart').fadeOut(500,0);
    });

    $('.cart-btn-show').click(function (e) {
        e.stopPropagation();
        location.href = '/index.php?route=checkout/cart';
    });

});
//--></script> 
<script type="text/javascript"><!--

$('.button').bind('click', function() {
    var value = $(this).prev().val();
    var arr = $(this).prev().attr('name');
    $.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: {product_id:$(".product-info input[name=\'product_id\']").val(), option:$(this).attr('id'), array:$(this).attr('name')},
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, .information, .error').remove();
			
			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						$('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
					}
				}
			} 
			
			if (json['success']) {
                $("#message-cart").fadeTo(500,1);
                $('#cart-total').html(json['total']);
                setTimeout(function(){
                //$("#message-cart").fadeOut("slow");
                }, 2000);

			}	
		}
	});
});
//--></script>
<?php if ($options) { ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
<?php foreach ($options as $option) { ?>
<?php if ($option['type'] == 'file') { ?>
<script type="text/javascript"><!--
new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
	action: 'index.php?route=product/product/upload',
	name: 'file',
	autoSubmit: true,
	responseType: 'json',
	onSubmit: function(file, extension) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="catalog/view/theme/default/image/loading.gif" class="loading" style="padding-left: 5px;" />');
		$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', true);
	},
	onComplete: function(file, json) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', false);
		
		$('.error').remove();
		
		if (json['success']) {
			alert(json['success']);
			
			$('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json['file']);
		}
		
		if (json['error']) {
			$('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json['error'] + '</span>');
		}
		
		$('.loading').remove();	
	}
});
//--></script>
<?php } ?>
<?php } ?>
<?php } ?>

<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script> 
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
$(document).ready(function() {
	if ($.browser.msie && $.browser.version == 6) {
		$('.date, .datetime, .time').bgIframe();
	}

	$('.date').datepicker({dateFormat: 'yy-mm-dd'});
	$('.datetime').datetimepicker({
		dateFormat: 'yy-mm-dd',
		timeFormat: 'h:m'
	});
	$('.time').timepicker({timeFormat: 'h:m'});
});
//--></script> 
<?php echo $footer; ?>
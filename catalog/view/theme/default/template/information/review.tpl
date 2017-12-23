<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>
  
<div id="review-form">
    <div class="left">
        <b><?php echo $entry_name; ?></b><br />
        <input type="text" name="name" value="" /><br />
        <div style="width: 245px; position: absolute; bottom: 65px;">
            Нажимая кнопку «Отправить отзыв», я подтверждаю, что ознакомлен и согласен с <a target="_blank" href="/index.php?route=information/information&information_id=53">политикой конфиденциальности</a>> этого сайта
        </div>
    </div>
    <div class="right">
        <b><?php echo $entry_enquiry; ?></b><br />
        <textarea name="enquiry" cols="30" rows="14" ></textarea><br />
        <div><a id="button-review" class="button"><?php echo $button_continue; ?></a></div>
    </div>
</div>
 <div id="review"></div> 
  <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>
<script type="text/javascript"><!--
$('#review .pagination a').live('click', function() {
	$('#review').fadeOut('slow');
		
	$('#review').load(this.href);
	
	$('#review').fadeIn('slow');
	
	return false;
});			

$('#review').load('index.php?route=information/review/review');

$('#button-review').bind('click', function() {
	$.ajax({
		url: 'index.php?route=information/review/write',
		type: 'post',
		dataType: 'json',
		data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&enquiry=' + encodeURIComponent($('textarea[name=\'enquiry\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-review').attr('disabled', true);
			$('#review-form').before('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-review').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(data) {
			if (data['error']) {
				$('#review-form').before('<div class="warning">' + data['error'] + '</div>');
			}
			
			if (data['success']) {
				$('#review-form').before('<div class="success">' + data['success'] + '</div>');				
				$('input[name=\'name\']').val('');
				$('textarea[name=\'enquiry\']').val('');
				
			}
		}
	});
});
//--></script> 
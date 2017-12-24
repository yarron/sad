<?php echo $header; ?>
<div id="content">
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>
    <?php if ($error_warning) { ?>
        <div class="warning"><?php echo $error_warning; ?></div>
    <?php } ?>
    <?php if ($success) { ?>
        <div class="success"><?php echo $success; ?></div>
    <?php } ?>
    <div class="box">
        <div class="heading">
          <h1><img src="view/image/total.png" alt="" /> <?php echo $heading_title; ?></h1>
          <div class="buttons">
            <a onclick="location = '<?php echo $back; ?>';" class="button"><span><?php echo $button_back; ?></span></a>
            <a onclick="location = '<?php echo $insert; ?>'" class="button"><span><?php echo $button_insert; ?></span></a>
            <a onclick="$('form').submit();" class="button"><span><?php echo $button_delete; ?></span></a>
          </div>
        </div>
        <div class="content">
            <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
                <table class="list">
                  <thead>
                    <tr>
                      <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
                      <td class="left"> <?php echo $column_name; ?></td>
                      <td class="right"><?php echo $column_price; ?></td>
                      <td class="right"><?php echo $column_percent; ?></td>
                      <td class="right"><?php echo $column_sort_order; ?></td>
                      <td class="left"> <?php echo $column_status; ?></td>
                      <td class="right"><?php echo $column_action; ?></td>
                    </tr>
                  </thead>
                  <tbody>
                    <?php if ($discounts) { ?>
                    <?php foreach ($discounts as $discount) { ?>
                    <tr>
                      <td style="text-align: center;"><input type="checkbox" name="selected[]" value="<?php echo $discount['discount_id']; ?>" /></td>
                      <td class="left"> <?php echo $discount['name']; ?></td>
                      <td class="right"><?php echo $discount['price']; ?></td>
                      <td class="right"><?php echo $discount['percent']; ?></td>
                      <td class="right"><?php echo $discount['sort_order']; ?></td>
                      <td class="left">
                        <?php if($discount['status'] == '1') {?> 
                            <?php echo $text_enabled; ?>
                        <?php } else {?>  
                            <?php echo $text_disabled; ?>
                        <?php }?>     
                      </td>
                      <td class="right">
                        [ <a href="<?php echo $update.'&discount_id='.$discount['discount_id']; ?>"><?php echo $text_action; ?></a> ]
                      </td>
                    </tr>
                    <?php } ?>
                    <?php } else { ?>
                    <tr>
                      <td class="center" colspan="7"><?php echo $text_no_results; ?></td>
                    </tr>
                    <?php } ?>  
                  </tbody>
                </table>
          </form>
        </div>
  </div>
</div>

<?php echo $footer; ?>
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
    <div class="box">
        <div class="heading">
          <h1><img src="view/image/total.png" alt="" /> <?php echo $heading_title; ?></h1>
          <div class="buttons">
            <a onclick="location = '<?php echo $modulator; ?>';" class="button"><span><?php echo $button_modulator; ?></span></a>
            <a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a>
            <a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a>
          </div>
        </div>
        <div class="content">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
         
        <table class="form">
          
          <tr>
            <td><?php echo $entry_status; ?></td>
            <td><select name="discount_status">
                <?php if ($discount_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_sort_order; ?></td>
            <td><input type="text" name="discount_sort_order" value="<?php echo $discount_sort_order; ?>" size="1" /></td>
          </tr>
            <tr>
                <td><?php echo $entry_date_start; ?></td>
                <td><input type="text" name="discount_date_start" value="<?php echo $discount_date_start; ?>" size="12" class="date"  /></td>
            </tr>
            <tr>
                <td><?php echo $entry_date_end; ?></td>
                <td><input type="text" name="discount_date_end" value="<?php echo $discount_date_end; ?>" size="12" class="date"  /></td>
            </tr>
        </table>
        <div id="languages" class="htabs">
            <?php foreach ($languages as $language) { ?>
            <a href="#language<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
            <?php } ?>
        </div> 
        <?php foreach ($languages as $language) { ?>
        <div id="language<?php echo $language['language_id']; ?>">
            <table class="form">
              <tr>
                <td><?php echo $entry_description_head; ?><br /><span class="help"><?php echo $entry_sub_description_head; ?></span></td>
                <td><textarea name="discount_description[<?php echo $language['language_id']; ?>][before]" id="description_before<?php echo $language['language_id']; ?>"><?php echo isset($discount_description[$language['language_id']]['before']) ? $discount_description[$language['language_id']]['before'] : ''; ?></textarea></td>
              </tr>
              <tr>
                <td><?php echo $entry_description_end; ?><br /><span class="help"><?php echo $entry_sub_description_end; ?></span></td>
                <td><textarea name="discount_description[<?php echo $language['language_id']; ?>][after]" id="description_after<?php echo $language['language_id']; ?>"><?php echo isset($discount_description[$language['language_id']]['after']) ? $discount_description[$language['language_id']]['after'] : ''; ?></textarea></td>
              </tr>
              
            </table>
        </div>
        <?php } ?>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('description_before<?php echo $language['language_id']; ?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
CKEDITOR.replace('description_after<?php echo $language['language_id']; ?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php } ?>
//--></script> 
<script type="text/javascript"><!--

$('#languages a').tabs();
$('.date').datepicker({dateFormat: 'yy-mm-dd'});

//--></script> 
<?php echo $footer; ?>
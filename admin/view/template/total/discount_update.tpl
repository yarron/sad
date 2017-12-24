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
            <a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a>
            <a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a>
          </div>
        </div>
        <div class="content">
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
                <table class="form">
                    <tr>
                        <td><?php echo $entry_name; ?><span class="required">*</span></td>
                        <td><input type="text" name="name" maxlength="255" size="100" value="<?php echo $name; ?>" />
                        <?php if ($error_name) { ?>
                        <span class="error"><?php echo $error_name; ?></span>
                        <?php } ?>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_status; ?></td>
                        <td>
                          <select name="status">
                           <?php if ($status) { ?>
                           <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                           <option value="0"><?php echo $text_disabled; ?></option>
                           <?php } else { ?>
                           <option value="1"><?php echo $text_enabled; ?></option>
                           <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                           <?php } ?>
                          </select>
                        </td>
                    </tr>
  
                    <tr>
                        <td><?php echo $entry_sort_order; ?></td>
                        <td><input type="text" name="sort_order" value="<?php echo $sort_order; ?>" size="1" /></td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_price; ?><span class="required">*</span><span class="help"><?php echo $entry_sub_price; ?></span></td>
                        <td><input type="text" name="price" value="<?php echo $price; ?>"  />
                        <?php if ($error_price) { ?>
                        <span class="error"><?php echo $error_price; ?></span>
                        <?php } ?>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $entry_percent; ?><span class="required">*</span><span class="help"><?php echo $entry_sub_percent; ?></span></td>
                        <td><input type="text" name="percent" value="<?php echo $percent; ?>"  />
                        <?php if ($error_percent) { ?>
                        <span class="error"><?php echo $error_percent; ?></span>
                        <?php } ?>
                        </td>
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
                            <td><?php echo $entry_description; ?><br /><span class="help"><?php echo $entry_sub_description; ?></span></td>
                            <td><textarea name="discount_description[<?php echo $language['language_id']; ?>][description]" id="description<?php echo $language['language_id']; ?>"><?php echo isset($discount_description[$language['language_id']]) ? $discount_description[$language['language_id']]['description'] : ''; ?></textarea></td>
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
CKEDITOR.replace('description<?php echo $language['language_id']; ?>', {
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
//--></script> 
<?php echo $footer; ?>
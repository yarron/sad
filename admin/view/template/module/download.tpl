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
    <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
  </div>
  <div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
            <tr>
                <td style="width: 225px"><?php echo $entry_category; ?> <span class="required">*</span></td>
                <td>
                    <? if (isset($setting['category_name'])) :?>
                    <input name="download_settings[category_name]" value="<?php echo $setting['category_name']; ?>" />
                    <? else :?>
                    <input name="download_settings[category_name]" value="" />
                    <? endif ?>
                    <?php if ($error_category_root) { ?>
                    <span class="error"><?php echo $error_category_root; ?></span>
                    <?php } ?>
                </td>
            </tr>
        </table>
      <table id="category" class="list">
        <thead>
            <tr>
                <td class="left"><b><?php echo $text_category; ?> <span class="required">*</span></b></td>
                <td class="left"><b><?php echo $text_download; ?></b></td>
                <td class="right"><b><?php echo $text_sort_order; ?></b></td>
                <td class="left"></td>
            </tr>
        </thead>
        <?php $category_row = 0; ?>
        <?php foreach ($categories as $k=>$category) { ?>
        <tbody id="category-row<?php echo $category_row; ?>">
        <tr>
            <td class="left">
                <input name="download_categories[<?php echo $category_row; ?>][category]" value="<?php echo $category['category']; ?>" />
                <?php if (isset($error_category[$k])) { ?>
                <span class="error"><?php echo $error_category[$k]; ?></span>
                <?php } ?>
            </td>
            <td class="left">
                <select name="download_categories[<?php echo $category_row; ?>][download]">
                    <option value="0" ><?php echo $text_no_download; ?></option>
                    <?php foreach($downloads as $download) { ?>
                        <?php if (array_key_exists($category_row, $categories) && $categories[$category_row]['download'] == $download['download_id'] ) { ?>
                        <option value="<?php echo $download['download_id']; ?>" selected="selected" ><?php echo $download['name']; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $download['download_id']; ?>" ><?php echo $download['name']; ?></option>
                        <?php } ?>
                    <?php } ?>
                </select>
            </td>
            <td class="right">
                <input name="download_categories[<?php echo $category_row; ?>][sort_order]" value="<?php echo $category['sort_order']; ?>" size="3" />
            </td>
            <td class="left"><a onclick="$('#category-row<?php echo $category_row; ?>').remove();" class="button"><span><?php echo $button_remove_category; ?></span></a></td>
        </tr>
        </tbody>
        <?php $category_row++; ?>
        <?php } ?>
        <tfoot>
        <tr>
          <td colspan="3"></td>
          <td class="left"><a onclick="addCategory();" class="button"><span><?php echo $button_add_category; ?></span></a></td>
        </tr>
        </tfoot>
	  </table>
      <table id="module" class="list">
        <thead>
          <tr>
            <td class="left"><?php echo $entry_layout; ?></td>
            <td class="left"><?php echo $entry_position; ?></td>
            <td class="left"><?php echo $entry_status; ?></td>
            <td class="right"><?php echo $entry_sort_order; ?></td>
            <td></td>
          </tr>
        </thead>
        <?php $module_row = 0; ?>
        <?php foreach ($modules as $module) { ?>
        <tbody id="module-row<?php echo $module_row; ?>">
          <tr>
            <td class="left"><select name="download_module[<?php echo $module_row; ?>][layout_id]">
                <?php foreach ($layouts as $layout) { ?>
                <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
            <td class="left"><select name="download_module[<?php echo $module_row; ?>][position]">
                <?php if ($module['position'] == 'content_top') { ?>
                <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                <?php } else { ?>
                <option value="content_top"><?php echo $text_content_top; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'content_bottom') { ?>
                <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                <?php } else { ?>
                <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'column_left') { ?>
                <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
                <?php } else { ?>
                <option value="column_left"><?php echo $text_column_left; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'column_right') { ?>
                <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
                <?php } else { ?>
                <option value="column_right"><?php echo $text_column_right; ?></option>
                <?php } ?>
              </select></td>
            <td class="left"><select name="download_module[<?php echo $module_row; ?>][status]">
                <?php if ($module['status']) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
            <td class="right"><input type="text" name="download_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
            <td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>
          </tr>
        </tbody>
        <?php $module_row++; ?>
        <?php } ?>
        <tfoot>
          <tr>
            <td colspan="4"></td>
            <td class="left"><a onclick="addModule();" class="button"><span><?php echo $button_add_module; ?></span></a></td>
          </tr>
        </tfoot>
      </table>
    </form>
  </div>
</div>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;
var category_row = <?php echo $category_row; ?>;

function addCategory() {
    html  = '<tbody id="category-row' + category_row + '">';
    html += '<tr>';
    html += '<td class="left"><input name="download_categories[' + category_row + '][category]" value="" /></td>';
    html += '<td class="left"><select name="download_categories[' + category_row + '][download]">';
    html += '<option value="0"><?php echo $text_no_download; ?></option>';
    <?php foreach ($downloads as $download) { ?>
        html += '<option value="<?php echo $download['download_id']; ?>"><?php echo $download['name']; ?></option>';
    <?php } ?>
    html += '</select></td>';
    html += '<td class="right"><input name="download_categories[' + category_row + '][sort_order]" value="" size=3"" /></td>';
    html += '<td class="left"><a onclick="$(\'#category-row' + category_row + '\').remove();" class="button"><span><?php echo $button_remove_category; ?></span></a></td>';
    html += '</tr>';
    html += '</tbody>';

    $('#category tfoot').before(html);
    category_row++;
}
function addModule() {	
	html  = '<tbody id="module-row' + module_row + '">';
	html += '  <tr>';
	
	html += '    <td class="left"><select name="download_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="left"><select name="download_module[' + module_row + '][position]">';
	html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '    </select></td>';
	html += '    <td class="left"><select name="download_module[' + module_row + '][status]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
	html += '    <td class="right"><input type="text" name="download_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
	html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#module tfoot').before(html);
	
	module_row++;
}
//--></script>
<?php echo $footer; ?>
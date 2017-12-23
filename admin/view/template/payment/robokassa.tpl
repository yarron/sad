<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { 
	foreach($error_warning as $err) {
  ?>
  <div class="warning"><?php echo $err; ?></div>
  <?php } } ?>
  <?php if ($success) { 
  ?>
  <div class="success"><?php echo $success; ?></div>
  <?php }  ?>
  
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/payment.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#robokassa_stay').attr('value', '0'); $('#form').submit();" class="button"><span><?php echo $button_save_and_go; ?></span></a><a onclick="$('#robokassa_stay').attr('value', '1'); $('#form').submit();" class="button"><span><?php echo $button_save_and_stay; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
    </div>
    <div class="content">
      <form  autocomplete="off"   action="<?php echo $action; ?>" method="post"  autocomplete="off" enctype="multipart/form-data" id="form">
	  <input type="hidden" name="robokassa_stay" id="robokassa_stay" value="0">
	  <input type="hidden" name="current_store_id" id="current_store_id" value="0">
	  
	  <div class="htabs" id="tabs">
		<a href="#tab-general" style="display: inline;" <?php if( empty($current_store_id) ) { ?> class="selected" <?php } ?> 
		 onclick="$('#current_store_id').attr('value', '0');" 
		><?php echo $tab_general; ?></a>
		<?php foreach($stores as $store) { ?>
			<a href="#tab-general-<?php echo $store['store_id']; ?>" 
				onclick="$('#current_store_id').attr('value', '<?php echo $store['store_id']; ?>');" 
				style="display: inline;"
				id="tab-<?php echo $store['store_id']; ?>"
				 <?php if( $current_store_id == $store['store_id'] ) { ?> class="selected" <?php } ?> 
				><?php echo $store['name']; ?></a>
		<?php } ?>

          <a href="#tab-order" style="display: inline;" onclick="$('#current_store_id').attr('value', '0');">
              <?php echo $tab_order; ?>
          </a>
          <a href="#tab-methods" style="display: inline;" onclick="$('#current_store_id').attr('value', '0');">
              <?php echo $tab_methods; ?>
          </a>
          <a href="#tab-email" style="display: inline;" onclick="$('#current_store_id').attr('value', '0');">
              <?php echo $tab_email; ?>
          </a>
          <a href="#tab-discount" style="display: inline;" onclick="$('#current_store_id').attr('value', '0');">
              <?php echo $tab_discount; ?>
          </a>
          <?php /* kin insert metka: u1 */ ?>
          <?php if( !empty( $robokassa_shop_login ) ) { ?>
          <a href="#tab-generation" style="display: inline;" onclick="$('#current_store_id').attr('value', '0');">
              <?php echo $tab_generation; ?>
          </a>
          <?php } ?>
          <?php /* end kin metka */ ?>
          <a href="#tab-sms" style="display: none; visibility:hidden" onclick="$('#current_store_id').attr('value', '0');">
              <?php echo $tab_sms; ?>
          </a>
	  </div>
	  <div id="tab-general" style="display: block;">
        <table class="form">

          <tr>
            <td width=200><?php echo $entry_status; ?></td>
            <td><select name="robokassa_status">
                <?php if ($robokassa_status) { ?>
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
                <td><input type="text" name="robokassa_sort_order" value="<?php echo $robokassa_sort_order; ?>" size="1" /></td>
            </tr>
          <tr>
            <td><?php echo $entry_shop_login; ?></td>
            <td><input type="text" name="robokassa_shop_login" autocomplete="off" value="<?php echo $robokassa_shop_login; ?>" />
			</td>
          </tr>
		  <?php /* start update: a1 */ ?>
          <tr>
            <td><?php echo $entry_password1; ?></td>
            <td><input type="text" autocomplete="off"  name="robokassa_p1" /> <?php if($robokassa_password1) echo $text_saved; ?>
			</td>
          </tr>
		  <tr>
            <td><?php echo $entry_password2; ?></td>
            <td><input type="text"  autocomplete="off"  name="robokassa_p2" /> <?php if($robokassa_password2) echo $text_saved; ?></td>
          </tr>
		  
		  <tr>
            <td><?php echo $entry_result_url; ?>:</td>
            <td>http://<?php echo $_SERVER['HTTP_HOST']; ?>/index.php?route=payment/robokassa/result</td>
          </tr>
          
		  <tr>
            <td><?php echo $entry_result_method; ?></td>
            <td>POST</td>
          </tr>
          
		  <tr>
            <td><?php echo $entry_success_url; ?></td>
            <td>http://<?php echo $_SERVER['HTTP_HOST']; ?>/index.php?route=checkout/robosuccess</td>
          </tr>
          
		  <tr>
            <td><?php echo $entry_success_method; ?></td>
            <td>POST</td>
          </tr>
          
		  <tr>
            <td><?php echo $entry_fail_url; ?></td>
            <td>http://<?php echo $_SERVER['HTTP_HOST']; ?>/index.php?route=payment/robokassa/fail</td>
          </tr>
          
		  <tr>
            <td><?php echo $entry_fail_method; ?></td>
            <td>POST</td>
          </tr>
          
		  
		  
		  <tr>
            <td><?php echo $entry_test_mode; ?></td>
            <td><select name="robokassa_test_mode">
                <?php if ($robokassa_test_mode) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
			  <?php /* start update: a1 */ ?>
			  <?php /* end update: a1 */ ?>
			  </td>
          </tr>
		  
		  
		  
          <tr>
            <td><?php echo $entry_icons; ?></td>
            <td><select name="robokassa_icons">
                <?php if ($robokassa_icons) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>
		  
		  




		  </table>
		  
		  <table id="block_before0"  class="form" width=100%>


		  </table>
		  
		  <div id="block_after0"></div>
		  
		  <div id="block_premod0">
		  <table class="form" width=100%>
		  <tr>
            <td><?php echo $entry_order_comment; ?></td>
            <td>
			<?php foreach ($languages as $language) { ?>
              <textarea cols=50 rows=7 
			  name="robokassa_premod_order_comment[<?php echo $language['code']; ?>]"
			  ><?php echo isset($robokassa_premod_order_comment[$language['code']]) ? $robokassa_premod_order_comment[$language['code']] : '';
			  ?></textarea><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
			  <?php } ?>
			</td>
          </tr>
		  <tr>
            <td><?php echo $entry_confirm_comment; ?></td>
            <td>
			<?php foreach ($languages as $language) { ?>
              <textarea cols=50 rows=7 
			  name="robokassa_premod_confirm_comment[<?php echo $language['code']; ?>]"
			  ><?php echo isset($robokassa_premod_confirm_comment[$language['code']]) ? $robokassa_premod_confirm_comment[$language['code']] : '';
			  ?></textarea><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
			  <?php } ?>
			</td>
          </tr>
		  <tr>
            <td width=200><?php echo $entry_preorder_status; ?></td>
            <td><select name="robokassa_premod_preorder_status_id">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $robokassa_premod_preorder_status_id) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
		  <tr>
            <td><?php echo $entry_hide_order_comment; ?>
			<br><br><?php echo $entry_order_comment_notice; ?>
			
			</td>
            <td>
			<?php foreach ($languages as $language) { ?>
              <textarea cols=50 rows=7 
			  name="robokassa_premod_hide_order_comment[<?php echo $language['code']; ?>]"
			  ><?php echo isset($robokassa_premod_hide_order_comment[$language['code']]) ? $robokassa_premod_hide_order_comment[$language['code']] : '';
			  ?></textarea><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
			  <?php } ?>
			</td>
          </tr>
		  
		  <tr>
            <td width=200><?php echo $entry_premod_success_page_type; ?></td>
            <td><select name="robokassa_premod_success_page_type" id="robokassa_premod_success_page_type"
			
				onchange="show_success_page_block()">
                <?php if ($robokassa_premod_success_page_type == 'common') { ?>
                <option value="common" selected="selected"><?php echo $text_premod_success_page_type_common; ?></option>
                <option value="custom"><?php echo $text_premod_success_page_type_custom; ?></option>
                <?php } else { ?>
                <option value="common"><?php echo $text_premod_success_page_type_common; ?></option>
                <option value="custom" selected="selected"><?php echo $text_premod_success_page_type_custom; ?></option>
                <?php } ?>
              </select>
			  <div id="success_page_notice"
			  style="display: none;"><?php echo $entry_premod_success_page_notice; ?></div>
			  
			  </td>
          </tr>
		  </table>
		  
		  <div id="block_success_page" style="display: none;">
		  <table class="form" width=100%>
		  <tr>
            <td width=200><?php echo $entry_premod_success_page_header; ?></td>
            <td>
			<?php foreach ($languages as $language) { ?>
              <input type="text" style="width: 300px";
			  name="robokassa_premod_success_page_header[<?php echo $language['code']; ?>]"
			  value="<?php echo isset($robokassa_premod_success_page_header[$language['code']]) ? $robokassa_premod_success_page_header[$language['code']] : '';
			  ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
			  <?php } ?>
			</td>
		   </tr>
		  <tr>
            <td width=200><?php echo $entry_premod_success_page_text; ?></td>
            <td>
			<?php foreach ($languages as $language) { ?>
              <textarea cols=50 rows=7 
			  name="robokassa_premod_success_page_text[<?php echo $language['code']; ?>]"
			  ><?php echo isset($robokassa_premod_success_page_text[$language['code']]) ? $robokassa_premod_success_page_text[$language['code']] : '';
			  ?></textarea><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
			  <?php } ?>
			</td>
		   </tr>
		   </table>
		  </div>
		</div>
		  
			<script>
				function show_success_page_block()
				{	
					var e = document.getElementById("robokassa_premod_success_page_type");
					
					if( e.selectedIndex == 0 )
					{
						document.getElementById("block_success_page").style.display = 'none';	
						document.getElementById("success_page_notice").style.display = 'none';
					
					}
					else
					{
						document.getElementById("block_success_page").style.display = 'block';
						document.getElementById("success_page_notice").style.display = 'block';
					
					}
				}
				
				show_success_page_block();
			</script>
		  
		  
		  
		<table class="form">	

		  <tr>
            <td><?php echo $entry_commission; ?></td>
            <td>
				<p><input type="radio" name="robokassa_commission" value="j" id="robokassa_commission_j"
				<?php if( $robokassa_commission == 'j' ) { ?> checked <?php } ?>
				>
				<label for="robokassa_commission_j"><?php echo $text_commission_j; ?></label></p>
				
				<p><input type="radio" name="robokassa_commission" value="customer" id="robokassa_commission_customer"
				<?php if( $robokassa_commission == 'customer' ) { ?> checked <?php } ?>
				>
				<label for="robokassa_commission_customer"><?php echo $text_commission_customer; ?></label></p>
				
				<p><input type="radio" name="robokassa_commission" value="shop" id="robokassa_commission_shop"
				<?php if( $robokassa_commission == 'shop' ) { ?> checked <?php } ?>
				>
				<label for="robokassa_commission_shop"><?php echo $text_commission_shop; ?></label></p>
			
			</td>
          </tr>
		  

		  
		  

		  
		  

		  	  
          <tr>
            <td><?php echo $entry_interface_language; ?></td>
            <td><select name="robokassa_interface_language" id="robokassa_interface_language" onchange="show_hide_lang_block(this.value, 0)">
                <option value="ru" 
				<?php if( $robokassa_interface_language == 'ru' ) { ?>
				selected="selected"
				<?php } ?>
				><?php echo $entry_interface_language_ru; ?></option>
                <option value="en"
				<?php if( $robokassa_interface_language == 'en' ) { ?>
				selected="selected"
				<?php } ?>><?php echo $entry_interface_language_en; ?></option>
                <option value="detect"
				<?php if( $robokassa_interface_language == 'detect' ) { ?>
				selected="selected"
				<?php } ?>><?php echo $entry_interface_language_detect; ?></option>
              </select></td>
          </tr>
		  
		  
		  
		  
		  </table>
		  
		  
		  <table class="form" id="lang_block0"  width=100%>
          <tr>
            <td width="200"><?php echo $entry_default_language; ?></td>
            <td><select name="robokassa_default_language">
			
			<option value="ru" 
				<?php if( $robokassa_default_language == 'ru' ) { ?>
				selected="selected"
				<?php } ?>
				><?php echo $entry_interface_language_ru; ?></option>
                <option value="en"
				<?php if( $robokassa_default_language == 'en' ) { ?>
				selected="selected"
				<?php } ?>><?php echo $entry_interface_language_en; ?></option>
              </select></td>
          </tr>
		  </table>
		  
		  
		  
		  <table class="form" width=100%>	
          <tr>
            <td width="200"><?php echo $entry_log; ?></td>
            <td><select name="robokassa_log">
                <?php if ($robokassa_log) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>


        </table>
		</div>
        <div id="tab-sms">
            <table class="form">
                <tr>
                    <td><?php echo $entry_sms_status; ?></td>
                    <td><select name="robokassa_sms_status">
                            <?php if ($robokassa_sms_status) { ?>
                            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                            <option value="0"><?php echo $text_disabled; ?></option>
                            <?php } else { ?>
                            <option value="1"><?php echo $text_enabled; ?></option>
                            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                            <?php } ?>
                        </select>
                        <p><?php echo $entry_sms_instruction; ?></p>
                    </td>
                </tr>
                <tr>
                    <td><?php echo $entry_sms_phone; ?></td>
                    <td><input type="text" name="robokassa_sms_phone" value="<?php echo $robokassa_sms_phone; ?>" /></td>
                </tr>
                <tr>
                    <td><?php echo $entry_sms_message; ?></td>
                    <td><textarea cols=50 rows=7 name="robokassa_sms_message"
                        ><?php echo $robokassa_sms_message; ?></textarea></td>
                </tr>
            </table>
        </div>
        <div id="tab-email">
            <table class="form">
                <tr>
                    <td><?php echo $entry_paynotify; ?></td>
                    <td><select name="robokassa_paynotify">
                            <?php if ($robokassa_paynotify) { ?>
                            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                            <option value="0"><?php echo $text_disabled; ?></option>
                            <?php } else { ?>
                            <option value="1"><?php echo $text_enabled; ?></option>
                            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                            <?php } ?>
                        </select></td>
                </tr>

                <tr>
                    <td><?php echo $entry_paynotify_email; ?></td>
                    <td><input type="text" name="robokassa_paynotify_email" value="<?php echo $robokassa_paynotify_email; ?>" /></td>
                </tr>
                <tr>
                    <td width=200><?php echo $entry_confirm_notify; ?></td>
                    <td><select name="robokassa_confirm_notify">
                            <?php if ($robokassa_confirm_notify) { ?>
                            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                            <option value="0"><?php echo $text_disabled; ?></option>
                            <?php } else { ?>
                            <option value="1"><?php echo $text_enabled; ?></option>
                            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                            <?php } ?>
                        </select></td>
                </tr>
                <tr>
                    <td><?php echo $entry_confirm_comment; ?></td>
                    <td>
                        <?php foreach ($languages as $language) { ?>
              <textarea cols=50 rows=7
                        name="robokassa_confirm_comment[<?php echo $language['code']; ?>]"
              ><?php echo isset($robokassa_confirm_comment[$language['code']]) ? $robokassa_confirm_comment[$language['code']] : '';
			  ?></textarea><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
                        <?php } ?>
                    </td>
                </tr>
                <tr>
                    <td><?php echo $entry_order_comment; ?><br><br><?php echo $entry_order_comment_notice; ?></td>
                    <td>
                        <?php foreach ($languages as $language) { ?>
              <textarea cols=50 rows=7
                        name="robokassa_order_comment[<?php echo $language['code']; ?>]"
              ><?php echo isset($robokassa_order_comment[$language['code']]) ? $robokassa_order_comment[$language['code']] : '';
			  ?></textarea><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
                        <?php } ?>
                    </td>
                </tr>
            </table>
        </div>
        <div id="tab-discount">
          <table class="form">
              <tr>
                  <td><?php echo $entry_dopcost; ?></td>
                  <td><input type="text" name="robokassa_dopcost" id="robokassa_dopcosttype_text"
                             size=20 value="<?php echo $robokassa_dopcost; ?>"
                      >&nbsp;<select name="robokassa_dopcosttype" id="robokassa_dopcosttype_select"
                                     onchange="changeDopcost()">
                          <option value="int" <?php if($robokassa_dopcosttype == 'int') { ?> selected <?php } ?>
                          ><?php echo $text_dopcost_int; ?></option>

                          <option value="percent" <?php if($robokassa_dopcosttype == 'percent') { ?> selected <?php } ?>
                          ><?php echo $text_dopcost_percent; ?></option>

                          <option value="comission" <?php if($robokassa_dopcosttype == 'comission') { ?> selected <?php } ?>
                          ><?php echo $text_dopcost_comission; ?></option>
                      </select></td>
              </tr>
              <script>
                  function changeDopcost()
                  {
                      var e = document.getElementById("robokassa_dopcosttype_select");

                      if( e.selectedIndex == 2 )
                      {
                          document.getElementById("robokassa_dopcosttype_text").disabled = true;
                          document.getElementById("robokassa_dopcosttype_text").value = "";
                      }
                      else
                      {
                          document.getElementById("robokassa_dopcosttype_text").disabled = false;
                      }
                  }

                  changeDopcost();
              </script>

              <tr>
                  <td><?php echo $entry_dopcostname; ?></td>
                  <td>
                      <?php foreach ($languages as $language) { ?>
          <textarea cols=50 rows=7
                    name="robokassa_dopcostname[<?php echo $language['code']; ?>]"
          ><?php echo isset($robokassa_dopcostname[$language['code']]) ? $robokassa_dopcostname[$language['code']] : '';
          ?></textarea><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
                      <?php } ?>
                  </td>
              </tr>
          </table>
        </div>
        <div id="tab-order">
            <table class="form">
                <tr>
                    <td><?php echo $entry_script; ?></td>
                    <td>
                        <p><input type="radio" name="robokassa_confirm_status" value="before" id="robokassa_confirm_status_before"
                            <?php if( $robokassa_confirm_status == 'before' ) { ?> checked <?php } ?>
                            onclick="show_hide_block('before', 0)"
                            ><label for="robokassa_confirm_status_before"><?php echo $entry_script_before; ?></label></p>

                        <p><input type="radio" name="robokassa_confirm_status" value="after" id="robokassa_confirm_status_after"
                            <?php if( $robokassa_confirm_status == 'after' ) { ?> checked <?php } ?>
                            onclick="show_hide_block('after', 0)"
                            ><label for="robokassa_confirm_status_after"><?php echo $entry_script_after; ?></label></p>

                        <p><input type="radio" name="robokassa_confirm_status" value="premod" id="robokassa_confirm_status_premod"
                            <?php if( $robokassa_confirm_status == 'premod' ) { ?> checked <?php } ?>
                            onclick="show_hide_block('premod', 0)"
                            ><label for="robokassa_confirm_status_premod"><?php echo $entry_script_premod; ?></label></p>

                    </td>
                </tr>
                <tr>
                    <td width=200><?php echo $entry_preorder_status; ?></td>
                    <td><select name="robokassa_preorder_status_id">
                            <?php foreach ($order_statuses as $order_status) { ?>
                            <?php if ($order_status['order_status_id'] == $robokassa_preorder_status_id) { ?>
                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                            <?php } else { ?>
                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                            <?php } ?>
                            <?php } ?>
                        </select></td>
                </tr>
                <tr>
                    <td width=200><?php echo $entry_clear_order; ?></td>
                    <td><select name="robokassa_clear_order">
                            <?php if ($robokassa_clear_order) { ?>
                            <option value="1" selected="selected"><?php echo $entry_clear_order_yes; ?></option>
                            <option value="0"><?php echo $entry_clear_order_no; ?></option>
                            <?php } else { ?>
                            <option value="1"><?php echo $entry_clear_order_yes; ?></option>
                            <option value="0" selected="selected"><?php echo $entry_clear_order_no; ?></option>
                            <?php } ?>


                        </select>
                        <div><?php echo $entry_clear_order_notice; ?></div>
                    </td>
                </tr>
                <tr>
                    <td><?php echo $entry_order_status; ?></td>
                    <td><select name="robokassa_order_status_id">
                            <?php foreach ($order_statuses as $order_status) { ?>
                            <?php if ($order_status['order_status_id'] == $robokassa_order_status_id) { ?>
                            <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                            <?php } else { ?>
                            <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                            <?php } ?>
                            <?php } ?>
                        </select></td>
                </tr>
                <tr>
                    <td><?php echo $entry_geo_zone; ?></td>
                    <td><select name="robokassa_geo_zone_id">
                            <option value="0"><?php echo $text_all_zones; ?></option>
                            <?php foreach ($geo_zones as $geo_zone) { ?>
                            <?php if ($geo_zone['geo_zone_id'] == $robokassa_geo_zone_id) { ?>
                            <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                            <?php } else { ?>
                            <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                            <?php } ?>
                            <?php } ?>
                        </select></td>
                </tr>
                <!-- /* kin insert metka: d1 */ -->
                <tr>
                    <td><?php echo $entry_robokassa_desc; ?></td>
                    <td>
                        <?php foreach ($languages as $language) { ?>
                            <textarea cols=50 rows=7 name="robokassa_desc[<?php echo $language['code']; ?>]"><?php echo isset($robokassa_desc[$language['code']]) ? $robokassa_desc[$language['code']] : '';?>
                            </textarea>
                            <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
                        <?php } ?>
                    </td>
                </tr>
                <!-- /* end kin metka: d1 */ -->
                <?php /* kin insert metka: a4 */ ?>
                <tr>
                    <td><?php echo $entry_currency; ?></td>
                    <td><select name="robokassa_currency">
                            <?php foreach( $opencart_currencies as $currency=>$val ) { ?>
                            <option value="<?php echo $currency; ?>" <?php if( ($robokassa_currency && $currency==$robokassa_currency) || (!$robokassa_currency && $currency=='RUB' ) ) { ?> selected <?php } ?> ><?php echo $currency; ?></option>
                            <?php } ?>
                        </select>
                        <p><i><?php echo $text_currency_notice; ?></i></p>
                    </td>
                </tr>
                <?php /* end kin metka: a4 */ ?>

            </table>
        </div>
        <div id="tab-methods" style="display: block;">
          <table class="form">
              <tr>
                  <td colspan=2><b><?php echo $entry_methods; ?></b></td>
              </tr>
              <?php if( !$robokassa_shop_login ) { ?>
              <tr>
                  <td colspan=2><b><font color=red><?php echo $entry_no_methods; ?></font></b></td>
              </tr>
              <?php } elseif( !$currencies ) { ?>
              <tr>
                  <td colspan=2><?php echo $entry_no_robokass_methods; ?></td>
              </tr>
              <?php } else { ?>
              <tr>
                  <td colspan=2>
                      <div><?php echo $text_img_notice; ?></div><br>

                      <style>
                          .methods td, .methods th
                          {
                              border: 1px dotted #ccc;
                          }

                          .methods
                          {
                              border: 1px dotted #ccc;
                          }
                      </style>
                      <table cellpadding=5 cellspacing=0 class="methods">
                          <tr>
                              <th valign=top>#</th>
                              <th valign=top><?php echo $methods_col1; ?></th>
                              <th valign=top><?php echo $methods_col2; ?></th>
                              <th valign=top><?php echo $methods_col3; ?></th>
                              <th valign=top><?php echo $methods_col4; ?></th>
                              <th valign=top><?php echo $methods_col5; ?></th>
                          </tr>
                          <?php for($i=0; $i<20; $i++) { ?>
                          <tr>
                              <td>#<?php echo ($i+1); ?>
                                  <input type="hidden" name="robokassa<?php echo $i; ?>_sort_order" value="<?php
						if($i!=0) echo $i/10;
						else echo "0.01";
                                  ?>">
                              </td>
                              <td>

                                  <?php foreach ($languages as $language) { ?>
                                  <input type="text" size=60 name="robokassa_methods[<?php echo $i; ?>][<?php echo $language['code']; ?>]"
                                         value="<?php
						if( !empty($robokassa_methods[$i][$language['code']]) )
						echo $robokassa_methods[$i][$language['code']]; ?>"

                                         id="text_robokassa_<?php echo $language['code'];
						?>_0_<?php echo $i; ?>"

                                  >&nbsp;<img src="view/image/flags/<?php echo $language['image']; ?>"
                                              title="<?php echo $language['name']; ?>" /><br /><br>
                                  <?php } ?>

                              </td>
                              <td>

                                  <select name="robokassa_currencies[<?php echo $i; ?>]"
                                          onchange="show_img(<?php echo $i; ?>, this.value, 0)"
                                  >
                                      <option value="0"><?php echo $select_currency; ?></option>
                                      <?php foreach($currencies as $key=>$val) { ?>
                                      <option value="<?php echo $key; ?>" <?php
							if( $robokassa_currencies[$i]==$key ) { ?>selected<?php }?>
                                      ><?php echo $val; ?></option>
                                      <?php } ?>

                                      <?php /* start update: a3 */ ?>
                                      <option value="robokassa" <?php
							if( $robokassa_currencies[$i]=='robokassa' ) { ?> selected <?php } ?>
                                      ><?php echo $text_robokassa_method; ?></option>
                                      <?php /* end update: a3 */ ?>

                                  </select></td>
                              <td>


                                  <input type="text" size=20 name="robokassa_minprice[<?php echo $i; ?>]"
                                         value="<?php
						if( !empty($robokassa_minprice[$i]) )
						echo $robokassa_minprice[$i]; ?>"

                                  >
                              </td>

                              <td>


                                  <input type="text" size=20 name="robokassa_maxprice[<?php echo $i; ?>]"
                                         value="<?php
						if( !empty($robokassa_maxprice[$i]) )
						echo $robokassa_maxprice[$i]; ?>"

                                  >
                              </td>


                              <td>
                                  <div id="img0_<?php echo $i; ?>" style="display: <?php
								if( !empty($robokassa_currencies[$i]) ) echo 'block'; else echo 'none';?>;">

                                      <img src="<?php echo $robokassa_images[$i]['thumb']; ?>"
                                           id="thumb0_<?php echo $i; ?>">
                                      <input type="hidden"
                                             name="robokassa_images[]"
                                             id="image0_<?php echo $i; ?>"
                                             value="<?php echo $robokassa_images[$i]['value']; ?>">
                                      <br>
                                      <a onclick="image_upload('image0_<?php echo $i; ?>', 'thumb0_<?php echo $i; ?>');"
                                      ><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a
                                              onclick="$('#thumb0_<?php echo $i; ?>').attr('src', '<?php echo $no_image; ?>'); $('#image0_<?php echo $i; ?>').attr('value', '');"
                                      ><?php echo $text_clear; ?></a>

                                  </div>
                              </td>
                          </tr>
                          <?php } ?>
                      </table>
                  </td>
              </tr>
              <?php } ?>
          </table>
        </div>
		<!-- ////////////////////////////////////////////////////////////////// -->
		
		<?php foreach($stores as $STORE) { ?>
	  <div id="tab-general-<?php echo $STORE['store_id']; ?>" style="display: none;">
        <table class="form">
		  <tr>
			<td colspan=2>
				<b><?php echo $notice; ?></b>
			</td>
		  </tr>
          <tr>
            <td width=200><?php echo $entry_status; ?></td>
            <td><select name="robokassa_status_store[<?php echo $STORE['store_id']; ?>]">
                <?php if( $robokassa_status_store[ $STORE['store_id'] ] ) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_shop_login; ?></td>
            <td><input type="text" name="robokassa_shop_login_store[<?php echo $STORE['store_id']; ?>]" 
			value="<?php echo $robokassa_shop_login_store[ $STORE['store_id'] ]; ?>" /></td>
          </tr>
		  <?php /* start update: a1 */ ?>
          <tr>
            <td><?php echo $entry_password1; ?></td>
            <td><input type="text" name="robokassa_p1_store[<?php echo $STORE['store_id']; ?>]" 
			/> <?php if( $robokassa_password1_store[ $STORE['store_id'] ] ) echo $text_saved; ?>
			<div>
				<?php echo $text_password_notice; ?>
			</div>
			
			</td>
          </tr>
		  <tr>
            <td><?php echo $entry_password2; ?></td>
            <td><input type="text" name="robokassa_p2_store[<?php echo $STORE['store_id']; ?>]" 
			/> <?php if($robokassa_password2_store[ $STORE['store_id'] ] ) echo $text_saved; ?></td>
          </tr>
		  
		  <?php /* end update: a1 */ ?>
		  <tr>
            <td><?php echo $entry_result_url; ?>:</td>
            <td><?php echo $STORE['url']; ?>index.php?route=payment/robokassa/result</td>
          </tr>
          
		  <tr>
            <td><?php echo $entry_result_method; ?></td>
            <td>POST</td>
          </tr>
          
		  <tr>
            <td><?php echo $entry_success_url; ?></td>
            <td><?php echo $STORE['url']; ?>index.php?route=checkout/success</td>
          </tr>
          
		  <tr>
            <td><?php echo $entry_success_method; ?></td>
            <td>POST</td>
          </tr>
          
		  <tr>
            <td><?php echo $entry_fail_url; ?></td>
            <td><?php echo $STORE['url']; ?>index.php?route=payment/robokassa/fail</td>
          </tr>
          
		  <tr>
            <td><?php echo $entry_fail_method; ?></td>
            <td>POST</td>
          </tr>
          
		  
		  
		  <tr>
            <td><?php echo $entry_test_mode; ?></td>
            <td><select name="robokassa_test_mode_store[<?php echo $STORE['store_id']; ?>]">
                <?php if ($robokassa_test_mode_store[ $STORE['store_id'] ]) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
			  <?php /* start update: a1 */ ?> 
			  <div><?php echo $text_mode_notice; ?></div>
			  <?php /* end update: a1 */ ?>
			  </td>
          </tr>
		  
		  
		  
          <tr>
            <td><?php echo $entry_icons; ?></td>
            <td><select name="robokassa_icons_store[<?php echo $STORE['store_id']; ?>]">
                <?php if ($robokassa_icons_store[ $STORE['store_id'] ]) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>
		  
		  
          <tr>
            <td><?php echo $entry_paynotify; ?></td>
            <td><select name="robokassa_paynotify_store[<?php echo $STORE['store_id']; ?>]">
                <?php if ($robokassa_paynotify_store[$STORE['store_id']]) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>
		  
          <tr>
            <td><?php echo $entry_paynotify_email; ?></td>
            <td><input type="text" name="robokassa_paynotify_email_store[<?php echo $STORE['store_id']; ?>]" 
			value="<?php echo $robokassa_paynotify_email_store[$STORE['store_id']]; ?>" /></td>
          </tr>
		  
          <tr>
            <td><?php echo $entry_sms_status; ?></td>
            <td><select name="robokassa_sms_status_store[<?php echo $STORE['store_id']; ?>]">
                <?php if ($robokassa_sms_status_store[$STORE['store_id']]) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
			  <p><?php echo $entry_sms_instruction; ?></p>
			  
			  </td>
          </tr>
		  
          <tr>
            <td><?php echo $entry_sms_phone; ?></td>
            <td><input type="text" name="robokassa_sms_phone_store[<?php echo $STORE['store_id']; ?>]" 
			value="<?php echo $robokassa_sms_phone_store[$STORE['store_id']]; ?>" /></td>
          </tr>
		  
		  
          <tr>
            <td><?php echo $entry_sms_message; ?></td>
            <td><textarea cols=50 rows=7 name="robokassa_sms_message_store[<?php echo $STORE['store_id']; ?>]"
			><?php echo $robokassa_sms_message_store[$STORE['store_id']]; ?></textarea></td>
          </tr>
		  
		  
		  
          <tr>
            <td><?php echo $entry_dopcost; ?></td>
            <td><input type="text" size=20 name="robokassa_dopcost_store[<?php echo $STORE['store_id']; ?>]" 
			value="<?php echo $robokassa_dopcost_store[$STORE['store_id']]; ?>"
			>&nbsp;<select name="robokassa_dopcosttype_store[<?php echo $STORE['store_id']; ?>]">
					<option value="int" <?php if($robokassa_dopcosttype_store[$STORE['store_id']] == 'int') 
					{ ?> selected <?php } ?>
					><?php echo $text_dopcost_int; ?></option>
					
					<option value="percent" <?php if($robokassa_dopcosttype_store[$STORE['store_id']] == 'percent') 
					{ ?> selected <?php } ?>
					><?php echo $text_dopcost_percent; ?></option>
				</select></td>
          </tr>
		  
		  
		  <tr>
            <td><?php echo $entry_dopcostname; ?></td>
            <td>
			<?php foreach ($languages as $language) { ?>
              <textarea cols=50 rows=7 
			  name="robokassa_dopcostname_store[<?php echo $STORE['store_id']; 
			  ?>][<?php echo $language['code']; ?>]"
			  ><?php echo isset($robokassa_dopcostname_store[ $STORE['store_id'] ][$language['code']]) ? $robokassa_dopcostname_store[$STORE['store_id']][$language['code']] : '';
			  ?></textarea><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
			  <?php } ?>
			</td> 
          </tr>
		  
          <tr>
            <td><?php echo $entry_script; ?></td>
            <td>
				<p><input type="radio" name="robokassa_confirm_status_store[<?php echo $STORE['store_id']; ?>]" 
				value="before" id="robokassa_confirm_status_before_<?php echo $STORE['store_id']; ?>"
				<?php if( $robokassa_confirm_status_store[ $STORE['store_id'] ] == 'before' ) { ?> checked <?php } ?>
				onclick="show_hide_block('before', 0)"
				><label for="robokassa_confirm_status_before_<?php echo $STORE['store_id']; ?>"><?php echo $entry_script_before; ?></label></p>
				
				<p><input type="radio" name="robokassa_confirm_status_store[<?php echo $STORE['store_id']; ?>]" 
				value="after" id="robokassa_confirm_status_after_<?php echo $STORE['store_id']; ?>"
				<?php if( $robokassa_confirm_status_store[ $STORE['store_id'] ] == 'after' ) { ?> checked <?php } ?>
				onclick="show_hide_block('after', 0)"
				><label for="robokassa_confirm_status_after_<?php echo $STORE['store_id']; ?>"
				><?php echo $entry_script_after; ?></label></p>			
			
				<p><input type="radio" name="robokassa_confirm_status_store[<?php echo $STORE['store_id']; ?>]"
				value="after" id="robokassa_confirm_status_premod_<?php echo $STORE['store_id']; ?>"
				<?php if( $robokassa_confirm_status_store[ $STORE['store_id'] ] == 'premod' ) { ?> checked <?php } ?>
				onclick="show_hide_block('premod', 0)"
				><label for="robokassa_confirm_status_premod_<?php echo $STORE['store_id']; ?>"
				><?php echo $entry_script_premod; ?></label></p>
			
			</td>
          </tr>
		  </table>
		  
		  <table id="block_before<?php echo $STORE['store_id']; ?>" class="form" width=100%>
		  <tr>
            <td width=200><?php echo $entry_confirm_notify; ?></td>
            <td><select name="robokassa_confirm_notify_store[<?php echo $STORE['store_id']; ?>]">
                <?php if ($robokassa_confirm_notify_store[ $STORE['store_id'] ]) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>
		  <tr>
            <td><?php echo $entry_confirm_comment; ?></td>
            <td>
			<?php foreach ($languages as $language) { ?>
              <textarea cols=50 rows=7 
			  name="robokassa_confirm_comment_store[<?php echo $STORE['store_id']; ?>][<?php echo $language['code']; ?>]"
			  ><?php echo isset($robokassa_confirm_comment_store[ $STORE['store_id'] ][$language['code']]) ? $robokassa_confirm_comment_store[ $STORE['store_id'] ][$language['code']] : '';
			  ?></textarea><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
			  <?php } ?>
			</td>
          </tr>
		  <tr>
            <td><?php echo $entry_order_comment; ?><br><br><?php echo $entry_order_comment_notice; ?></td>
            <td>
			<?php foreach ($languages as $language) { ?>
              <textarea cols=50 rows=7 
			  name="robokassa_order_comment_store[<?php echo $STORE['store_id']; ?>][<?php echo $language['code']; ?>]"
			  ><?php echo isset($robokassa_order_comment_store[ $STORE['store_id'] ][$language['code']]) ? $robokassa_order_comment_store[ $STORE['store_id'] ][$language['code']] : '';
			  ?></textarea><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
			  <?php } ?>
			</td>
          </tr>
		  <tr>
            <td width=200><?php echo $entry_preorder_status; ?></td>
            <td><select name="robokassa_preorder_status_id_store[<?php echo $STORE['store_id']; ?>]">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $robokassa_preorder_status_id_store[ $STORE['store_id'] ]) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
		  </table>
		  
		  <div id="block_after<?php echo $STORE['store_id']; ?>" ></div>	
		  
		  <div id="block_premod<?php echo $STORE['store_id']; ?>" >
		  <table class="form" width=100%>
		  <tr>
            <td><?php echo $entry_order_comment; ?></td>
            <td>
			<?php foreach ($languages as $language) { ?>
              <textarea cols=50 rows=7 
			  name="robokassa_premod_order_comment_store[<?php echo $STORE['store_id']; ?>][<?php echo $language['code']; ?>]"
			  ><?php echo isset($robokassa_premod_order_comment_store[ $STORE['store_id'] ][$language['code']]) ? $robokassa_premod_order_comment_store[ $STORE['store_id'] ][$language['code']] : '';
			  ?></textarea><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
			  <?php } ?>
			</td>
          </tr>
		  <tr>
            <td><?php echo $entry_hide_order_comment; ?>
			<br><br><?php echo $entry_order_comment_notice; ?>
			
			</td>
            <td>
			<?php foreach ($languages as $language) { ?>
              <textarea cols=50 rows=7 
			  name="robokassa_premod_hide_order_comment_store[<?php echo $STORE['store_id']; ?>][<?php echo $language['code']; ?>]"
			  ><?php echo isset($robokassa_premod_hide_order_comment_store[ $STORE['store_id'] ][$language['code']]) ? $robokassa_premod_hide_order_comment_store[ $STORE['store_id'] ][$language['code']] : '';
			  ?></textarea><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
			  <?php } ?>
			</td>
          </tr>
		  <tr>
            <td width=200><?php echo $entry_premod_success_page_type; ?></td>
            <td><select name="robokassa_premod_success_page_type_store[<?php echo $STORE['store_id']; ?>]" 
				id="robokassa_premod_success_page_type<?php echo $STORE['store_id']; ?>"
				onchange="show_success_page_block<?php echo $STORE['store_id']; ?>()"
				>
                <?php if ($robokassa_success_page_type[ $STORE['store_id'] ] == 'common') { ?>
                <option value="common" selected="selected"><?php echo $text_premod_success_page_type_common; ?></option>
                <option value="custom"><?php echo $text_premod_success_page_type_custom; ?></option>
                <?php } else { ?>
                <option value="common"><?php echo $text_premod_success_page_type_common; ?></option>
                <option value="custom" selected="selected"><?php echo $text_premod_success_page_type_custom; ?></option>
                <?php } ?>
              </select>
			  <div id="success_page_notice<?php echo $STORE['store_id']; ?>"
			  style="display: none;"><?php echo $entry_premod_success_page_notice; ?></div>
			</td>
          </tr>
		  </table>
		  
		  <div id="block_success_page<?php echo $STORE['store_id']; ?>" style="display: none;">
		  <table class="form" width=100%>
		  <tr>
            <td width=200><?php echo $entry_premod_success_page_header; ?></td>
            <td>
			<?php foreach ($languages as $language) { ?>
              <input type="text" style="width: 300px";
			  name="robokassa_premod_success_page_header_store[<?php echo $STORE['store_id']; ?>][<?php echo $language['code']; ?>]"
			  value="<?php echo isset($robokassa_premod_success_page_header_store[ $STORE['store_id'] ][$language['code']]) ? $robokassa_premod_success_page_header_store[ $STORE['store_id'] ][$language['code']] : '';
			  ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
			  <?php } ?>
			</td>
		   </tr>
		  <tr>
            <td width=200><?php echo $entry_premod_success_page_text; ?></td>
            <td>
			<?php foreach ($languages as $language) { ?>
              <textarea cols=50 rows=7 
			  name="robokassa_premod_success_page_text_store[<?php echo $STORE['store_id']; ?>][<?php echo $language['code']; ?>]"
			  ><?php echo isset($robokassa_premod_success_page_text_store[ $STORE['store_id'] ][$language['code']]) ? $robokassa_premod_success_page_text_store[ $STORE['store_id'] ][$language['code']] : '';
			  ?></textarea><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
			  <?php } ?>
			</td>
		   </tr>
		   </table>
		  </div>
		</div>
		  
			<script>
				function show_success_page_block<?php echo $STORE['store_id']; ?>()
				{	
					var e = document.getElementById("robokassa_premod_success_page_type<?php echo $STORE['store_id']; ?>");
					
					if( e.selectedIndex == 'common' )
					{
						document.getElementById("block_success_page<?php echo $STORE['store_id']; ?>").style.display = 'none';
						document.getElementById("success_page_notice<?php echo $STORE['store_id']; ?>").style.display = 'none';
					}
					else
					{
						document.getElementById("block_success_page<?php echo $STORE['store_id']; ?>").style.display = 'block';
						document.getElementById("success_page_notice<?php echo $STORE['store_id']; ?>").style.display = 'block';
					}
				}
				
				show_success_page_block<?php echo $STORE['store_id']; ?>();
			</script>
		  
		  
		<table class="form">		  
		  <tr>
            <td><?php echo $entry_order_status; ?></td>
            <td><select name="robokassa_order_status_id_store[<?php echo $STORE['store_id']; ?>]">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $robokassa_order_status_id_store[ $STORE['store_id'] ]) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
		  <tr>
            <td><?php echo $entry_geo_zone; ?></td>
            <td><select name="robokassa_geo_zone_id_store[<?php echo $STORE['store_id']; ?>]">
                <option value="0"><?php echo $text_all_zones; ?></option>
                <?php foreach ($geo_zones as $geo_zone) { ?>
                <?php if ($geo_zone['geo_zone_id'] == $robokassa_geo_zone_id_store[ $STORE['store_id'] ]) { ?>
                <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
		  <tr>
            <td><?php echo $entry_commission; ?></td>
            <td>
				<p><input type="radio" name="robokassa_commission_store[<?php echo $STORE['store_id']; ?>]" value="j" id="robokassa_commission_j<?php echo $STORE['store_id']; ?>"
				<?php if( $robokassa_commission_store[ $STORE['store_id'] ] == 'j' ) { ?> checked <?php } ?>
				>
				<label for="robokassa_commission_j<?php echo $STORE['store_id']; ?>"><?php echo $text_commission_j; ?></label></p>
				
				<p><input type="radio" name="robokassa_commission_store[<?php echo $STORE['store_id']; ?>]" value="customer" 
				id="robokassa_commission_customer<?php echo $STORE['store_id']; ?>"
				<?php if( $robokassa_commission_store[ $STORE['store_id'] ] == 'customer' ) { ?> checked <?php } ?>
				>
				<label for="robokassa_commission_customer<?php echo $STORE['store_id']; ?>"><?php echo $text_commission_customer; ?></label></p>
				
				<p><input type="radio" name="robokassa_commission_store[<?php echo $STORE['store_id']; ?>]" value="shop" 
				id="robokassa_commission_shop<?php echo $STORE['store_id']; ?>"
				<?php if( $robokassa_commission_store[ $STORE['store_id'] ] == 'shop' ) { ?> checked <?php } ?>
				>
				<label for="robokassa_commission_shop<?php echo $STORE['store_id']; ?>"><?php echo $text_commission_shop; ?></label></p>
			
			</td>
          </tr>
		  
		  <!-- /* kin insert metka: d1 */ -->
		  <tr>
            <td><?php echo $entry_robokassa_desc; ?></td>
            <td>
			<?php foreach ($languages as $language) { ?>
              <textarea cols=50 rows=7 
			  name="robokassa_desc_store[<?php echo $STORE['store_id']; ?>][<?php echo $language['code']; ?>]"
			  ><?php echo isset($robokassa_desc_store[ $STORE['store_id'] ][$language['code']]) ? $robokassa_desc_store[ $STORE['store_id'] ][$language['code']] : '';
			  ?></textarea><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
			  <?php } ?>
			</td>
          </tr>
		  <!-- /* end kin metka: d1 */ -->
		  
          <tr>
            <td><?php echo $entry_sort_order; ?></td>
            <td><input type="text" name="robokassa_sort_order_store[<?php echo $STORE['store_id']; ?>]" 
			value="<?php echo $robokassa_sort_order_store[ $STORE['store_id'] ]; ?>" size="1" /></td>
          </tr>
		  
		  
		  <?php /* kin insert metka: a4 */ ?>
          <tr>
            <td><?php echo $entry_currency; ?></td>
            <td><select name="robokassa_currency_store[<?php echo $STORE['store_id']; ?>]">
					<?php foreach( $opencart_currencies as $currency=>$val ) { ?>
					<option value="<?php echo $currency; ?>" <?php if( (!empty($robokassa_currency_store[ $STORE['store_id'] ]) && $currency==$robokassa_currency_store[ $STORE['store_id'] ]) || (!$robokassa_currency_store[ $STORE['store_id'] ] && $currency=='RUB' ) ) { ?> selected <?php } ?> ><?php echo $currency; ?></option>
					<?php } ?>
				</select>
				<p><i><?php echo $text_currency_notice; ?></i></p>
			</td>
          </tr>
		  <?php /* end kin metka: a4 */ ?>
		  	  
          <tr>
            <td><?php echo $entry_interface_language; ?></td>
            <td><select name="robokassa_interface_language_store[<?php echo $STORE['store_id']; ?>]" 
			id="robokassa_interface_language<?php echo $STORE['store_id']; ?>" 
			onchange="show_hide_lang_block(this.value, <?php echo $STORE['store_id']; ?>)">
                <option value="ru" 
				<?php if( $robokassa_interface_language_store[ $STORE['store_id'] ] == 'ru' ) { ?>
				selected="selected"
				<?php } ?>
				><?php echo $entry_interface_language_ru; ?></option>
                <option value="en"
				<?php if( $robokassa_interface_language_store[ $STORE['store_id'] ] == 'en' ) { ?>
				selected="selected"
				<?php } ?>><?php echo $entry_interface_language_en; ?></option>
                <option value="detect"
				<?php if( $robokassa_interface_language_store[ $STORE['store_id'] ] == 'detect' ) { ?>
				selected="selected"
				<?php } ?>><?php echo $entry_interface_language_detect; ?></option>
              </select></td>
          </tr>
		  
		  
		  
		  
		  </table>
		  
		  
		  <table class="form" id="lang_block<?php echo $STORE['store_id']; ?>"  width=100%>
          <tr>
            <td width="200"><?php echo $entry_default_language; ?></td>
            <td><select name="robokassa_default_language_store[<?php echo $STORE['store_id']; ?>]">
			
			<option value="ru" 
				<?php if( $robokassa_default_language_store[ $STORE['store_id'] ] == 'ru' ) { ?>
				selected="selected"
				<?php } ?>
				><?php echo $entry_interface_language_ru; ?></option>
                <option value="en"
				<?php if( $robokassa_default_language_store[ $STORE['store_id'] ] == 'en' ) { ?>
				selected="selected"
				<?php } ?>><?php echo $entry_interface_language_en; ?></option>
              </select></td>
          </tr>
		  </table>
		  
		  
		  
		  <table class="form" width=100%>	
          <tr>
            <td width="200"><?php echo $entry_log; ?></td>
            <td><select name="robokassa_log_store[<?php echo $STORE['store_id']; ?>]">
                <?php if ($robokassa_log_store[ $STORE['store_id'] ]) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  <tr>
            <td colspan=2><b><?php echo $entry_methods; ?></b></td>           
          </tr>
		  <?php if( empty( $robokassa_shop_login_store[$STORE['store_id']] ) ) { ?>
		  <tr>
            <td colspan=2><b><font color=red><?php echo $entry_no_methods; ?></font></b></td>           
          </tr>
		  <?php } elseif( empty( $currencies_store[$STORE['store_id']] ) ) { ?>
		  <tr>
            <td colspan=2><?php echo $entry_no_robokass_methods; ?></td>
          </tr>
		  <?php } else { ?>
		   <tr>
            <td colspan=2>
				<div><?php echo $text_img_notice; ?></div><br>
			
				<style>
					.methods td, .methods th
					{
						border: 1px dotted #ccc;
					}
					
					.methods					
					{
						border: 1px dotted #ccc;
					}
				</style>
				<table cellpadding=5 cellspacing=0 class="methods">
					<tr>
						<th valign=top>#</th>
						<th valign=top><?php echo $methods_col1; ?></th>
						<th valign=top><?php echo $methods_col2; ?></th>
						<th valign=top><?php echo $methods_col3; ?></th>
						<th valign=top><?php echo $methods_col4; ?></th>
						<th valign=top><?php echo $methods_col5; ?></th>
					</tr>
					<?php for($i=0; $i<20; $i++) { ?>
					<tr>
						<td>#<?php echo ($i+1); ?>
						<input type="hidden" name="robokassa<?php echo $i; ?>_sort_order_store[<?php echo $STORE['store_id']; 
						?>]"
						 
						value="<?php 
						if($i!=0) echo $i/10; 
						else echo "0.01"; 
						?>">
						</td>
						<td>
						
						<?php foreach ($languages as $language) { ?>
						<input type="text" size=60 
						name="robokassa_methods_store[<?php echo $STORE['store_id']; ?>][<?php echo $i; ?>][<?php echo $language['code']; ?>]"
						
						id="text_robokassa_<?php echo $language['code']; ?>_<?php echo $STORE['store_id']; ?>_<?php echo $i; ?>" 
						
						value="<?php 
						if( !empty($robokassa_methods_store[$STORE['store_id']][$i][$language['code']]) )
						echo $robokassa_methods_store[$STORE['store_id']][$i][$language['code']]; ?>"
						>&nbsp;<img src="view/image/flags/<?php echo $language['image']; ?>" 
						title="<?php echo $language['name']; ?>" /><br /><br>
						<?php } ?>
						
						</td>
						<td><select name="robokassa_currencies_store[<?php echo $STORE['store_id']; ?>][<?php echo $i; ?>]"
						onchange="show_img(<?php echo $i; ?>, this.value, <?php echo $STORE['store_id']; ?>)"
						>
							<option value="0"><?php echo $select_currency; ?></option>
						<?php foreach($currencies as $key=>$val) { ?>
							<option value="<?php echo $key; ?>" <?php 
							if( $robokassa_currencies_store[$STORE['store_id']][$i]==$key ) { ?>selected<?php }?>
							><?php echo $val; ?></option>
						<?php } ?>
						
						<?php /* start update: a3 */ ?>
							<option value="robokassa" <?php 
							if( $robokassa_currencies_store[$STORE['store_id']][$i]=='robokassa' ) { ?> selected <?php } ?>
							><?php echo $text_robokassa_method; ?></option>
						<?php /* end update: a3 */ ?>
						
						</select></td>
						
						<td>
						
						
						<input type="text" size=20 name="robokassa_minprice_store[<?php echo $STORE['store_id']; ?>][<?php echo $i; ?>]"
						value="<?php 
						if( !empty($robokassa_minprice_store[$STORE['store_id']][$i]) )
						echo $robokassa_minprice_store[$STORE['store_id']][$i]; ?>"
												
						>
						</td>
						
						<td>
						
						
						<input type="text" size=20 name="robokassa_maxprice_store[<?php echo $STORE['store_id']; ?>][<?php echo $i; ?>]"
						value="<?php 
						if( !empty($robokassa_maxprice_store[$STORE['store_id']][$i]) )
						echo $robokassa_maxprice_store[$STORE['store_id']][$i]; ?>"
												
						>
						</td>
						
						<td>
							<div id="img<?php echo $STORE['store_id']; ?>_<?php echo $i; ?>" style="display: <?php 
								if( !empty($robokassa_currencies_store[$STORE['store_id']][$i]) ) echo 'block'; else echo 'none';?>;">
								
								<img src="<?php echo $robokassa_images_store[$STORE['store_id']][$i]['thumb']; ?>" 
								id="thumb<?php echo $STORE['store_id']; ?>_<?php echo $i; ?>">
								<input type="hidden" 
								name="robokassa_images_store[<?php echo $STORE['store_id']; ?>][]" 
								id="image<?php echo $STORE['store_id']; ?>_<?php echo $i; ?>"
								value="<?php echo $robokassa_images_store[$STORE['store_id']][$i]['value']; ?>">
								<br>
								<a onclick="image_upload('image<?php echo $STORE['store_id']; ?>_<?php echo $i; ?>', 'thumb<?php echo $STORE['store_id']; ?>_<?php echo $i; ?>');"
								><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a 
								onclick="$('#thumb<?php echo $STORE['store_id']; ?>_<?php echo $i; ?>').attr('src', '<?php echo $no_image; ?>'); $('#image<?php echo $STORE['store_id']; ?>_<?php echo $i; ?>').attr('value', '');"
								><?php echo $text_clear; ?></a>
								
							</div>
						</td>
					</tr>
					<?php } ?>
				</table>
			</td>           
          </tr>
		  <?php } ?>
        </table>
		</div>
		<?php } ?>
		<!-- /////////////////////////////////////////////////// -->

      </form>
		<?php /* kin insert metka: u1 */ ?>
		<?php if( !empty( $robokassa_shop_login ) ) { ?>
		<div id="tab-generation" style="display: none;">
			<table class="form">
			<tr>
				<td><?php echo $entry_generate_order_id; ?></td>
				<td><input type="text" id="generate_order_id" value="">
					<div id="error_generate_order_id" style="display: none;"
					><font color=red><b><?php echo $error_generate_order_id; ?></b></font></div>
					
					<div id="error_order_id" style="display: none;"
					><font color=red><b><?php echo $error_order_id; ?></b></font></div>
				</td>
			</tr>
			<tr>
				<td><?php echo $entry_generate_sum; ?></td>
				<td><input type="text" id="generate_sum" value="">
					<div id="error_generate_sum" style="display: none;"
					><font color=red><b><?php echo $error_generate_sum; ?></b></font></div></td>
			</tr>
			<?php if( !empty($stores) ) { ?>
			<tr>
				<td><?php echo $entry_generate_store; ?></td>
				<td>
					<select id="generate_store">
						<option value="0"
							><?php echo $text_default_store; ?></option>
						<?php foreach($stores as $store) { ?>
							<option value="<?php echo $store['store_id']; ?>"
							><?php echo $store['name']; ?></option>
						<?php } ?>
					</select>
				</td>
			</tr>
			<?php } else { ?>
				<input type="hidden" id="generate_store" value="">
			<?php } ?>
			<tr>
				<td><?php echo $entry_generate_email; ?></td>
				<td>
					<input type="text" id="generate_email" value="">
					<div id="error_generate_email" style="display: none;"
					><font color=red><b><?php echo $error_generate_email; ?></b></font></div>
				</td>
			</tr>
			<tr>
				<td><?php echo $entry_generate_currency; ?></td>
				<td>
					<select id="generate_currency" >
						<option value="0"><?php echo $select_currency; ?></option>
						<?php foreach($currencies as $key=>$val) { ?>
							<option value="<?php echo $key; ?>"><?php echo $val; ?></option>
						<?php } ?>
					</select>
				</td>
			</tr>
			<tr>
				<td><?php echo $entry_generate_culture; ?></td>
				<td>
					<select id="generate_culture" >
						<option value="ru"><?php echo $entry_generate_culture_ru; ?></option>
						<option value="en"><?php echo $entry_generate_culture_en; ?></option>
					</select>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<a onclick="getLink()" class="button">
					<span><?php echo $button_generate; ?></span></a>
				</td>
			</tr>
			</table>
			<div id="generated_link"></div>
		</div>
		<?php } ?>
		<?php /* end kin metka */ ?>
		

	<?php /* kin insert metka: u1 */ ?>
	<script>
		function getLink()
		{
			var stop = 0;
			if( !document.getElementById('generate_order_id').value )
			{
				document.getElementById('error_generate_order_id').style.display='block';
				stop = 1;
			}
			else
			{
				document.getElementById('error_generate_order_id').style.display='none';
			}
			
			if( !document.getElementById('generate_sum').value )
			{
				document.getElementById('error_generate_sum').style.display='block';
				stop = 1;
			}
			else
			{
				document.getElementById('error_generate_sum').style.display='none';
			}
			
			if( !document.getElementById('generate_email').value )
			{
				document.getElementById('error_generate_email').style.display='block';
				stop = 1;
			}
			else
			{
				document.getElementById('error_generate_email').style.display='none';
			}
			
			if( stop == 1 )
			{
				return;
			}
			
			$.ajax({
					url: 'index.php?route=payment/robokassa/getlink&token=<?php echo $token; ?>',
					dataType: 'html',	
					data: { 
						OutSum: document.getElementById('generate_sum').value,  
						StoreId: document.getElementById('generate_store').value,  
						InvId: document.getElementById('generate_order_id').value, 
						Email: document.getElementById('generate_email').value, 
						IncCurrLabel: document.getElementById('generate_currency').value, 
						Culture: document.getElementById('generate_culture').value				
					},
					success: function(html) {
						if( html == 'ERRORorder' )
						{
							document.getElementById('error_order_id').style.display='block';
							document.getElementById('generated_link').innerHTML = '';
						}
						else
						{
							document.getElementById('error_order_id').style.display='none';
							document.getElementById('generated_link').innerHTML = html;
						}
					},
					error: function(xhr, ajaxOptions, thrownError) {
						//alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
			});	
		}
	</script>
	<?php /* end kin metka */ ?>
	<script>
	
	var all_images = new Array();
	var all_images2 = new Array();
	var all_names = new Array();
	<?php foreach($all_images as $key=>$val) { ?>
	all_images["<?php echo $key; ?>"] = "<?php echo $val['value']; ?>";
	all_images2["<?php echo $key; ?>"] = "<?php echo $val['thumb']; ?>";
	<?php } ?>
	
	<?php if( !empty($currencies) ) { ?>
	<?php foreach($currencies as $key=>$val) { ?>
	all_names["<?php echo $key; ?>"] = "<?php echo $val; ?>";
	<?php } ?>
	all_names["robokassa"] = "<?php echo $text_robokassa_method; ?>";
	<?php } ?>
	
	function show_img(ID, value, STORE_ID)
	{
		$('#thumb'+STORE_ID+'_' + ID).replaceWith('<img src="' + all_images2[value] + '" alt="" id="thumb'+STORE_ID+'_' + ID + '" />');
		
		$('#image'+STORE_ID+'_' + ID).attr('value', all_images[value]);
		
		if( value!=0 )
		{
			document.getElementById('img'+STORE_ID+'_'+ID).style.display = 'block';
			
			<?php foreach ($languages as $language) { ?>
			$('#text_robokassa_<?php echo $language['code']; ?>_'+STORE_ID+'_'+ID).attr('value', all_names[value]);
			<?php } ?>
		}
		else
		document.getElementById('img'+STORE_ID+'_'+ID).style.display = 'none';
	}
	
	function show_hide_lang_block( value, STORE_ID )
	{
		if( value=='detect' )
		{
			document.getElementById('lang_block'+STORE_ID).style.display = 'block';
		}
		else
		{
			document.getElementById('lang_block'+STORE_ID).style.display = 'none';
		}
	}
	
	show_hide_lang_block( document.getElementById('robokassa_interface_language').value, '0' );
	
	
	<?php foreach($stores as $store) { ?>
	show_hide_lang_block( document.getElementById('robokassa_interface_language').value, '<?php echo $store['store_id'];?>' );
	<?php } ?>
	
	
	function show_hide_block( value, STORE_ID )
	{
		if( value=='before' )
		{
			document.getElementById('block_before'+STORE_ID).style.display = 'block';
			document.getElementById('block_after'+STORE_ID).style.display = 'none';
			document.getElementById('block_premod'+STORE_ID).style.display = 'none';
		}
		else if( value=='after' )
		{
			document.getElementById('block_before'+STORE_ID).style.display = 'none';
			document.getElementById('block_after'+STORE_ID).style.display = 'block';
			document.getElementById('block_premod'+STORE_ID).style.display = 'none';
		}
		else
		{
			document.getElementById('block_before'+STORE_ID).style.display = 'none';
			document.getElementById('block_after'+STORE_ID).style.display = 'none';
			document.getElementById('block_premod'+STORE_ID).style.display = 'block';
		}
	}
	
	//alert(document.getElementById('robokassa_confirm_status').value);
	
	show_hide_block( '<?php echo $robokassa_confirm_status; ?>', 0 );
	<?php foreach($stores as $store) { ?>
	show_hide_block( '<?php echo $robokassa_confirm_status_store[ $store['store_id'] ]; ?>', '<?php echo $store['store_id'];?>' );
	<?php } ?>
$('#tabs a').tabs(); 
<?php if($current_store_id) { ?>
$('#tab-<?php echo $current_store_id; ?>').click();
<?php } ?>
	</script>
    </div>
  </div>
  <script type="text/javascript"><!--
function image_upload(field, thumb) {
	$('#dialog').remove();
	
	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '&directory=robokassa_icons" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
	
	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=payment/robokassa/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
					dataType: 'text',
					success: function(text) {
						$('#' + thumb).replaceWith('<img src="' + text + '" alt="" id="' + thumb + '" />');
					}
				});
			}
		},	
		bgiframe: false,
		width: 800,
		height: 400,
		resizable: false,
		modal: false
	});
};
//--></script> 
  
</div>
<?php echo $footer; ?> 
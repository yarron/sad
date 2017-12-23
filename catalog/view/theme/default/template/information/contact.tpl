<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>
  <div>
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
    <h2><?php echo $text_location; ?></h2>
    <div class="contact-info">
      <div class="content"><div class="left"><b><?php echo $text_address; ?></b><br />
        
        <?php echo $address; ?><br /><br />
        <?php if ($inf_email) { ?>
        <b><?php echo $text_email; ?></b><br />
        <?php echo $inf_email; ?>
        <?php } ?>
        </div>
      <div class="right">
        <?php if ($telephone) { ?>
        <b><?php echo $text_telephone; ?></b><br />
        <?php echo $telephone; ?><br /><br />
        <?php } ?>
        
        <?php if ($fax) { ?>
        <b><?php echo $text_fax; ?></b><br />
        <?php echo $fax; ?>
        <?php } ?>
        
      </div>
      
    </div>
    <h2><?php echo $text_map; ?></h2>
    <div class="content"><?php echo $additional; ?></div><br />
    </div>
    <h2><?php echo $text_contact; ?></h2>
    <div class="content">
    <b><?php echo $entry_name; ?></b><br />
    <input type="text" name="name" value="<?php echo $name; ?>" />
    <br />
    <?php if ($error_name) { ?>
    <span class="error"><?php echo $error_name; ?></span>
    <?php } ?>
    <br />
    <b><?php echo $entry_email; ?></b><br />
    <input type="text" name="email" value="<?php echo $email; ?>" />
    <br />
    <?php if ($error_email) { ?>
    <span class="error"><?php echo $error_email; ?></span>
    <?php } ?>
    <br />
    <b><?php echo $entry_enquiry; ?></b><br />
    <textarea name="enquiry" cols="40" rows="10" style="width: 98%;"><?php echo $enquiry; ?></textarea>
    <br />
    <?php if ($error_enquiry) { ?>
    <span class="error"><?php echo $error_enquiry; ?></span>
    <?php } ?>
    <br />
    <div>
      Нажимая кнопку «Продолжить», я подтверждаю, что ознакомлен и согласен с <a target="_blank" href="/index.php?route=information/information&information_id=53">политикой конфиденциальности</a>> этого сайта
    </div>
    </div>
    <div class="buttons">
      <div class="right"><input type="submit" value="<?php echo $button_continue; ?>" class="button" /></div>
    </div>
  </form></div>
  <?php echo $content_bottom; ?></div>
<?php echo $footer; ?>
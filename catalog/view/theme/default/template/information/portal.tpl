<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
	<div class="breadcrumb">
	<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
	<?php } ?>
	</div>
	<h1><?php echo $heading_title; ?></h1>
	<?php if(isset($information_info)) { ?>
	<div class="content-news">
		<div class="news">
			<h3><?php echo $heading_title; ?></h3>
			<?php echo $description; ?>
		</div>
	</div>
	<div class="buttons">
		<div class="right">
			<a onclick="location='<?php echo $news; ?>'" class="button"><span><?php echo $button_news; ?></span></a>
			<a href="<?php echo $continue; ?>" class="button"><span><?php echo $button_continue; ?></span></a>
		</div>
	</div>
	<?php } elseif (isset($information_data)) { ?>
          <?php if ($thumb || $description) { ?>
          <div class="category-info">
            <?php if ($thumb) { ?>
            <div class="image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></div>
            <?php } ?>
            <?php if ($description) { ?>
            <?php echo $description; ?>
            <?php } ?>
          </div>
          <?php } ?>
		<?php foreach ($information_data as $news) { ?>
		<div class="panelcollapsed">
			<h2><?php echo $news['title']; ?></h2>
			<div class="panelcontent">
				<p><?php echo $news['description']; ?> .. <br /><a href="<?php echo $news['href']; ?>"> <?php echo $text_more; ?></a></p>
				<a href="<?php echo $news['href']; ?>"><img style="vertical-align: middle;" src="catalog/view/theme/default/image/message-news.png" alt="" /></a> <b><?php echo $text_posted; ?></b><?php echo $news['posted']; ?>
			</div>
		</div>
		<?php } ?>
		<div class="buttons">
			<div class="right"><a href="<?php echo $continue; ?>" class="button"><span><?php echo $button_continue; ?></span></a></div>
		</div>
        <div class="pagination"><?php echo $pagination; ?></div>
 	<?php }else{ ?>
        <?php echo $text_error; ?>
    <?php } ?>
    <?php echo $content_bottom; ?>
</div>
<?php echo $footer; ?>
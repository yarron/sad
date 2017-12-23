<?php echo $header; ?>
<?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
	<div class="breadcrumb">
	<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
	<?php } ?>
	</div>
	<h1><?php echo $heading_title; ?></h1>
	<?php if(isset($gallery_info)) { ?>
		<div class="content">
			<div class="gallery">
				<?php echo $description; ?>
                <?php if ($banners) { ?>
                    <?php foreach ($banners as $banner) { ?>
                        <?php foreach ($banner['images'] as $image) { ?>
                        <div class="gallery-item">
                        <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" class="colorbox"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
                        </div>
                        <?php } ?>
                    <?php } ?>
                <?php } ?>
			</div>
		</div>
	<?php } elseif (isset($gallery_data)) { ?>
		<?php foreach ($gallery_data as $gallery) { ?>
			<div class="node-portfolio">
                <div class="portfolio_item">
                    <div class="portfolio_item_contbox">
                        <a href="<?php echo $gallery['href']; ?>">
                            <?php foreach ($gallery['images'] as $k=>$image) { ?>
                            <img class="image<?php echo ++$k; ?>" src="<?php echo $image; ?>" alt=""/>
                            <?php } ?>
                        </a>
                    </div>
                    <a class="portfilio_title" href="<?php echo $gallery['href']; ?>"><?php echo $gallery['name']; ?></a>
                </div>
			</div>
		<?php } ?>
		
    <div class="pagination"><?php echo $pagination; ?></div>
	<?php } ?>
	<?php echo $content_bottom; ?>
</div>
<?php echo $footer; ?>
<script type="text/javascript"><!--
    $(document).ready(function() {
        $('.colorbox').colorbox({
            overlayClose: true,
            opacity: 0.5,
            rel: "colorbox"
        });
    });
//--></script>
<?php if($status):?>
<div class="box box-discount">
    <div class="box-heading"><?php echo $heading_title; ?></div>
    <div class="box-content">
        <ul>
            <?php foreach($text_description as $text):?>
            <li><?php echo $text; ?> </li>

            <?php endforeach?>
        </ul>

        <?php if($text_date_end):?>
        <div class="discount-range"><?php echo $text_date_end; ?></div>
        <?php endif?>
        <div><a href="<?php echo $button_url_discount; ?>" class="button"><span><?php echo $text_url_discount; ?></span></a>
        </div>
        <br style="clear:both;"/>

    </div>
</div>
<?php endif?>
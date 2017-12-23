<div class="box" >
  <div class="box-heading"><?php echo $heading_title; ?></div>
  <div class="box-content">
    <table id="download" >
        <thead>
            <tr bgcolor="#e3ca9a">
                <th><?php echo $text_category; ?></th>
                <th><?php echo $text_download; ?></th>
            </tr>
        </thead>
        <tbody>
        <?php foreach ($categories as $category) { ?>
        <?php if (array_key_exists($category['category_id'], $setting) && isset($setting[$category['category_id']]['category'])) { ?>
            <tr>
                <td><?php echo $category['name']; ?></td>
                <td>
                <?php foreach ($downloads as $download) { ?>
                    <?php if ($setting[$category['category_id']]['download'] == $download['download_id'] ) { ?>
                    <a href="<?php echo $href.$download['download_id']; ?>"><?php echo $button_download; ?></a> 
                    <?php } ?>
                <?php } ?>
                </td>
            </tr>
        <?php } ?>
        <?php } ?>
        </tbody>
    </table>
  </div>
</div>
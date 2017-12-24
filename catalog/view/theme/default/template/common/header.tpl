<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<head>
<meta charset="UTF-8" />
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />

<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<meta property="og:title" content="<?php echo $title; ?>" />
<meta property="og:type" content="website" />
<meta property="og:url" content="<?php echo $og_url; ?>" />
<?php if ($og_image) { ?>
<meta property="og:image" content="<?php echo $og_image; ?>" />
<?php } else { ?>
<meta property="og:image" content="<?php echo $logo; ?>" />
<?php } ?>
<meta property="og:site_name" content="<?php echo $name; ?>" />
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<link href="<?php echo $base; ?>image/favicon.ico" rel="shortcut icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/stylesheet.min.css?ver=1.0.4" />
<?php foreach ($styles as $style) { ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" />
<script type="text/javascript" src="catalog/view/javascript/common.js"></script>
<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
<!--[if IE 7]> 
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/ie7.css" />
<![endif]-->

<?php if ($stores) { ?>
<script type="text/javascript"><!--
$(document).ready(function() {
<?php foreach ($stores as $store) { ?>
$('body').prepend('<iframe src="<?php echo $store; ?>" style="display: none;"></iframe>');
<?php } ?>
});
//--></script>
<?php } ?>
<?php echo $google_analytics; ?>
</head>
<body>
<div id="body">
    <div id="top-menu">
      <ul>
        <li><a href="<?php echo $home; ?>"><?php echo $text_home; ?></a></li>
        <li><a href="<?php echo $gallery; ?>" id="wishlist-total"><?php echo $text_gallery; ?></a></li>
        <li><a href="<?php echo $buy; ?>"><?php echo $text_buy; ?></a></li>
        <li><a href="<?php echo $delivery; ?>"><?php echo $text_delivery; ?></a></li>
        <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
      </ul>
    <div class="share42init"></div>
<script type="text/javascript" src="<?php echo $base; ?>share42/share42.js"></script>
    </div>
    <div id="container">
        <div id="header">
            <div id="auth">
            <?php if (!$logged) { ?>
                <div id="auth-title"><?php echo $text_auth; ?></div>
                <div id="auth-login"><a href="<?php echo $login; ?>"><?php echo $text_login; ?></a></div>
                <div id="auth-register"><a href="<?php echo $register; ?>"><?php echo $text_register; ?></a></div>
            <?php } else { ?>
                <div id="auth-title"><?php echo $text_auth; ?></div>
                <div id="auth-login"><a href="<?php echo $profile; ?>"><?php echo $text_profile; ?></a></div>
                <div id="auth-register"><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></div>
            <?php } ?>
                
            </div>
            <?php echo $cart; ?>
            <div id="logotype">
              <?php if ($logo) { ?>
              <div id="logo">
              <?php if ($home == $og_url) { ?>
              <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
              <?php } else { ?>
              <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a>
              <?php } ?>
              </div>
              <?php } ?>
            </div>
            <div id="sub-logotype"><?php echo $text_sub_logotype; ?></div>
        </div>
        <div id="notification"></div>
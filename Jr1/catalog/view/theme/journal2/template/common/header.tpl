<?php
    if (!defined('JOURNAL_INSTALLED')) {
        echo '
            <h3>Journal Installation Error</h3>
            <p>Make sure you have uploaded all Journal files to your server and successfully replaced <b>system/engine/front.php</b> file.</p>
            <p>You can find more information <a href="http://docs.digital-atelier.com/opencart/journal/#/settings/install" target="_blank">here</a>.</p>
        ';
        exit();
    }
?>
<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="<?php echo $this->journal2->html_classes->getAll(); ?>" data-j2v="<?php echo JOURNAL_VERSION; ?>">
<head>
<meta charset="UTF-8" />
<?php if ($this->journal2->settings->get('responsive_design')): ?>
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<?php endif; ?>
<meta name="format-detection" content="telephone=no">
<!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1"/><![endif]-->
<!--[if lt IE 9]><script src="//ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js"></script><![endif]-->
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<?php foreach($this->journal2->settings->get('fb_meta', array()) as $key => $value): ?>
<meta property="<?php echo $key; ?>" content="<?php echo $value; ?>" />
<?php endforeach; ?>
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<?php foreach ($styles as $style) { ?>
<?php $this->journal2->minifier->addStyle($style['href']); ?>
<?php } ?>
<?php foreach ($this->journal2->google_fonts->getFonts() as $font): ?>
<link rel="stylesheet" href="<?php echo $font; ?>"/>
<?php endforeach; ?>
<?php foreach ($scripts as $script) { ?>
<?php $this->journal2->minifier->addScript($script, 'header'); ?>
<?php } ?>
<?php
    $this->journal2->minifier->addStyle('catalog/view/theme/journal2/css/hint.min.css');
    $this->journal2->minifier->addStyle('catalog/view/theme/journal2/css/journal.css');
    $this->journal2->minifier->addStyle('catalog/view/theme/journal2/css/features.css');
    $this->journal2->minifier->addStyle('catalog/view/theme/journal2/css/header.css');
    $this->journal2->minifier->addStyle('catalog/view/theme/journal2/css/module.css');
    $this->journal2->minifier->addStyle('catalog/view/theme/journal2/css/pages.css');
    $this->journal2->minifier->addStyle('catalog/view/theme/journal2/css/account.css');
    $this->journal2->minifier->addStyle('catalog/view/theme/journal2/css/blog-manager.css');
    $this->journal2->minifier->addStyle('catalog/view/theme/journal2/css/side-column.css');
    $this->journal2->minifier->addStyle('catalog/view/theme/journal2/css/product.css');
    $this->journal2->minifier->addStyle('catalog/view/theme/journal2/css/category.css');
    $this->journal2->minifier->addStyle('catalog/view/theme/journal2/css/footer.css');
    $this->journal2->minifier->addStyle('catalog/view/theme/journal2/css/icons.css');
    if ($this->journal2->settings->get('responsive_design')) {
        $this->journal2->minifier->addStyle('catalog/view/theme/journal2/css/responsive.css');
    }
?>
<?php echo $this->journal2->minifier->css(); ?>
<?php if ($this->journal2->cache->getDeveloperMode() || !$this->journal2->minifier->getMinifyCss()): ?>
<link rel="stylesheet" href="index.php?route=journal2/assets/css&amp;j2v=<?php echo JOURNAL_VERSION; ?>" />
<?php endif; ?>
<?php $this->journal2->minifier->addScript('catalog/view/theme/journal2/js/journal.js', 'header'); ?>
<?php echo $this->journal2->minifier->js('header'); ?>
<!--[if (gte IE 6)&(lte IE 8)]><script src="catalog/view/theme/journal2/lib/selectivizr/selectivizr.min.js"></script><![endif]-->
<?php if (isset($stores)): /* v1541 compatibility */ ?>
<?php if ($stores) { ?>
<script type="text/javascript"><!--
$(document).ready(function() {
<?php foreach ($stores as $store) { ?>
$('body').prepend('<iframe src="<?php echo $store; ?>" style="display: none;"></iframe>');
<?php } ?>
});
//--></script>
<?php } ?>
<?php endif; /* end v1541 compatibility */ ?>
<?php echo $google_analytics; ?>
<?php if ($this->journal2->settings->get('show_countdown', 'never') !== 'never' || $this->journal2->settings->get('show_countdown_product_page', 'on') == 'on'): ?>
<script>
    Journal.DIFF_DATE = Date.parse('<?php echo date('D M d Y H:i:s O'); ?>') - Date.parse(new Date);
    Journal.COUNTDOWN = {
        DAYS    : "<?php echo $this->journal2->settings->get('countdown_days', 'Days'); ?>",
        HOURS   : "<?php echo $this->journal2->settings->get('countdown_hours', 'Hours'); ?>",
        MINUTES : "<?php echo $this->journal2->settings->get('countdown_min', 'Min'); ?>",
        SECONDS : "<?php echo $this->journal2->settings->get('countdown_sec', 'Sec'); ?>"
    };
</script>
<?php endif; ?>
</head>
<body>
<?php if ($this->journal2->settings->get('config_header_modules')):  ?>
<?php echo $this->journal2->settings->get('config_header_modules'); ?>
<?php endif; ?>
<?php if ($this->journal2->config->admin_warnings): ?>
<div class="admin-warning"><?php echo $this->journal2->config->admin_warnings; ?></div>
<?php endif; ?>
<?php
    $header_type = $this->journal2->settings->get('header_type', 'default');
    if ($header_type === 'center') {
        if (!$this->journal2->settings->get('config_secondary_menu')) {
            $header_type = 'center.nosecond';
        } else {
            if (!$currency && !$language) {
                $header_type = 'center.nolang-nocurr';
            } else if (!$currency) {
                $header_type = 'center.nocurr';
            } else if (!$language) {
                $header_type = 'center.nolang';
            }
        }
    }

    if ($header_type === 'mega') {
        if (!$this->journal2->settings->get('config_secondary_menu')) {
            $header_type = 'mega.nosecond';
        } else {
            if (!$currency && !$language) {
                $header_type = 'mega.nolang-nocurr';
            } else if (!$currency) {
                $header_type = 'mega.nocurr';
            } else if (!$language) {
                $header_type = 'mega.nolang';
            }
        }
    }

    if ($header_type === 'default' || $header_type === 'extended') {
        $no_cart = $this->journal2->settings->get('catalog_header_cart', 'block') === 'none';
        $no_search = $this->journal2->settings->get('catalog_header_search', 'block') === 'none';
        if ($no_cart && $no_search) {
            $header_type = $header_type . '.nocart-nosearch';
        } else if ($no_cart) {
            $header_type = $header_type . '.nocart';
        } else if ($no_search) {
            $header_type = $header_type . '.nosearch';
        }
    }
    require DIR_TEMPLATE . "journal2/template/journal2/headers/{$header_type}.tpl";
?>
<?php if ($this->journal2->settings->get('config_top_modules')): ?>
<div id="top-modules">
   <?php echo $this->journal2->settings->get('config_top_modules'); ?>
</div>
<?php endif; ?>

<div class="extended-container">
<div id="container" class="j-container">

<?php if(isset($error)): /* v156 compatibility */ ?>
<?php if ($error) { ?>
    <div class="warning"><?php echo $error ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
<?php } ?>
<?php endif; /* end v156 compatibility */ ?>
<div id="notification"></div>
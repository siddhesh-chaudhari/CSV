<?php
/* version */
define('JOURNAL_VERSION', '2.2.5');

/* check if Journal 1.x is active */
$journal_pre_action = false;

/* check if journal should be loaded */
$load_theme = !(defined('BLOCK_JOURNAL') && BLOCK_JOURNAL === true);

/* detect if is cli call */
if (php_sapi_name() === "cli") {
    $load_theme = false;
}

/* detect if is admin access */
if ($load_theme) {
    foreach ($this->pre_action as $act) {
        if ($act->getClass() === 'Controllercommonhome' && ($act->getMethod() === 'login' || $act->getMethod() === 'permission')) {
            $load_theme = false;
            break;
        }
        if ($act->getMethod() === 'journal_cp') {
            $journal_pre_action = true;
        }
    }
}

/* detect js maps */
if ($load_theme) {
    $_route_ = isset($this->registry->get('request')->get['_route_']) ? $this->registry->get('request')->get['_route_'] : null;
    if ($_route_ !== null && in_array($_route_, array('admin/view/journal2/lib/underscore/underscore-min.map'))) {
        $load_theme = false;
    }
}

/* detect if is install access */
if ($load_theme) {
    if (in_array($action->getClass(), array('Controllerupgrade', 'Controllerstep1', 'Controllerstep2', 'Controllerstep3', 'Controllerstep4'))) {
        $load_theme = false;
    }
}

/* check if current theme is journal2 */
if ($load_theme) {
    if ($this->registry->get('config')->get('config_template') !== 'journal2') {
        $load_theme = false;
    }
}

/* start Journal 2 engine */
if ($load_theme) {
    require_once(DIR_SYSTEM . 'journal2/classes/journal2.php');
    Journal2::startTimer('Engine');
    define('JOURNAL_INSTALLED', true);

    /* check if Journal 1.x is still active */
    if ($journal_pre_action) {
        echo '<h3>Error</h3>Open <b>index.php</b> from the root directory of your setup and remove this line of code as it is not needed anymore in Journal2:';
        echo '<pre>$controller->addPreAction(new Action(\'module/journal_cp\'));</pre>';
        exit();
    }

    /* Check if Modules are enabled */
    if ($this->registry->get('db')->query('show tables like "' . DB_PREFIX . 'journal2_config"')->num_rows === 0) {
        echo '<h3>Error</h3>Journal2 module is not installed.';
        exit();
    }

    /* Get current route */
    $current_route = isset($this->registry->get('request')->get['route']) ? $this->registry->get('request')->get['route'] : null;

    /* Utils */
    require_once(DIR_SYSTEM . 'journal2/classes/journal2_utils.php');

    /* Load journal2 class */
    $journal2 = new Journal2();
    $this->registry->set('journal2', $journal2);

    /* Mobile Detect */
    require_once(DIR_SYSTEM . 'journal2/lib/Mobile_Detect.php');
    $journal2->mobile_detect = new Mobile_Detect();

    /* Load Cache class */
    require_once(DIR_SYSTEM . 'journal2/classes/journal2_cache.php');
    $journal2->cache = new Journal2Cache($this->registry);

    /* Html Classes */
    require_once(DIR_SYSTEM . 'journal2/classes/journal2_html_classes.php');
    $journal2->html_classes = new Journal2HtmlClasses($this->registry);

    /* Add mobile / tablet class */
    if ($journal2->mobile_detect->isMobile()) {
        if ($journal2->mobile_detect->isTablet()) {
            $journal2->html_classes->addClass('tablet');
        } else {
            $journal2->html_classes->addClass('mobile');
        }
    } else {
        $journal2->html_classes->addClass('journal-desktop');
    }

    /* Route Parser */
    require_once(DIR_SYSTEM . 'journal2/classes/journal2_page.php');
    $journal2->page = new Journal2Page($this->registry, $journal2->html_classes);

    /* Load journal2 config */
    require_once(DIR_SYSTEM . 'journal2/classes/journal2_config.php');
    $journal2->config = new Journal2Config($this->registry);

    /* Load journal2 settings */
    require_once(DIR_SYSTEM . 'journal2/classes/journal2_settings.php');
    $journal2->settings = new Journal2Settings($this->registry);

    /* Load journal2 minifier */
    require_once(DIR_SYSTEM . 'journal2/classes/journal2_minifier.php');
    $journal2->minifier = new Journal2Minifier($journal2->cache);

    /* Google Fonts */
    require_once(DIR_SYSTEM . 'journal2/classes/journal2_google_fonts.php');
    $journal2->google_fonts = new Journal2GoogleFonts();

    /* Controllers */
    if ($current_route !== 'module/journal2_side_blocks/load') {
        $this->execute(new Action('journal2/settings'));
        if (!$journal2->cache->getDeveloperMode()) {
            if ($journal2->minifier->getMinifyCss()) {
                $this->execute(new Action('journal2/assets/css'));
            }
            if ($journal2->minifier->getMinifyJs()) {
                $this->execute(new Action('journal2/assets/js'));
            }
        }
    }

    if (!in_array($current_route, array('module/journal2_side_blocks/load', 'journal2/assets/js', 'journal2/assets/css', 'journal2/assets/outofstock'))) {
        $this->execute(new Action('journal2/modules'));
        $this->execute(new Action('journal2/menu/header', (array('primary_menu'))));
        $this->execute(new Action('journal2/menu/header', (array('secondary_menu'))));
        $this->execute(new Action('journal2/menu/mega', (array('mega_menu'))));
        $this->execute(new Action('journal2/menu/footer', (array('footer_menu'))));

        $this->execute(new Action('journal2/snippets'));
        $this->execute(new Action('journal2/category/refine_images'));
        $this->execute(new Action('journal2/product_tabs'));
    }

    Journal2::stopTimer('Engine');
}
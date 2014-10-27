<header class="journal-header-menu nocart-nosearch">
    <div class="journal-top-header j-min"></div>
    <div class="journal-menu-bg j-min z-0"> </div>

    <div id="header" class="journal-header">

        <div class="journal-logo j-med xs-100 sm-100 md-25 lg-25 xl-25">
            <?php if ($logo) { ?>
            <div id="logo">
                <a href="<?php echo str_replace($home, 'index.php?route=common/home', ''); ?>">
                    <img src="<?php echo $logo;?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
                </a>
            </div>
            <?php } ?>
        </div>

        <div class="journal-links xs-100 xs-100 sm-100 md-75 lg-75 xl-75">
            <div class="links j-min">
                <?php echo $this->journal2->settings->get('config_primary_menu'); ?>
            </div>
        </div>


        <div class="row journal-login j-min xs-100 sm-100 md-75 lg-75 xl-75">
            <div class="journal-language">
                <?php echo $language; ?>
            </div>
            <div class="journal-currency">
                <?php echo $currency; ?>
            </div>
            <div class="journal-secondary">
                <?php echo $this->journal2->settings->get('config_secondary_menu'); ?>
            </div>
        </div>


        <div class="journal-menu j-min xs-100 sm-100 md-100 lg-100 xl-100">
            <?php echo $this->journal2->settings->get('config_mega_menu'); ?>
        </div>

    </div>
</header>
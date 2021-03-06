<header class="journal-header-menu nocart">
    <div class="journal-top-header j-min"></div>
    <div class="journal-menu-bg j-min z-0"> </div>

    <div id="header" class="journal-header">

        <div class="journal-logo j-med xs-100 sm-100 md-33 lg-25 xl-25">
            <?php if ($logo) { ?>
            <div id="logo">
                <a href="<?php echo str_replace($home, 'index.php?route=common/home', ''); ?>">
                    <img src="<?php echo $logo;?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
                </a>
            </div>
            <?php } ?>
        </div>

        <div class="journal-links xs-100 xs-100 sm-100 md-66 lg-75 xl-75">
            <div class="links j-min">
                <?php echo $this->journal2->settings->get('config_primary_menu'); ?>
            </div>
        </div>


        <div class="row journal-login j-min xs-100 sm-100 md-66 lg-50 xl-50">
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

        <div class="journal-search row j-min xs-100 sm-100 md-66 lg-25 xl-25">
            <div>
                <div id="search" class="j-min">
                    <div class="button-search j-min"><i></i></div>
                    <?php if (isset($filter_name)): /* v1541 compatibility */ ?>
                    <?php if ($filter_name) { ?>
                    <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" autocomplete="off" />
                    <?php } else { ?>
                    <input type="text" name="filter_name" value="<?php echo $text_search; ?>" autocomplete="off" onclick="this.value = '';" onkeydown="this.style.color = '#000000';" />
                    <?php } ?>
                    <?php else: ?>
                    <input type="text" name="search" placeholder="<?php echo $this->journal2->settings->get('search_placeholder_text'); ?>" value="<?php echo $search; ?>" autocomplete="off" />
                    <?php endif; /* end v1541 compatibility */ ?>
                </div>
            </div>
        </div>


        <div class="journal-menu j-min xs-1 sm-1 md-1 lg-1 xl-1">
            <?php echo $this->journal2->settings->get('config_mega_menu'); ?>
        </div>

    </div>
</header>
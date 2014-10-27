<div style="<?php echo $width; ?>; max-height:<?php echo $height;?>px " class="<?php echo $nav_on_hover; ?> journal-simple-slider box">
    <div id="journal-simple-slider-<?php echo $module; ?>">
        <?php foreach ($slides as $slide): ?>
            <?php if ($preload_images): ?>
                <?php if ($slide['link']): ?>
                    <div class="item"><a href="<?php echo $slide['link']; ?>" <?php echo $slide['target']; ?>><img class="lazyOwl" data-src="<?php echo $slide['image']; ?>" alt="<?php echo $slide['name']; ?>"/></a></div>
                <?php else: ?>
                    <div class="item">
                        <img class="lazyOwl" data-src="<?php echo $slide['image']; ?>" alt="<?php echo $slide['name']; ?>"/>
                    </div>
                <?php endif; ?>
            <?php else: ?>
                <?php if ($slide['link']): ?>
                    <div class="item"><a href="<?php echo $slide['link']; ?>" <?php echo $slide['target']; ?>><img src="<?php echo $slide['image']; ?>" alt="<?php echo $slide['name']; ?>"/></a></div>
                <?php else: ?>
                    <div class="item">
                        <img src="<?php echo $slide['image']; ?>" alt="<?php echo $slide['name']; ?>"/>
                    </div>
                <?php endif; ?>
            <?php endif; ?>
        <?php endforeach; ?>
    </div>
    <script>
        (function () {
            var opts = $.parseJSON('<?php echo json_encode($js_options); ?>');
            opts.singleItem = true;
            opts.navigationText = false;
            jQuery110('#journal-simple-slider-<?php echo $module; ?>').owlCarousel(opts);
        })();
    </script>
</div>


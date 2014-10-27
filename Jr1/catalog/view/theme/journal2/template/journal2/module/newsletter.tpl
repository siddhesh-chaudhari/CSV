<div class="box journal-newsletter text-<?php echo $text_class; ?> <?php echo $hide_on_mobile_class; ?>" id="journal-newsletter-<?php echo $module; ?>" style="<?php echo isset($css) ? $css : ''; ?>">
    <?php if ($heading_title): ?>
    <div class="box-heading"><?php echo $heading_title; ?></div>
    <?php endif; ?>
    <div class="box-content" style="<?php echo $module_css; ?>">
        <?php if ($module_text): ?>
        <span class="newsletter-text" style="<?php echo $font_css; ?>"><?php echo $module_text; ?></span>
        <?php endif; ?>
        <span class="newsletter-input-wrap" style="<?php echo $input_style; ?>">
            <input type="text" class="newsletter-email" placeholder="<?php echo $input_placeholder; ?>" style="<?php echo $input_field_style; ?>" />
            <a class="newsletter-button button" style="<?php echo $button_style; ?>"><?php echo $button_icon; ?><?php echo $button_text; ?></a>
        </span>
    </div>
    <script>
        (function () {
            function nws () {
                $('#journal-newsletter-<?php echo $module; ?> .newsletter-email').attr('disabled', true);
                $.post('<?php echo $subscribe_url; ?>', { email: $('#journal-newsletter-<?php echo $module; ?> .newsletter-email').val() }, function (response) {
                    $('#journal-newsletter-<?php echo $module; ?> .newsletter-email').removeAttr('disabled');
                    if (response.status === 'error' && response.unsubscribe) {
                        if (confirm(response.message)) {
                            $.post('<?php echo $unsubscribe_url; ?>', { email: $('#journal-newsletter-<?php echo $module; ?> .newsletter-email').val() }, function (response) {
                                alert(response.message);
                            }, 'json');
                        }
                    } else {
                        alert(response.message);
                    }
                    $('#journal-newsletter-<?php echo $module; ?> .newsletter-email').focus();
                }, 'json');
            }
            $('#journal-newsletter-<?php echo $module; ?> .newsletter-button').click(nws);
            $('#journal-newsletter-<?php echo $module; ?> .newsletter-button, #journal-newsletter-<?php echo $module; ?> .newsletter-email').keypress(function (e) {
                if (e.which == 13) {
                    nws();
                }
            });
        }());
    </script>
</div>
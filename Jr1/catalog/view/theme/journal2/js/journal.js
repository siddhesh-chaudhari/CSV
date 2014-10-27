var Journal = {};

Journal.isMobile = $('html').hasClass('mobile') || $('html').hasClass('tablet');
Journal.mobileMenuOnTablet = $('html').hasClass('mobile-menu-on-tablet');
Journal.notificationTimer = 1700;
Journal.quickviewText = 'Quickview';
Journal.BASE_HREF = null;
Journal.DISABLE_ADD_TO_CART = false;

Journal.init = function () {
    /* firefox dropdown menu width fix */
    $('.journal-menu .drop-down').each(function () {
        $('ul', this).css('min-width', $(this).width());
    });

    /* currency dropdown */
    var $c = $('.journal-currency .dropdown-menu');
    $c.css({
        'left': '50%',
        'margin-left': '-' + $c.width() / 2 + 'px'
    });
    $('.product-grid-item .image > a').prepend('<div class="p-over p-grid-over"> </div>');
    $('.product-list-item .image > a').prepend('<div class="p-over p-list-over"> </div>');

    /* */
    $('#top-modules .hide-on-mobile, #bottom-modules .hide-on-mobile').each(function () {
        $(this).parent().addClass('hide-on-mobile');
    });
};

Journal.setupMenu = function (type) {
    var $supermenu = $('.super-menu > li');
    var $mobiletrigger = $('.mobile-trigger');
    var $mobileplus = $('.mobile-menu > li .mobile-plus');
    var $megamenu_category_item = $('.mega-menu-categories .mega-menu-item li');

    try { $('.super-menu')[0].style.removeProperty('display'); } catch (e) { }

    /* unbind all events */
    $supermenu.unbind('mouseenter').unbind('mouseleave').removeProp('hoverIntent_t').removeProp('hoverIntent_s');
    $mobiletrigger.unbind('click');
    $mobileplus.unbind('click');
    $megamenu_category_item.unbind('hover');

    if (type === 'mobile') {
        jQuery._data($('.mobile-menu')[0], 'olddisplay', 'block');
        //$('.super-menu').css('display','none');
        /* setup mobile trigger */
        $mobiletrigger.toggle(function () {
            $('.mobile-menu').stop(true, true).slideDown(250);
            $(this).addClass('menu-open');
        }, function () {
            $('.mobile-menu').stop(true, true).slideUp(150);
            $(this).removeClass('menu-open');
        });

        /* setup mobile plus */
        $mobileplus.toggle(function () {
            $('> ul, > div', $(this).parent()).stop(true, true).slideDown(250);
            $(this).html('-').parent().addClass('menu-open');
        }, function () {
            $('> ul, > div', $(this).parent()).stop(true, true).slideUp(150);
            $(this).html('+').parent().removeClass('menu-open');
        });

    }

    /* set desktop events */
    if (type === 'tablet' || type === 'desktop') {
        jQuery._data($('.mobile-menu')[0], 'olddisplay', 'table');
        //$('.super-menu').css('display','table');
        $supermenu.hoverIntent(function () {
            var self = this;
            $('> ul, > div', this).hide();
            $('> ul, > div', this).stop(true, true).slideDown(250, function () {
                $('img.lazy', self).lazy({
                    bind: 'event',
                    visibleOnly: false,
                    effect: "fadeIn",
                    effectTime: 250
                });
            });
        }, function () {
            $('> ul, > div', this).stop(true, true).slideUp(150);
        });

        /* change image on hover subcategories */
        $megamenu_category_item.hover(function () {
            $(this).closest('.mega-menu-item').find('img').attr('src', $(this).attr('data-image'));
        }, function () {
            var $img = $(this).closest('.mega-menu-item').find('img');
            $img.attr('src', $img.attr('data-default-src'));
        });
    }
};

// Equal height rows solution - http://codepen.io/micahgodbolt/pen/FgqLc
Journal.equalHeight = function ($container, item, padding) {
    if (Journal.isMobile) {
        return;
    }
    var currentTallest = 0,
        currentRowStart = 0,
        rowDivs = [],
        $el,
        currentDiv,
        topPosition = 0;
    padding = padding || 0;
    $container.each(function () {
        $el = item ? $(this).find(item) : $(this);
        $el.height('auto');
        topPosition = $el.position().top;
        if (currentRowStart !== topPosition) {
            for (currentDiv = 0; currentDiv < rowDivs.length; currentDiv++) {
                rowDivs[currentDiv].height(currentTallest);
            }
            rowDivs = []; // empty the array
            currentRowStart = topPosition;
            currentTallest = $el.actual('height');
            rowDivs.push($el);
        } else {
            rowDivs.push($el);
            currentTallest = (currentTallest < $el.actual('height')) ? $el.actual('height') : currentTallest;
        }
        for (currentDiv = 0; currentDiv < rowDivs.length; currentDiv++) {
            rowDivs[currentDiv].height(currentTallest + padding);
        }
    });
};

Journal.itemsEqualHeight = function () {
    /* footer columns equal height */
    Journal.equalHeight($('footer .column'));

    /* menu items equal height */
    $('.mega-menu').addClass('dummy-hide');
    $('.mega-menu-categories').each(function () {
        Journal.equalHeight($(this).find('.mega-menu-item'));
    });
    $('.mega-menu-products').each(function () {
        Journal.equalHeight($(this).find('.mega-menu-item'), '.name');
    });
    $('.mega-menu').removeClass('dummy-hide');

    /* products */
    $('#content .product-grid, #top-modules .product-grid, #bottom-modules .product-grid').each(function () {
        Journal.equalHeight($(this).find('.product-grid-item'), '.name');
    });

    $('#content .box-product, #top-modules .box-product, #bottom-modules .box-product').each(function () {
        Journal.equalHeight($(this).find('.product-grid-item'), '.name');
    });

    /* refine category name */
    Journal.equalHeight($(".refine-images .refine-image"), '.refine-category-name');

    /* cms blocks */
    $('.box.cms-blocks').each(function () {
        var $this = $(this);
        Journal.equalHeight($this.find('.cms-block'), '.block-content');
    });

};

Journal.changeProductImage = function (thumb, image) {
    image = image || thumb;

    var $image = $('#image');

    $image.attr('src', image);
    $image.parent().attr('href', image);

    if ($image.data('imagezoom')) {
        $image.attr('data-largeimg', image);
        $image.data('imagezoom').changeImage(image, image);
    }
};

Journal.enableCloudZoom = function (type) {
    var $image = $('#image');

    $image.ImageZoom({
        showDescription: false,
        bigImageSrc: $image.attr('data-largeimg'),
        type: type,
        offset: [0, 0],
        zoomSize: [$image.width(), $image.height()]
    });

    $(window).resize(function () {
        if (Journal.cloudZoomTimeout) {
            clearTimeout(Journal.cloudZoomTimeout);
        }

        Journal.cloudZoomTimeout = setTimeout(function () {
            if ($image.data('imagezoom')) {
                $image.data('imagezoom').changeZoomSize($image.width(), $image.height());
            }
        }, 100);
    });
};

Journal.productPage = function () {
    $('.product-info .image-additional a').click(function (e) {
        e.preventDefault();
        var thumb = $(this).find('img').attr('src');
        var image = $(this).attr('href');
        Journal.changeProductImage(thumb, image);
        return false;
    });
};

Journal.productPageGallery = function () {
    if (!$('html').hasClass('quickview')) {
        $('.product-info .image-gallery .swipebox').swipebox();

        $('.zm-viewer').live('click', function () {
            var src = $(this).find('img').not('.zm-fast').attr('src');
            $('.product-info .image-gallery a.swipebox[href="' + src + '"]').first().click();
            return false;
        });

        $('#image').parent().click(function () {
            $('.product-info .image-gallery a.swipebox[href="' + $(this).attr('href') + '"]').first().click();
            return false;
        });
        $('.gallery-text').click(function () {
            $('.product-info .image-gallery a.swipebox').first().click();
            return false;
        });
    }
};


Journal.updateProductPrice = function () {
    $.ajax({
        url: 'index.php?route=journal2/ajax/price',
        type: 'post',
        data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
        dataType: 'json',
        success: function (json) {
            $('.product-info .price .price-old, .product-info .price .product-price').html(json.price);
            $('.product-info .price .price-new').html(json.special);
            $('.product-info .price .price-tax').html(json.tax);
            $('.description .journal-stock').html(json.stock);
        }
    });
};

Journal.enableProductOptions = function () {
    if (!$('html').hasClass('product-page')) {
        return;
    }

    /* change image for select options */
    $('.product-info .options .option select').change(function () {
        Journal.updateProductPrice();
    });

    /* change image for checkbox and radio options */
    $('.product-info .options .option input[type="radio"]').click(function () {
        Journal.updateProductPrice();
    });

    $('.product-info .options .option input[type="checkbox"]').click(function () {
        Journal.updateProductPrice();
    });
};

Journal.showNotification = function (message, image, parent) {
    $.pnotify.defaults.history = false;
    var $temp = $('<div>' + message + '</div>');
    var href = $temp.find('a').first().attr('href');
    var $img = image ? '<a href="' + href + '"><img src="' + image + '" alt="" /></a>' : '';
    var $title = $temp.find('a').last().prev();
    var timeout = Journal.notificationTimer;
    var $$ = parent ? parent.$ : $;
    $$.pnotify({
        title: $title.html(),
        delay: parseInt(timeout, 10),
        text: $img + message,
        type: 'success',
        history: false
    });

    $('.ui-pnotify-text a').die('click touchend').live('click touchend', function () {
        var el = $(this);
        var link = el.attr('href');
        location = link;
    });

    return true;
};

Journal.enableQuickView = function () {
    $('.quickview-button').remove();
    $('.product-wrapper .image, .product-list-item .image').each(function () {
        var $quickview = $('<div class="quickview-button"><a class="button hint--top" data-hint="' + Journal.quickviewText + '"><i class="button-left-icon"></i><span class="button-cart-text">' + Journal.quickviewText + '</span><i class="button-right-icon"></i></a></div>');
        $(this).prepend($quickview);
        var $quickbtn = $quickview.find('a');
        var $parent = $(this).closest('.product-list-item');
        if ($parent.length === 0) {
            $parent = $(this).closest('.product-wrapper');
        }
        var $cart_btn = $parent.find('.cart .button');
        var productId = $cart_btn.attr('onclick') || $cart_btn.attr('data-clk');
        if (productId) {
            productId = productId.match(/'(.*?)'/g);
            if (productId && productId[0]) {
                productId = productId[0];
                productId = productId.replace("'", "");
                productId = parseInt(productId, 10);
                $quickbtn.attr('href', 'index.php?route=journal2/quickview&pid=' + productId);
                $quickbtn.magnificPopup({
                    preloader: true,
                    tLoading: '',
                    type: 'iframe',
                    mainClass: 'quickview',
                    removalDelay: 200,
                    callbacks: {
                        open: function(item) {
                            var scrollTop = ($('html').scrollTop()) ? $('html').scrollTop() : $('body').scrollTop();
                            $('html').addClass('noscroll').css('top',-scrollTop);
                        },
                        close: function(item) {
                            var scrollTop = parseInt($('html').css('top'));
                            $('html').removeClass('noscroll');
                            $('html,body').scrollTop(-scrollTop);
                        }
                    }
                });
            }
        }
    });
};

Journal.disableAddToCartButton = function () {
    if (!Journal.DISABLE_ADD_TO_CART) return;
    $('.product-list-item .cart .button').each(function () {
        if ($(this).closest('.product-list-item').find('.outofstock').length > 0) {
            var $btn = $(this).addClass('button-disabled');
            var onclick = $btn.attr('onclick');
            $btn.removeAttr('onclick').attr('data-clk', onclick);
        }
    });

    $('.product-grid-item .cart .button').each(function () {
        if ($(this).closest('.product-grid-item').find('.outofstock').length > 0) {
            var $btn = $(this).addClass('button-disabled');
            var onclick = $btn.attr('onclick');
            $btn.removeAttr('onclick').attr('data-clk', onclick);
        }
    });

    if ($('#content .product-info .left .outofstock').length > 0) {
        $('.cart #button-cart').addClass('button-disabled').unbind('click');
    }
};

Journal.infiniteScroll = function (opts) {
    opts = opts || {};
    opts.loader = opts.loader || 'catalog/view/theme/journal2/lib/infinite-scroll/ajax-loader.gif';
    opts.loadingText = opts.loadingText || '';
    opts.finishedText = opts.finishedText || 'No more products to show!';
    $('.product-filter + div').infinitescroll({
        loadingText: opts.loadingText,
        loadingImg: opts.loader,
        donetext: opts.finishedText,
        loading: {
            selector: '#content'
        },
        debug: false,
        navSelector  : ".pagination",
        nextSelector : ".pagination a:first",
        itemSelector : ".product-filter + div > div"
    }, function (newElements, data, url) {
        display($.totalStorage('display'));
    });
};

Journal.searchAutoComplete = function () {
    $('#search input').autocomplete2({
        appendTo: '.journal-search > div',
        width: '100%',
        serviceUrl: 'index.php?route=journal2/search',
        deferRequestBy: 500,
        paramName: 'search',
        onSelect: function (suggestion) {
            location = suggestion.url;
        },
        transformResult: function (response) {
            response = $.parseJSON(response);
            var suggestions = $.map(response.results, function (dataItem) {
                return { value: dataItem.name, data: dataItem, image: dataItem.image, price: dataItem.price, special: dataItem.special, url: dataItem.url };
            });
            if (response['view_more_url']) {
                suggestions.push({
                    view_more: true,
                    value: response['view_more_text'],
                    url: response['view_more_url']
                });
            }
            return {
                suggestions: suggestions
            };
        },
        formatResult: function (suggestion, currentValue) {
            if (suggestion['view_more']) {
                return '<a class="view-more-link" href="' + suggestion['url'] + '">' + suggestion['value'] + '</a>';
            } else {
//                var reEscape = new RegExp('(\\' + ['/', '.', '*', '+', '?', '|', '(', ')', '[', ']', '{', '}', '\\'].join('|\\') + ')', 'g'),
//                    pattern = '(' + currentValue.replace(reEscape, '\\$1') + ')',
//                    name = suggestion.value.replace(new RegExp(pattern, 'gi'), '<strong>$1<\/strong>');
                var name = suggestion.value;
                var html = '<a href="' + suggestion.url + '">';
                if (suggestion.image) {
                    html += '<span class="p-image xs-33 sm-33 md-33 lg-33 xl-33"><img src="' + suggestion.image + '" /></span>';
                }
                html += '<span class="p-name xs-66 sm-66 md-66 lg-66 xl-66"><span>' + name + '</span>';
                if (suggestion.price) {
                    if (suggestion.special) {
                        html += '<span class="p-price xs-66 sm-66 md-66 lg-66 xl-66"><span class="price-old">' + suggestion.price + '</span><span class="price-new">' + suggestion.special + '</span></span>';
                    } else {
                        html += '<span class="p-price xs-66 sm-66 md-66 lg-66 xl-66">' + suggestion.price + '</span>';
                    }
                }
                html += '</span>';
                html += '<div class="clearfix"> </div>';
                html += '</a>';
                return html;
            }
        }
    });
};

Journal.onMobileOrTablet = function () {
    /* add click events on language and currency */
    $('.btn-group').unbind('click').unbind('hoverIntent').click(function () {
        $('.btn-group').not($(this)).removeClass('visible').find('ul').fadeOut(150);
        $(this).toggleClass('visible');
        if ($(this).hasClass('visible')) {
            $(this).find('ul').fadeIn(150);
        } else {
            $(this).find('ul').fadeOut(150);
        }
    });

    /* ajax cart */
    $('#cart > .heading a').die('click');
    $('#cart').die('mouseleave').die('mouseover').die('mouseleave').die('click');
    $('#cart').live('click', function () {
        if (!$("#cart").hasClass('active')) {
            $('#cart').load('index.php?route=module/cart #cart > *');
            $('#cart').addClass('active');
        } else {
            $('#cart').removeClass('active');
        }
    });

    /* block sticky header */
    $('header').addClass('sticky-off');
    $('header').removeClass('sticky-header-center').removeClass('sticky-header');
};

Journal.onMobile = function () {
    Journal.setupMenu('mobile');
    Journal.onMobileOrTablet();

    /* add journal-mobile class to html */
    $('html').addClass('journal-mobile').removeClass('journal-desktop');

    /* switch elements */
    $('.journal-header-default .journal-search, .journal-header-menu .journal-search').after($('.journal-header-default .journal-cart, .journal-header-menu .journal-cart'));
    $('.journal-header-center .journal-links').before($('.journal-header-center .journal-language'));
    $('.journal-header-center .journal-logo').after($('.journal-header-center .journal-search'));

    Journal.itemsEqualHeight();
};

Journal.onTablet = function () {
    /* switch some elements in markup */
    $('.journal-header-default .journal-search, .journal-header-menu .journal-search').after($('.journal-header-default .journal-cart, .journal-header-menu .journal-cart'));
    $('.journal-header-center .journal-links').after($('.journal-header-center .journal-language'));
    if (!$('.journal-header-center').hasClass('journal-header-mega')) {
        $('.journal-header-center .journal-search').after($('.journal-header-center .journal-logo'));
    }
    Journal.setupMenu(Journal.mobileMenuOnTablet ? 'mobile' : 'tablet');
    Journal.onMobileOrTablet();

    /* add journal-desktop class to html*/
    $('html').removeClass('journal-mobile').addClass('journal-desktop');

    Journal.itemsEqualHeight();
};

Journal.onDesktop = function () {
    /* switch some elements in markup */
    $('.journal-header-default .journal-login, .journal-header-menu .journal-login').before($('.journal-header-default .journal-cart, .journal-header-menu .journal-cart'));
    $('.journal-header-center .journal-links').after($('.journal-header-center .journal-language'));
    if (!$('.journal-header-center').hasClass('journal-header-mega')) {
        $('.journal-header-center .journal-search').after($('.journal-header-center .journal-logo'));
    }
    Journal.setupMenu('desktop');
    /* add journal-desktop class to html*/
    $('html').removeClass('journal-mobile').addClass('journal-desktop');

    /* hover on currency */
    $('.btn-group').unbind('click').unbind('hoverIntent').hoverIntent(function () {
        $(this).find('ul').fadeIn(150);
    },  function () {
        $(this).find('ul').fadeOut(150);
    });

    /* ajax cart event*/
    $('#cart > .heading a').die('click');
    $('#cart').die('mouseleave').die('mouseover').die('mouseleave').die('click');
    $('#cart').live('mouseover', function () {
        if (!$("#cart").hasClass('active')) {
            $('#cart').load('index.php?route=module/cart #cart > *');
            $('#cart').addClass('active');
            $('#cart').live('mouseleave', function () {
                $(this).removeClass('active');
            });
        }
    });
    $('header').removeClass('sticky-off');
    Journal.itemsEqualHeight();
};

Journal.enableStickyHeader = function () {
    if ($('header').hasClass('journal-header-center')) {
        $("header").sticky({topSpacing: -40});
        $(window).scroll(function () {
            if (!$('html').hasClass('noscroll')) {
                if (!$('header').hasClass('sticky-off')) {
                    if ($(window).scrollTop() > 40) {
                        $(".journal-header-center").addClass('sticky-header-center');
                    } else {
                        $(".journal-header-center").removeClass('sticky-header-center');
                    }
                }
            }
        });
        return;
    }
    if ($('header').hasClass('journal-header-default') || $('header').hasClass('journal-header-menu')) {
        $("header").sticky({topSpacing: 0});
        $(window).scroll(function () {
            if (!$('html').hasClass('noscroll')) {
                if (!$('header').hasClass('sticky-off')) {
                    if ($(window).scrollTop() > 80) {
                        $(".journal-header-default, .journal-header-menu").addClass('sticky-header');
                        $('.journal-header-default #header .journal-search, .journal-header-menu #header .journal-search').after($('.journal-header-default #header .journal-cart, .journal-header-menu #header .journal-cart'));
                    } else {
                        $(".journal-header-default, .journal-header-menu").removeClass('sticky-header');
                        $('.journal-header-default #header .journal-links, .journal-header-menu #header .journal-links').after($('.journal-header-default #header .journal-cart, .journal-header-menu #header .journal-cart'));
                    }
                }
            }
        });
    }
};

Journal.enableSideBlocks = function () {
    $('.side-block-block.side-block-left, .side-block-block.side-block-right').each(function () {
        var $content = $(this).find('.side-block-content');
        setTimeout(function () {
            $content.load($content.attr('data-url'));
        }, 2000);
    });

    $('.side-block-block.side-block-left .side-block-icon').hoverIntent(function () {
        $(this).parent().stop().animate({'left' : '0px'});
    });

    $('.side-block-block.side-block-left .side-block-content').mouseleave(function () {
        var x = $(this).parent().width();
        $(this).parent().stop().animate({'left': -x});
    });

    $('.side-block-block.side-block-right .side-block-icon').hoverIntent(function () {
        $(this).parent().stop().animate({'right' : '0px'});
    });

    $('.side-block-block.side-block-right .side-block-content').mouseleave(function () {
        var y = $(this).parent().width();
        $(this).parent().stop().animate({'right' : -y});
    });
};

Journal.enableSelectOptionAsButtonsList = function () {
    $('.option select').each(function () {
        var $select = $(this);
        $select.hide();
        var html = '';
        html += '<ul>';
        $select.find('option').each(function () {
            if (!$(this).val()) {
                return;
            }
            html += '<li data-value="' + $(this).val() + '"><span>' + $(this).text() + '</span></li>';
        });
        html += '</ul>';
        $select.after($(html));
        var $li = $select.closest('.option').find('li');
        $li.click(function () {
            $li.removeClass('selected');
            $(this).addClass('selected');
            $select.find('option[value=' + $(this).attr('data-value') + ']').attr('selected', 'selected');
            $select.trigger('change');
        });
    });
};

Journal.openPopup = function (module_id) {
    $.magnificPopup.open({
        items: {
            src: 'index.php?route=module/journal2_popup/show&module_id=' + module_id
        },
        closeOnContentClick: false,
        closeOnBgClick: false,
        type: 'ajax',
        removalDelay: 200,
        callbacks: {
            beforeClose: function () {
                $('.mfp-content').addClass('popup-close');
            }
        }
    }, 0);
};

function addToCart(product_id, quantity) {
    quantity = typeof(quantity) != 'undefined' ? quantity : 1;

    $.ajax({
        url: 'index.php?route=checkout/cart/add',
        type: 'post',
        data: 'product_id=' + product_id + '&quantity=' + quantity,
        dataType: 'json',
        success: function(json) {
            $('.success, .warning, .attention, .information, .error').remove();

            if (json['redirect']) {
                location = json['redirect'];
            }

            if (json['success']) {
                if (!Journal.showNotification(json['success'], json['image'])) {
                    $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                }
                $('.success').fadeIn('slow');
                $('#cart-total').html(json['total']);
            }
        }
    });
}
function addToWishList(product_id) {
    $.ajax({
        url: 'index.php?route=account/wishlist/add',
        type: 'post',
        data: 'product_id=' + product_id,
        dataType: 'json',
        success: function(json) {
            $('.success, .warning, .attention, .information').remove();

            if (json['success']) {
                if (!Journal.showNotification(json['success'], json['image'])) {
                    $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                }
                $('.success').fadeIn('slow');

                try {
                    $('.wishlist-total .product-count').html(json['total'].match(/\(\d+\)/g)[0].replace('(', '').replace(')', ''));
                } catch (e) { }
            }
        }
    });
}

function addToCompare(product_id) {
    $.ajax({
        url: 'index.php?route=product/compare/add',
        type: 'post',
        data: 'product_id=' + product_id,
        dataType: 'json',
        success: function(json) {
            $('.success, .warning, .attention, .information').remove();

            if (json['success']) {
                if (!Journal.showNotification(json['success'], json['image'])) {
                    $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
                }
                $('.success').fadeIn('slow');

                try {
                    $('#compare-total').html(json['total']);
                    $('.compare-total .product-count').html(json['total'].match(/\(\d+\)/g)[0].replace('(', '').replace(')', ''));
                } catch (e) { }
            }
        }
    });
}

Journal.SuperFilter = {};

Journal.SuperFilter.firstLoad = true;

Journal.SuperFilter.init = function ($parent) {
    /* reset button event */
    $parent.find('.sf-reset').live('click', function () {
        Journal.SuperFilter.reset($parent);
    });

    /* checkbox events */
    $parent.find('input[type="checkbox"]').live('click', function () {
        var $box = $(this).closest('.box');
        if ($box.hasClass('sf-single')) {
            $box.find('input[type="checkbox"]').not($(this)).removeAttr('checked');
        }
        setTimeout(function () { Journal.SuperFilter.filter($parent); }, 1);
    });

    /* address change event*/
    $.address.change(function (e) {
        if (!Journal.SuperFilter.firstLoad || (Journal.SuperFilter.firstLoad && ($(location).attr('hash').replace('#/', '').replace('#', '')))) {
            Journal.SuperFilter.doFilter($parent, e.value);
        }
        Journal.SuperFilter.firstLoad = false;
    });

    $(function () {
        /* sort order and limit */
        $('.sort select, .limit select').removeAttr('onchange').live('change', function (e) {
            Journal.SuperFilter.filter($parent);
            return false;
        });

        /* pagination change */
        $('.pagination').removeClass('hide');
        $('.pagination .links a').live('click', function (e) {
            $parent.find('.sf-page').val($(this).attr('href').split('page=')[1]);
            Journal.SuperFilter.filter($parent);
            $('html, body').animate({scrollTop: 0}, 700);
            return false;
        });
    });

    /* render initial price slider */
    Journal.SuperFilter.priceSlider($parent);
};

Journal.SuperFilter.reset = function ($parent) {
    var location = window.location.href;
    location = location.split("#");
    window.location.href = location[0];
};

Journal.SuperFilter.filter = function ($parent) {
    var filters = {};
    /* get selected filters */
    $parent.find('.box').not('.sf-tags').find('input:checked').each(function () {
        var name = $(this).attr('name');
        filters[name] = filters[name] || {
            name: name,
            group: name.replace(/\D/g, ''),
            filters: []
        };
        filters[name].filters.push({
            keyword: $(this).attr('data-keyword'),
            value: $(this).val()
        });
    });

    /* build url */
    var url_parts = [];
    for (var i in filters) {
        var keywords = [];
        var values = [];
        var type = filters[i].name[0];
        var group = filters[i].group;
        for (var j in filters[i].filters) {
            keywords.push(filters[i].filters[j].keyword);
            values.push(filters[i].filters[j].value);
        }
        url_parts.push(keywords.join(',') + '-' + (group ? '' + type + group + '-v' : type) + values.join(','));
    }

    /* add tags */ 
    var tags = [];
    $parent.find('.sf-tags').find('input:checked').each(function () {
        tags.push($(this).val());
    });
    if (tags.length) {
        url_parts.push(tags.join(',') + '-tags');
    };

    /* add sort order */
    if ($('.sort').length > 0) {
        var value = $('.sort select option:selected').val().split('sort=')[1].split('&');
        url_parts.push('sort=' + value[0]);
        url_parts.push('order=' + value[1].replace('order=', ''));
    }

    /* add limit */
    if ($('.limit').length > 0) {
        url_parts.push('limit=' + $('.limit select option:selected').text());
    }

    /* add price */
    if ($parent.find('.sf-price').length > 0) {
        var minPrice = $parent.find('.sf-price .slider').attr('data-min') || $parent.find('.sf-price .slider').attr('data-min-value');
        var maxPrice = $parent.find('.sf-price .slider').attr('data-max') || $parent.find('.sf-price .slider').attr('data-max-value');
        if(minPrice && maxPrice){
            url_parts.push('minPrice=' + minPrice);
            url_parts.push('maxPrice=' + maxPrice);
        }
    }

    /* add pagination */
    var page = $parent.find('.sf-page').val();
    if (page) {
        url_parts.push('page=' + page);
    }

    /* change hash value */
    $.address.value(url_parts.join('/'));
};

Journal.SuperFilter.doFilter = function ($parent, url) {
    /* post data */
    var data = {
        filters         : url,
        route           : $parent.attr('data-route'),
        path            : $parent.attr('data-path'),
        manufacturer_id : $parent.attr('data-manufacturer'),
        search          : $parent.attr('data-search'),
        tag             : $parent.attr('data-tag')
    }

    if ($("input#description").length) {
        data.description  = $("input#description").is(':checked') ? 1 : 0;
    };

    /* set data for infinite scroll */
    window.J2FilterData = data;

    /* hide pagination */
    $('.pagination').addClass('hide');

    /* hide elements */
    $('.sf-loader').remove();
    $('.main-products.product-list, .main-products.product-grid').append('<div class="sf-loader"><span>' + $parent.attr('data-loading-text') + '</span></div>');

    /* filters */
    $.ajax({
        url: $parent.attr('data-filters-action'),
        type: 'post',
        async: false,
        data: data,
        success: function (response) {
            $parent.html($(response.replace(/\n/g, " ")).html());
            Journal.SuperFilter.setFilters($parent, url);
        }
    });

    /* products */
    $.ajax({
        url: $parent.attr('data-products-action'),
        type: 'post',
        data: data,
        success: function (response) {
            var $html = $('<div>' + response.replace(/\n/g, " ") + '</div>');

            $(".main-products.product-list, .main-products.product-grid").html($html.find('.product-list').html());

            if ($(".product-list").length == 0 &&  $(".product-grid").length == 0) {
                $("#content .content:eq(1)").replaceWith($html.html());
            };
            if ($(".pagination").length > 0) {
                $(".pagination").html($html.find('.pagination').html());
            }else{
                $(".pagination").after($html.find('.pagination').html());
                $(".pagination").after($html.find('.pagination').html());
            }

            $('.pagination').removeClass('hide');

            setTimeout(function(){
                if(Journal.quickViewStatus){
                    Journal.enableQuickView();
                }
                $('.main-products .product-grid-item .image > a').prepend('<div class="p-over p-grid-over"> </div>');
                $('.main-products .product-list-item .image > a').prepend('<div class="p-over p-list-over"> </div>');

                Journal.disableAddToCartButton();
            }, 1);

            Journal.SuperFilter.setNavigation();
        }
    });
};

Journal.SuperFilter.setFilters = function ($parent, url) {
    var categoryPattern = /-c(((\d+)(,*))+)/;
    var manufacturerPattern = /-m(((\d+)(,*))+)/;
    var attributePattern = /-a(\d*)-v/;
    var optionPattern = /-o(\d*)-v/;
    var tagsPattern = /(.+)-tags/;

    var sort = null;
    var order = null;
    var minPrice = Math.floor(parseFloat($parent.find('.sf-price').attr('data-min-price')));
    var maxPrice = Math.ceil(parseFloat($parent.find('.sf-price').attr('data-max-price')));

    $.each(url.split('/'), function (index, part) {
        /* categories */
        if (categoryPattern.test(part)) {
            var values = part.split(categoryPattern);
            $.each(values[1].split(','), function (i, value) {
                $parent.find('.sf-category input[value="' + value + '"]').attr('checked', 'checked');
            });
            return;
        }

        /* manufacturers */
        if (manufacturerPattern.test(part)) {
            var values = part.split(manufacturerPattern);
            $.each(values[1].split(','), function (i, value) {
                $parent.find('.sf-manufacturer input[value="' + value + '"]').attr('checked', 'checked');
            });
            return;
        }

        /* attributes */
        if (attributePattern.test(part)) {
            var values = part.split(attributePattern);
            $.each(values[2].split(','), function (i, value) {
                $parent.find('.sf-attribute-' + values[1] + ' input[value="' + value + '"]').attr('checked', 'checked');
            });
            return;
        }

        /* options */
        if (optionPattern.test(part)) {
            var values = part.split(optionPattern);
            $.each(values[2].split(','), function (i, value) {
                $parent.find('.sf-option-' + values[1] + ' input[value="' + value + '"]').attr('checked', 'checked');
            });
            return;
        }

        /* tags */
        if (tagsPattern.test(part)) {
            var values = part.split(tagsPattern);
            $.each(values[1].split(','), function (i, value) {
                $parent.find('.sf-tags input[value="' + value + '"]').attr('checked', 'checked');
            });
            return;
        }

        /* limit */
        if (part.indexOf('limit=') !== -1) {
            $('.limit select option[value$="' + part + '"]').attr('selected', 'selected');
            return;
        }

        /* sort */
        if (part.indexOf('sort=') !== -1) {
            sort = part;
            return;
        };

        /* order */
        if (part.indexOf('order=') !== -1) {
            order = part;
            return;
        };

        /* min price */
        if (part.indexOf('minPrice=') !== -1) {
            minPrice = part.replace('minPrice=', '');
            return;
        }

        /* max price */
        if (part.indexOf('maxPrice=') !== -1) {
            maxPrice = part.replace('maxPrice=', '');
            return;
        }
    });

    /* check sort order select */
    $('.sort select option[value$="' + sort + "&" + order +'"]').attr('selected', 'selected');

    /* set slider values */
    if (minPrice && maxPrice) {
        $parent.find('.slider').attr('data-min-value', minPrice);
        $parent.find('.slider').attr('data-max-value', maxPrice);
    }

    setTimeout(function () {
        Journal.SuperFilter.priceSlider($parent);
    }, 0);    
    
    /* add selected class */
    $parent.find('input:checked').each(function () {
        $(this).closest('label').addClass('sf-checked');
    });
};

Journal.SuperFilter.collision = function ($div1, $div2) {
    if (!$div1.length || $div2.length) return false;
    var x1 = $div1.offset().left;
    var w1 = 40;
    var r1 = x1 + w1;
    var x2 = $div2.offset().left;
    var w2 = 40;
    var r2 = x2 + w2;

    return !(r1 < x2 || x1 > r2);
}

Journal.SuperFilter.price = function ($parent, value) {
    var currency_left = $parent.attr('data-currency-left');
    var currency_right = $parent.attr('data-currency-right');
    var currency_decimal = $parent.attr('data-currency-decimal');
    var currency_thousand = $parent.attr('data-currency-thousand');
    value = value.toString().replace('.', currency_decimal).replace(/\B(?=(\d{3})+(?!\d))/g, currency_thousand);
    return currency_left ? (currency_left + value) : (value + currency_right);
}

Journal.SuperFilter.priceSlider = function ($parent) {
    $parent.find('.slider').slider({
        range: true,
        min: Math.floor(parseFloat($parent.find('.sf-price').attr('data-min-price'))),
        max: Math.ceil(parseFloat($parent.find('.sf-price').attr('data-max-price'))),
        values: [ parseFloat($parent.find('.slider').attr('data-min-value')), parseFloat($parent.find('.slider').attr('data-max-value')) ],
        slide: function(event, ui) {
            $('.ui-slider-handle:eq(0) .price-range-min').html(Journal.SuperFilter.price($parent, ui.values[0]));
            $('.ui-slider-handle:eq(1) .price-range-max').html(Journal.SuperFilter.price($parent, ui.values[1]));
            $('.price-range-both').html('<i>' + Journal.SuperFilter.price($parent, ui.values[0]) + ' - </i>' + Journal.SuperFilter.price($parent, ui.values[1]) );

            if ( ui.values[0] == ui.values[1] ) {
                $('.price-range-both i').css('display', 'none');
            } else {
                $('.price-range-both i').css('display', 'inline');
            }

            if (Journal.SuperFilter.collision($('.price-range-min'), $('.price-range-max')) == true) {
                $('.price-range-min, .price-range-max').css('opacity', '0');
                $('.price-range-both').css('display', 'block');
            } else {
                $('.price-range-min, .price-range-max').css('opacity', '1');
                $('.price-range-both').css('display', 'none');
            }
        },
        change: function (event, ui) {
            $(this).attr('data-min', ui.values[0]);
            $(this).attr('data-max', ui.values[1]);
            Journal.SuperFilter.filter($parent);
        }
    });

    $('.ui-slider-range').append('<span class="price-range-both value"><i>' + Journal.SuperFilter.price($parent, $parent.find('.slider').slider('values', 0 )) + ' - </i>' + Journal.SuperFilter.price($parent, $parent.find('.slider').slider('values', 1 )) + '</span>');
    $('.ui-slider-handle:eq(0)').append('<span class="price-range-min value">' + Journal.SuperFilter.price($parent, $parent.find('.slider').slider('values', 0 )) + '</span>');
    $('.ui-slider-handle:eq(1)').append('<span class="price-range-max value">' + Journal.SuperFilter.price($parent, $parent.find('.slider').slider('values', 1 )) + '</span>');

    if ( $('.price-range-min').html() === $('.price-range-max').html() ) {
        $('.price-range-both i').css('display', 'none');
    } else {
        $('.price-range-both i').css('display', 'inline');
    }

    if (Journal.SuperFilter.collision($('.price-range-min'), $('.price-range-max')) == true) {
        $('.price-range-min, .price-range-max').css('opacity', '0');
        $('.price-range-both').css('display', 'block');
    } else {
        $('.price-range-min, .price-range-max').css('opacity', '1');
        $('.price-range-both').css('display', 'none');
    }
};

Journal.SuperFilter.setNavigation = function () {
    /* sort and limit events */
    $('.sort select, .limit select').removeAttr('onchange');

    /* display product grid */
    display($.totalStorage('display'));
};

Journal.countdown = function ($elem, date) {
    $elem.countdown({
        date: date,
        render: function (date) {
            return $(this.el).html("<span>"
            + date.days + " <div>" + Journal.COUNTDOWN.DAYS + "</div></span> <span>"
            + (this.leadingZeros(date.hours)) + " <div>" + Journal.COUNTDOWN.HOURS + "</div></span> <span> "
            + (this.leadingZeros(date.min)) + " <div>" + Journal.COUNTDOWN.MINUTES + "</div></span> <span> "
            + (this.leadingZeros(date.sec)) + " <div>" + Journal.COUNTDOWN.SECONDS + "</div> </span>");
        }
    });
};

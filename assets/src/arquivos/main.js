var fns = {
	isMobile: function(){
		var userAgent = navigator.userAgent.toLowerCase();
		if( userAgent.search(/(android|avantgo|blackberry|iemobile|nokia|lumia|bolt|boost|cricket|docomo|fone|hiptop|mini|mobi|palm|phone|pie|tablet|up\.browser|up\.link|webos|wos)/i)!= -1 ){
			//$('.lightboxOverlay').remove();
			return true;
		};
	},

	verifyWidth: function () {
		if ($(window).width() <= 1024) {
			$('body').addClass('isMobile');
			$('body').removeClass('notMobile');
			return true
		} else {
			$('body').removeClass('isMobile');
			$('body').addClass('notMobile');
			return false
		}
	},	
}

var global = {
    menuToggle: function () {
        // Open Menu
        $('.menu-mobile-toggle').on('click', function (e) {
            if (fns.verifyWidth()) {
                e.preventDefault();
                $('.navOverlay').addClass('active');
                $('.pageNav').addClass('open');
                $('body').addClass('menuOpen');
            }
        })

        //Close Menu
        $('.navHead .ico-close').on('click', function (e) {
            if (fns.verifyWidth()) {
                e.preventDefault();
                $('.navOverlay').removeClass('active');
                $('.pageNav').removeClass('open');
                $('body').removeClass('menuOpen');
            }
        });
    },

    footerMenuToggle: function () {
        $('.toggle h3').on('click', function (e) {
            e.preventDefault();
            var that = $(this);
            var itemContent = that.parent().find('.itemContent');

            if ($(window).width() <= 720) {
                if (!itemContent.hasClass('active')) {
                    $('.toggle h3').parent().find('.itemContent').stop(true,true).hide(300).removeClass('active');
                    itemContent.addClass('active').stop(true,true).show(300);
                    $('.toggle h3').removeClass('active');
                    that.addClass('active');
                } else {
                    that.removeClass('active');
                    itemContent.stop(true,true).hide(300).removeClass('active');
                }
            }
        })
    },
    
    init: function () {
        global.menuToggle();
    	global.footerMenuToggle();
    }
}

$(document).ready(function () {	
	global.init();	
});

$(window).load(function() {
    $(window).resize(function() {
       fns.verifyWidth();
    })
});
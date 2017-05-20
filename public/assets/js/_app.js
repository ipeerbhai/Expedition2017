$(function() {
	Navigation.init();
	ParallaxScroll.init();
	Testimonials.init();
	Tweets.init();
	LatestPosts.init();
	Map.init();
	Contact.init();
	ScrollOnTop.init();
	CountTo.init();
	VideoBackground.init();
	InputEffects.init();
	ScreenPreview.init();
});

Navigation = {
	init: function() {
		// Mobile navigation
		if ($('.navbar-nav li:has(ul)').length) {
			$('.navbar-nav li:has(ul)').doubleTapToGo();
		}
	}
}

ParallaxScroll = {
	init: function() {
		if ($('.visible-xs').is(':hidden') || $('.blogHeader').length) {
			var parallax = skrollr.init({
				forceHeight: false,
				smoothScrolling: true
			});
			if (parallax.isMobile()) {
				parallax.destroy();
			}
		}
	}
}

// Testimonials carousel
Testimonials = {
	init: function() {
		if ($('.js-testimonials-carousel').length) {
			$('.js-testimonials-carousel').owlCarousel({
				loop: true,
				margin: 0,
				nav: true,
				items: 1,
				autoHeight: true,
				navText: ['<i class="fa fa-angle-left"></i>','<i class="fa fa-angle-right"></i>'],
				dots: false
			});
		}
	}
}

// Tweets carousel
Tweets = {
	init: function() {
		if ($('.js-tweets').length) {
			$('.js-tweets').owlCarousel({
				loop: true,
				margin: 0,
				nav: false,
				items: 1,
				autoHeight: true,
			});
		}
	}
}

// Latest post Masonry
LatestPosts = {
	init: function() {
		$(window).load(function() {
			if ($('.js-latestPosts').length) {
				$('.js-latestPosts').masonry({
					itemSelector: '.i',
					isOriginLeft: true,
				});
			}
		});
	}
}

// Google map initialization
Map = {
	init: function() {
		if ($('#googleMap').length) {
			var lat = $('#googleMap').attr('data-lat');
			var lng = $('#googleMap').attr('data-lng');
			
			function initialize() {
				var view = new google.maps.LatLng(lat, lng);
				var mapOptions = {
					zoom: 14,
					scrollwheel: false,
					mapTypeId: google.maps.MapTypeId.ROADMAP,
					disableDefaultUI: false,
					center: view,
				}
				
				var map = new google.maps.Map(document.getElementById('googleMap'), mapOptions);
				
				// Set custom marker
				var myLatLng = new google.maps.LatLng(lat, lng);
				var marker = new google.maps.Marker({
					position: myLatLng,
					map: map,
					icon: 'img/map-pin.png'
				});
			}

			google.maps.event.addDomListener(window, 'load', initialize);
		}
	}
}

// Contact
Contact = {
	init: function() {
		$('.js-contactForm .option :radio').change(function() {
			if($(this).is(':checked'))  {
				$('.js-contactForm .option.active').removeClass('active');
				$(this).parent().addClass('active');
			}
		});
	}
}

ScrollOnTop = {
	init: function() {
		if ($('.js-backtoTop').length) {
			$('.js-backtoTop').waypoint(function() {
				$('.js-backtoTop').toggleClass('sticky');
			}, { offset: 30 });
		}

		$('.js-backtoTop').click(function() {
			$('body, html').animate({ scrollTop: 0 }, 500); return false;
		});
	}
}

CountTo = {
	init: function() {
		if ($('.js-count').length) {
			$('.js-count').waypoint(function() {
				$('.js-count').data('countToOptions', {
					formatter: function (value, options) {
						return value.toFixed(options.decimals).replace(/\B(?=(?:\d{3})+(?!\d))/g, ',');
					}
				});
				$('.js-count').each(CountTo.count);
			}, {
				triggerOnce: true,
				offset: 'bottom-in-view'
			});
		}	
	},
	count: function(options) {
		var $this = $(this);
		options = $.extend({}, options || {}, $this.data('countToOptions') || {});
		$this.countTo(options);
	}
}

VideoBackground = {
	init: function() {
		if ($('.js-video').length) {
			$('.js-video').vide('tmp/video', {
				playbackRate: 1,
				muted: true,
				loop: true,
				autoplay: true,
				position: "50% 50%",
				posterType: 'jpg',
				resizing: true
			});
		}
	}
}

InputEffects = {
	init: function() {
		[].slice.call( document.querySelectorAll( '.input-field' ) ).forEach( function( inputEl ) {
			if( inputEl.value.trim() !== '' ) {
				classie.add( inputEl.parentNode, 'input-filled' );
			}

			inputEl.addEventListener( 'focus', onInputFocus );
			inputEl.addEventListener( 'blur', onInputBlur );
		} );

		function onInputFocus( ev ) {
			classie.add( ev.target.parentNode, 'input-filled' );
		}

		function onInputBlur( ev ) {
			if( ev.target.value.trim() === '' ) {
				classie.remove( ev.target.parentNode, 'input-filled' );
			}
		}
	}
}

ScreenPreview = {
	init: function() {
		$('.js-screens-filter .i').click(function() {
			$(this).siblings('.i').find('a').removeClass('active');
			$(this).find('.hoverExtend').addClass('active');
		});
	}
}
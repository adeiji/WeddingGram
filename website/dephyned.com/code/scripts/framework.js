// JavaScript Document


$(document).ready(function(){
	"use strict"
	
	/////////////////////////////////////////////////
	//Setting and Detecting Mobile Browser Agents////
	/////////////////////////////////////////////////
	
	var isMobile = {
		Android: function() {
			return navigator.userAgent.match(/Android/i);
		},
		BlackBerry: function() {
			return navigator.userAgent.match(/BlackBerry/i);
		},
		iOS: function() {
			return navigator.userAgent.match(/iPhone|iPad|iPod/i);
		},
		Opera: function() {
			return navigator.userAgent.match(/Opera Mini/i);
		},
		Windows: function() {
			return navigator.userAgent.match(/IEMobile/i);
		},
		any: function() {
			return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
		}
	};
	
	//Activate Animations On Scroll
	
	var wow = new WOW(
	  {
		boxClass:     'animated',      // animated element css class (default is wow)
		animateClass: 'animated', // animation css class (default is animated)
		offset:       0,          // distance to the element when triggering the animation (default is 0)
		mobile:       false        // trigger animations on mobile devices (true is default)
	  }
	);
	wow.init();

	/////////////
	//Lazy Load//
	/////////////
	
	$(function() {
		$("img.preload").show().lazyload({effect : "fadeIn", threshold : 200});
	});
	
	//Detect if iOS WebApp engaged and//
	//permit navigation without Safari//
	(function (a, b, c) {
	    if (c in b && b[c]) {
	        var d, e = a.location,
	            f = /^(a|html)$/i;
	        a.addEventListener("click", function (a) {
	            d = a.target;
	            while (!f.test(d.nodeName)) d = d.parentNode;
	            "href" in d && (d.href.indexOf("http") || ~d.href.indexOf(e.host)) && (a.preventDefault(), e.href = d.href)
	        }, !1)
	    }
	})(document, window.navigator, "standalone")
	

	/////////////////////////////////////////////////////
	//Initiating Parallax Effects if Non Mobile Browser//
	/////////////////////////////////////////////////////
	
	if( !isMobile.any() ){
		$(window).stellar();
		$.stellar({
			verticalOffset: -250
		});	        
	}

	////////////////////////////
	//Thumbnail Slider Overlay//
	////////////////////////////
	
	$('.thumbnail-slider a, .thumbnail-overlay').hover(function(){
		$(this).parent().find('.thumbnail-overlay').stop(true,true).fadeIn(200);
	},function(){
		$(this).parent().find('.thumbnail-overlay').stop(true,true).fadeOut(200);
	});
	

	/////////////////////////////
	//Responsive Tabs/Accordion//
	/////////////////////////////
	$('.horizontalTab').responsiveTabs({
            startCollapsed: 'accordion',
            collapsible: true,
            rotate: false
	});
	
	/////////////////
	//Notifications//
	/////////////////
	$('.close-small-notification').click(function(){
		$(this).parent().parent().animate({
			height:0,
			marginBottom:'0!important',
			padding:0,
		  }, 150, 'easeInOutExpo', function () {;
		}).fadeOut(0);
		return false;
	});
	
	$('.close-contact-notification').click(function(){
		return false;	
	})

	
	$('.close-big-notification').click(function(){
		$(this).parent().animate({
			height:0,
			marginBottom:0,
			padding:0,
		  }, 300, 'easeInOutExpo', function () {;
		}).fadeOut(0);
		return false;
	});
	
	///////////////
	//Radio Stuff//
	///////////////
	$('.radio-class-1').click(function(){$(this).toggleClass('radio-unselected-1');	return false;});
	$('.radio-class-2').click(function(){$(this).toggleClass('radio-unselected-2');	return false;});
	$('.radio-class-3').click(function(){$(this).toggleClass('radio-unselected-3');	return false;});

	$('.checkbox-class-1').click(function(){$(this).toggleClass('checkbox-unselected-1');	return false;});
	$('.checkbox-class-2').click(function(){$(this).toggleClass('checkbox-unselected-2');	return false;});
	$('.checkbox-class-3').click(function(){$(this).toggleClass('checkbox-unselected-3');	return false;});
	$('.checkbox-class-4').click(function(){$(this).toggleClass('checkbox-unselected-4');	return false;});

	/////////////
	//Accordion//
	/////////////
	$('.accordion-header').toggleClass('inactive-header');
	$('.accordion-header').click(function () {
		if($(this).is('.inactive-header')) {
			$('.active-header').toggleClass('active-header').toggleClass('inactive-header').next().slideToggle(200).toggleClass('open-content');
			$(this).toggleClass('active-header').toggleClass('inactive-header');
			$(this).next().slideToggle(200).toggleClass('open-content');
		}
		else {
			$(this).toggleClass('active-header').toggleClass('inactive-header');
			$(this).next().slideToggle(200).toggleClass('open-content');
		}
		return false;	
	});

	//////////////////////////////////////////////////////////////////////////////
	//Adding Classes for CSS3 Animations, Instead of jquery.animte, we used css3//
	//it might be a little bit more complicated, but the effect is faster speeds//
	//on most mobile devices on the market! Your mobile users will love you///////
	//////////////////////////////////////////////////////////////////////////////
	
	$('.formats a').click(function(){
		return false;
	});

	$('.image-carousel .item').hover(function(){
		$(this).find('.image-carousel-controls .image-carousel-zoom').toggleClass('image-carousel-zoom-animated');
		$(this).find('.image-carousel-controls .image-carousel-href').toggleClass('image-carousel-href-animated');
	});
	
	$('.center-icon-column').hover(function(){
		$(this).parent().find('h1').toggleClass('animate-center-icon');
		$(this).parent().find('h5, h6').toggleClass('animate-center-icon-heading');
		$(this).parent().find('p').toggleClass('animate-center-icon-text');
		$(this).parent().find('a').toggleClass('animate-center-icon-href');
		$(this).parent().find('.center-column-icon-decoration').toggleClass('animate-center-icon-decoration');
	});
	
	$('.blue-center-icon-column').hover(function(){
		$(this).toggleClass('animate-center-icon-bg-blue');
	});
	
	$('.red-center-icon-column').hover(function(){
		$(this).toggleClass('animate-center-icon-bg-red');
	});
	
	$('.green-center-icon-column').hover(function(){
		$(this).toggleClass('animate-center-icon-bg-green');
	});
	
	$('.dark-center-icon-column').hover(function(){
		$(this).toggleClass('animate-center-icon-bg-dark')
	});
	
	$('.toggle-1-title').click(function(){
		$(this).find('span').toggleClass('toggle-1-active');
		$(this).parent().parent().find('.toggle-1-text').toggle(200);
		return false;
	});

	$('.toggle-2-title').click(function(){
		$(this).find('a span i').toggleClass('toggle-2-active');
		$(this).parent().parent().find('.toggle-2-text').toggle(200);
		return false;
	});	

	$('.toggle-3-title').click(function(){
		$(this).find('a span i').toggleClass('toggle-3-active');
		$(this).parent().parent().find('.toggle-3-text').toggle(200);
		return false;
	});
	
	////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////
	//Framework Slider and Carousel Initializastions////////////////
	////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////

	function doOnOrientationChange() {
		switch (window.orientation) {
		case -90:
		case 90:
			var size_screen = $('.slider-container').height();
			var size_caption = $('.fullscreen-caption').height();
			$('.slider-clear').animate({
				height: size_screen + 40,
			}, 0, 'easeInOutQuad', function () {
			});
			$('.fullscreen-caption').animate({
				 marginTop: (size_screen/2) - (size_caption/2)+20,
			}, 0, 'easeInOutQuad', function () {
			});
			break;
		default:
			var size_screen = $('.slider-container').height();
			var size_caption = $('.fullscreen-caption').height();
			$('.slider-clear').animate({
				height: size_screen + 40,
			}, 0, 'easeInOutQuad', function () {;
			});
			$('.fullscreen-caption').animate({
				marginTop: (size_screen/2) - (size_caption/2)+20,
			}, 0, 'easeInOutQuad', function () {
			});
		}
	}
	window.addEventListener('orientationchange', doOnOrientationChange);
	doOnOrientationChange();
	var detectViewPort = function(){
		var viewPortWidth = $(window).width();
	};
	
	$(window).resize(function () {
	   detectViewPort();
	   doOnOrientationChange();
	});
	
	
	//If Device is mobile then the gallery automatically is switched to SwipeBox//
	//If Device is latop / desktop the gallery is automatically switched to Colorbox//
	
	var isMobile = {
		Android: function() {
			return navigator.userAgent.match(/Android/i);
		},
		BlackBerry: function() {
			return navigator.userAgent.match(/BlackBerry/i);
		},
		iOS: function() {
			return navigator.userAgent.match(/iPhone|iPad|iPod/i);
		},
		Opera: function() {
			return navigator.userAgent.match(/Opera Mini/i);
		},
		Windows: function() {
			return navigator.userAgent.match(/IEMobile/i);
		},
		any: function() {
			return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
		}
	};
	jQuery(document).ready(function(){
		if( !isMobile.any() ){
			$(window).stellar();
			$.stellar({
				verticalOffset: -250
			});	 
			$('.detect-gallery').colorbox({
				rel:'thumb-clickfolio',
				transition:"elastic",
				speed:350,
				scalePhotos:"true",
				maxWidth:"100%",
				maxHeight:"100%"
			});
		} else {
			$(".detect-gallery").swipebox({
				useCSS : true, // false will force the use of jQuery for animations
				hideBarsDelay : 3000 // 0 to always show caption and action bar
			});	
		};
	});
	
	/////////////////
	//Image Gallery//
	/////////////////
	
	
	$('.image-carousel').owlCarousel({
		items:3,
		navigation : false, // Show next and prev buttons
		pagination: false,
		slideSpeed : 300,
		paginationSpeed : 400,
	});
	
	$('.customers-slider').owlCarousel({
		items:5,
		itemsDesktop:[1024,5],
		itemsDesktopSmall:[768, 4],
		itemsTablet:[568,3],
		itemsTabletSmall:[480, 2],
		itemsMobile:[320,1],
		navigation : false, // Show next and prev buttons
		pagination: false,
		slideSpeed : 300,
		paginationSpeed : 400,
		stopOnHover:true,
		autoPlay:3000,
	});
	
	 $(".one-image-slider").owlCarousel({
		navigation : false, // Show next and prev buttons
		pagination: false,
		slideSpeed : 300,
		paginationSpeed : 400,
		singleItem:true,
		afterInit : progressBar,
		afterMove : moved,
		startDragging : pauseOnDragging
	});
	
	
	$(".thumbnail-slider").owlCarousel({
		navigation:true,
		items:5,
		itemsDesktop:[1024,5],
		itemsDesktopSmall:[768, 4],
		itemsTablet:[568,4],
		itemsTabletSmall:[480, 3],
		itemsMobile:[320,2],
		pagination:false,
		rewindNav:true,
		rewindSpeed:200,
		responsive:true
	});	
	
	  // Custom Navigation Events
	  $(".next-thumbnail-slider").click(function(){
		$(".thumbnail-slider").trigger('owl.next');
	  })
	  $(".prev-thumbnail-slider").click(function(){
		$(".thumbnail-slider").trigger('owl.prev');
	  })
	  $(".play-thumbnail-slider").click(function(){
		$(".thumbnail-slider").trigger('owl.play');
	  })

	$('.services-slider').owlCarousel({
		items:3,
		itemsDesktop:[1024,3],
		itemsDesktopSmall:[768, 2],
		itemsTablet:[568,2],
		itemsTabletSmall:[480, 1],
		itemsMobile:[320,1],
		navigation : false, // Show next and prev buttons
		pagination: false,
		slideSpeed : 200,
		paginationSpeed : 200,
	});
	
	$(".next-services-slider").click(function(){
	  $('.services-slider').trigger('owl.next');
	  return false;
	})
	$(".prev-services-slider").click(function(){
	  $('.services-slider').trigger('owl.prev');
	  return false;
	});
	
	$('.features-slider').owlCarousel({
		items:4,
		itemsDesktop:[1366,3],
		itemsDesktopSmall:[1280, 3],
		itemsTablet:[768,2],
		itemsTabletSmall:[480, 1],
		itemsMobile:[320,1],
		navigation : false, // Show next and prev buttons
		pagination: false,
		slideSpeed : 200,
		paginationSpeed : 200,
	});
	
	$('.quotes-slider').owlCarousel({
		items:1,
		itemsDesktop:[1366,1],
		itemsDesktopSmall:[1280, 1],
		itemsTablet:[768,1],
		itemsTabletSmall:[480, 1],
		itemsMobile:[320,1],
		navigation : false, // Show next and prev buttons
		pagination: true,
		slideSpeed : 200,
		paginationSpeed : 400,
		stopOnHover:true,
		autoPlay:3000,
		autoHeight:true,
	});
	
	$(".next-features-slider").click(function(){
	  $('.features-slider').trigger('owl.next');
	  return false;
	})
	$(".prev-features-slider").click(function(){
	  $('.features-slider').trigger('owl.prev');
	  return false;
	});


	//Activating the slider//
	var time = 7; // time in seconds
	var $progressBar,
		$bar,
		$elem,
		isPause,
		tick,
		percentTime;
	
	 //Init the carousel
	$(".fullscreen-slider").owlCarousel({
		slideSpeed: 500,
		paginationSpeed: 500,
		singleItem: true,
		pagination: false,
		afterInit: progressBar,
		afterMove: moved,
		startDragging: pauseOnDragging
	});
	 //Init progressBar where elem is $("#owl-demo")
	function progressBar(elem) {
		$elem = elem;
		//build progress bar elements
		buildProgressBar();
		//start counting
		start();
	}
	 //create div#progressBar and div#bar then prepend to $("#owl-demo")
	function buildProgressBar() {
		$progressBar = $("<div>", {
			id: "progressBar"
		});
		$bar = $("<div>", {
			id: "bar"
		});
		$progressBar.append($bar).prependTo($elem);
	}
	function start() {
		//reset timer
		percentTime = 0;
		isPause = false;
		//run interval every 0.01 second
		tick = setInterval(interval, 10);
	};
	function interval() {
		if (isPause === false) {
			percentTime += 1 / time;
			$bar.css({
				width: percentTime + "%"
			});
			//if percentTime is equal or greater than 100
			if (percentTime >= 100) {
				//slide to next item 
				$elem.trigger('owl.next')
			}
		}
	}
	 //pause while dragging 
	function pauseOnDragging() {
		isPause = true;
	}
	 //moved callback
	function moved() {
		//clear interval
		clearTimeout(tick);
		//start again
		start();
	}
	 // Custom Navigation Events
	$(".next-home-fullscreen").click(function () {
		$(".fullscreen-slider").trigger('owl.next');
		return false;
	});
	$(".prev-home-fullscreen").click(function () {
		$(".fullscreen-slider").trigger('owl.prev');
		return false;
	});
	
	////////////////////////
	//Filterable Portfolio//
	////////////////////////
	
	//Detecing If Filtrable is ran from a mobile device or a desktop//
	//If it's ran from a mobile device, we'll make it swipebox//
	//If it's ran from a desktop device, we'll make it colorbox// 
	if( !isMobile.any() ){
		$(window).stellar();
		$('.cat1, .cat2, .cat3, .cat5, .cat6').colorbox({rel: function() { return $(this).data('rel')}});
	} else {
		$('.cat1, .cat2, .cat3, .cat5, .cat6').swipebox();
		$('.cat1').attr('rel', 'cat1');
		$('.cat2').attr('rel', 'cat2');
		$('.cat3').attr('rel', 'cat3');
		$('.cat4').attr('rel', 'cat4');
		$('.cat5').attr('rel', 'cat5');
		$('.cat6').attr('rel', 'cat6');
		
	};
	
	$('.swipebox').swipebox();
		
	$('.filterable-item').hover(function(){
		$(this).find('.filterable-caption').toggleClass('filterable-caption-active');
		$(this).find('img').toggleClass('filterable-item-grayscale');
	});
		  
	$('.catall').click(function(){
		$(this).addClass('selected-cat');
		$(this).parent().find('.cat1b, .cat2b, .cat3b, .cat4b, .cat5b, .cat6b').removeClass('selected-cat');
		$('.cat1, .cat2, .cat3, .cat4, .cat5').show(400); 
		$('.filterable-item img').removeClass('filterable-item-grayscale');
		$('.filterable-item').removeClass('filterable-item-scale');
		 return false;		  
	}); 
	  
	$('.cat1b').click(function(){
		$(this).addClass('selected-cat');
		$(this).parent().find('.cat2b, .cat3b, .cat4b, .cat5b, .cat6b, .catall').removeClass('selected-cat');
		$('.filterable-item img').removeClass('filterable-item-grayscale');
		$('.filterable-item').removeClass('filterable-item-scale');
		$('.cat1').show(400); 
		$('.cat1 img').addClass('filterable-item-grayscale');
		$('.cat2, .cat3, .cat4, .cat5, .cat6').addClass('filterable-item-scale');  
		return false;  
	});
	
	$('.cat2b').click(function(){ 
		$(this).addClass('selected-cat');
		$(this).parent().find('.cat1b, .cat3b, .cat4b, .cat5b, .cat6b, .catall').removeClass('selected-cat');
		$('.filterable-item img').removeClass('filterable-item-grayscale');
		$('.filterable-item').removeClass('filterable-item-scale');
		$('.cat2').show(400); 
		$('.cat2 img').addClass('filterable-item-grayscale');
		$('.cat1, .cat3, .cat4, .cat5, .cat6').addClass('filterable-item-scale');  
		return false;  
	});
	
	$('.cat3b').click(function(){
		$(this).addClass('selected-cat');
		$(this).parent().find('.cat2b, .cat1b, .cat4b, .cat5b, .cat6b, .catall').removeClass('selected-cat');
		$('.filterable-item img').removeClass('filterable-item-grayscale');
		$('.filterable-item').removeClass('filterable-item-scale');
		$('.cat3').show(400); 
		$('.cat3 img').addClass('filterable-item-grayscale');
		$('.cat1, .cat2, .cat4, .cat5, .cat6').addClass('filterable-item-scale');  
		return false;  
	});
	
	$('.cat4b').click(function(){ 
		$(this).addClass('selected-cat');
		$(this).parent().find('.cat2b, .cat3b, .cat1b, .cat5b, .cat6b, .catall').removeClass('selected-cat');
		$('.filterable-item img').removeClass('filterable-item-grayscale');
		$('.filterable-item').removeClass('filterable-item-scale');
		$('.cat4').show(400); 
		$('.cat4 img').addClass('filterable-item-grayscale');
		$('.cat1, .cat2, .cat3, .cat5, .cat6').addClass('filterable-item-scale');  
		return false;  
	});
	
	$('.cat5b').click(function(){ 
		$(this).addClass('selected-cat');
		$(this).parent().find('.cat2b, .cat3b, .cat4b, .cat1b, .cat6b, .catall').removeClass('selected-cat');
		$('.filterable-item img').removeClass('filterable-item-grayscale');
		$('.filterable-item').removeClass('filterable-item-scale');
		$('.cat5').show(400); 
		$('.cat5 img').addClass('filterable-item-grayscale');
		$('.cat1, .cat2, .cat3, .cat4, .cat6').addClass('filterable-item-scale');  
		return false;  
	});
	
	$('.cat6b').click(function(){ 
		$(this).addClass('selected-cat');
		$(this).parent().find('.cat2b, .cat3b, .cat4b, .cat5b, .cat1b, .catall').removeClass('selected-cat');
		$('.filterable-item img').removeClass('filterable-item-grayscale');
		$('.filterable-item').removeClass('filterable-item-scale');
		$('.cat6').show(400); 
		$('.cat6 img').addClass('filterable-item-grayscale');
		$('.cat1, .cat2, .cat3, .cat4, .cat5').addClass('filterable-item-scale');  
		return false;  
	});	
	
/*
Custom Add To Homescreen Script  
Responsive with automatic iOS device detection

This code CANNOT be shared or used for commercial projects outside the item it resides in! 
This code CAN be shared and used by it's respective developer (Enabled) for ThemeForest items
If you wish to use this code for a commercial project outside the item it resides in,
please purchase a license from http://codecanyon.net/item/add-to-home-homescreen-bookmark-script-for-ios/6925738

*/

	/////////////////////////////////////////////////////
	// Creating a cookie for the custom addToHome script/
	/////////////////////////////////////////////////////
	
	function createCookie(name,value,days) {
		if (days) {
			var date = new Date();
			date.setTime(date.getTime()+(days*24*60*60*1000));
			var expires = "; expires="+date.toGMTString();
		}
		else var expires = "";
		document.cookie = name+"="+value+expires+"; path=/";
	}
	
	function readCookie(name) {
		var nameEQ = name + "=";
		var ca = document.cookie.split(';');
		for(var i=0;i < ca.length;i++) {
			var c = ca[i];
			while (c.charAt(0)==' ') c = c.substring(1,c.length);
			if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
		}
		return null;
	}
	
	function eraseCookie(name) {	createCookie(name,"",-1);	}
	
	var webappStatus = readCookie('webappIsCloseds');
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	//Detect user agent for known mobile devices and show hide elements for each specific element
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	var isiPhone = 		navigator.userAgent.toLowerCase().indexOf("iphone");
	var isiPad = 		navigator.userAgent.toLowerCase().indexOf("ipad");
	var isiPod = 		navigator.userAgent.toLowerCase().indexOf("ipod");
	var isiAndroid = 	navigator.userAgent.toLowerCase().indexOf("android");
	
	if(isiPhone > -1) 	 {		 $('.ipod-detected').hide();		 $('.ipad-detected').hide();		 $('.iphone-detected').show();		 $('.android-detected').hide();	 }
	if(isiPad > -1)	 {		 	 $('.ipod-detected').hide();		 $('.ipad-detected').show();		 $('.iphone-detected').hide();		 $('.android-detected').hide();	 }
	if(isiPod > -1)	 {		 	 $('.ipod-detected').show();		 $('.ipad-detected').hide();		 $('.iphone-detected').hide();		 $('.android-detected').hide();	 }   
	if(isiAndroid > -1) {		 $('.ipod-detected').hide();		 $('.ipad-detected').hide();		 $('.iphone-detected').hide();		 $('.android-detected').show();	 }  

	
	/*Show and Close WebApp*/	
	$('.delete-cookie').click(function(){
		$('.webapp-wrapper').fadeIn();
		eraseCookie('webappIsCloseds');
		return false;
	});
	
	if(window.navigator.standalone==true){	$('.webapp-warpper').hide();	}
	
		
	$('.close-webapp').click(function(){
		createCookie('webappIsCloseds', 'true' , 7);
		$('.webapp-wrapper').fadeOut();
		return false;
		$('.webapp-wrapper').fadeOut();
	});	
	
	if(isiPhone > -1){
		$('.webapp-wrapper').delay(200).fadeIn(200);
	};
	
	if(isiPad > -1){
		$('.webapp-wrapper').delay(200).fadeIn(200);
	};
	
	if(isiPod > -1){
		$('.webapp-wrapper').delay(200).fadeIn(200);
	};

	if(webappStatus == 'true'){
		$('.webapp-wrapper').hide();	
	};	

	

});


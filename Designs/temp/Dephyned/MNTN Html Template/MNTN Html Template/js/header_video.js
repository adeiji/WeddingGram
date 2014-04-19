(function($){
	
	/*** Initialization and video settings ***/
	
	$(function(){
			$(".player").mb_YTPlayer();
		});
		
	$('#main_header').add('.fr_bg_video').css('height', $(window).height()+ 20 );
	
	$('#fr_header_featured_video').flexslider({
		slideshow: true, 			// set true for autoplay
		slideshowSpeed: 7000,		//uncommented for autoplay
	});
	
})(jQuery);
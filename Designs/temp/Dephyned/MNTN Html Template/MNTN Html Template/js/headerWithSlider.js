(function($){
	var $header_featured = $('#header_featured'),
		$flexnav = $('#header_featured .flex-direction-nav');
	
	$('#header_featured .slide').css({ 'width': $(window).width() , 'height': $(window).height() });
	
	$('#header_featured .fr_slide_image').each(function(i){
			$(this).css('backgroundImage', 'url('+$(this).find('img').attr('src')+')');
			$(this).find('img').remove();
		});
	
	/*if ( $header_featured.length ){
		slider_settings = {
			slideshow: false, 			// set true for autoplay
			//slideshowSpeed: 7000,		//uncommented for autoplay
			before: function(slider){
				var $this_control = $featured_control_item.eq(slider.animatingTo),
					width_to = '239px';
					
				if ( container_width === 748 ) {width_to = '186px';}
				
				if ( $('#featured_controls').length ){
					$('#featured_controls li').removeClass().eq(slider.animatingTo).addClass('active-slide');
					return;
				}
				
				$featured_control_item.removeClass('active-slide');
				
			},
			start: function(slider) {
				slider = slider;
			}
		};			
		slider_settings.pauseOnHover = true;
		
		$header_featured.flexslider( slider_settings );
	}*/
	$header_featured.flexslider({
		slideshow: false, 			// set true for autoplay
		//slideshowSpeed: 7000,		//uncommented for autoplay
	});
	$("#header_featured").find('#left-arrow').click( function(){
			$('#header_featured .flex-direction-nav').find('a.prev').trigger('click');
			return false;
		});
	
	$("#header_featured").find('#right-arrow').click( function(){
		$('#header_featured .flex-direction-nav').find('a.next').trigger('click');
		return false;
	});
		
})(jQuery);
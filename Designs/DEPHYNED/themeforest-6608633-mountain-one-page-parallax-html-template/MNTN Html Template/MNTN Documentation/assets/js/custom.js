/***************************************************
			LIST SLIDER
***************************************************/
jQuery.noConflict()(function($){
		$(document).ready(function() {

			$.featureList(
				$("#tabs li a"),
				$("#output li"), {
					start_item	:	1
				}
			);
		});
});

/***************************************************
			ACCORDION SLIDER
***************************************************/
jQuery.noConflict()(function($){
				$('.kwicks').kwicks({
					max : 900,
					spacing : 0
				});
			});
			
			

/***************************************************
			IMAGE HOVER
***************************************************/
jQuery.noConflict()(function($){
$(document).ready(function() {  
            $('.img-preview, .attachment-four-portfolio').each(function() {
                $(this).hover(
                    function() {
                        $(this).stop().animate({ opacity: 0.5 }, 400);
                    },
                   function() {
                       $(this).stop().animate({ opacity: 1.0 }, 400);
                   })
                });
});
});
jQuery.noConflict()(function($){
			$('#slides').slides({
				preload: true,
				generateNextPrev: false
			});
			$('#slides2').slides({
				preload: true,
				generateNextPrev: false,
				generatePagination: true
			});
		});

jQuery.noConflict()(function($){
    
    $('#example-1').tipsy();
    
    $('#north').tipsy({gravity: 'n'});
    $('#south').tipsy({gravity: 's'});
    $('#east').tipsy({gravity: 'e'});
    $('#west').tipsy({gravity: 'w'});
    
    $('#auto-gravity').tipsy({gravity: $.fn.tipsy.autoNS});
    
    $('.social').tipsy({fade: true});
	$('.service-tipsy').tipsy({fade: true, gravity: 's'});
    
    $('#example-custom-attribute').tipsy({title: 'id'});
    $('#example-callback').tipsy({title: function() { return this.getAttribute('original-title').toUpperCase(); } });
    $('#example-fallback').tipsy({fallback: "Where's my tooltip yo'?" });
    
    $('#example-html').tipsy({html: true });
    
  });		 
	
	
jQuery.noConflict()(function($){
$(document).ready(function() {
	$('ul#filter a').click(function() {
		$(this).css('outline','none');
		$('ul#filter .current').removeClass('current');
		$(this).parent().addClass('current');
		
		var filterVal = $(this).text().toLowerCase().replace(' ','-');
				
		if(filterVal == 'all') {
			$('ul#portfolio li.hidden').fadeIn('slow').removeClass('hidden');
		} else {
			
			$('ul#portfolio li').each(function() {
				if(!$(this).hasClass(filterVal)) {
					$(this).fadeOut('normal').addClass('hidden');
				} else {
					$(this).fadeIn('slow').removeClass('hidden');
				}
			});
		}
		
		return false;
	});
});
});

jQuery.noConflict()(function($){
$(document).ready(function() {
	$('ul#filter-sidebar a').click(function() {
		$(this).css('outline','none');
		$('ul#filter-sidebar .current').removeClass('current');
		$(this).parent().addClass('current');
		
		var filterVal = $(this).text().toLowerCase().replace(' ','-');
				
		if(filterVal == 'all') {
			$('ul#portfolio li.hidden').fadeIn('slow').removeClass('hidden');
		} else {
			
			$('ul#portfolio li').each(function() {
				if(!$(this).hasClass(filterVal)) {
					$(this).fadeOut('normal').addClass('hidden');
				} else {
					$(this).fadeIn('slow').removeClass('hidden');
				}
			});
		}
		
		return false;
	});
});
});	


jQuery.noConflict()(function($){
	$('#sti-menu').iconmenu({
		animMouseenter	: {
			'mText' : {speed : 400, easing : 'easeOutExpo', delay : 140, dir : -1},
			'sText' : {speed : 400, easing : 'easeOutExpo', delay : 280, dir : -1},
			'icon'  : {speed : 400, easing : 'easeOutExpo', delay : 0, dir : -1}
		},
		animMouseleave	: {
			'mText' : {speed : 400, easing : 'easeInExpo', delay : 140, dir : -1},
			'sText' : {speed : 400, easing : 'easeInExpo', delay : 0, dir : -1},
			'icon'  : {speed : 400, easing : 'easeInExpo', delay : 280, dir : -1}
		}
	});
});



/***************************************************
			TABLES
***************************************************/
jQuery.noConflict()(function($){
	$("table").tablesorter({debug: false});
});
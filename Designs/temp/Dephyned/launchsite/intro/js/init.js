

function initKlif() {

$('.top-block a.to-sta').hover(function(){
	$('.select-type').addClass('rot-left');
	},function(){
		
	$('.select-type').removeClass('rot-left');	
		});
	$('.top-block a.to-video').hover(function(){
	$('.select-type').addClass('rot-right');
	},function(){
		
	$('.select-type').removeClass('rot-right');	
		});	
		
		
		
};


$(document).ready(function(){
	initKlif();
});	
// JpreLoader ------------------
	$('#wrapper').jpreLoader({
		loaderVPos: '50%',
		autoClose: true,
	}, 
	function() {
		var al = {queue:false,duration:200,easing:"easeInOutQuad"};	
		$('#wrapper').animate({"opacity":'1'},{queue:false,duration:700,easing:"easeInOutQuad"});		

		$('.about-link').animate({'margin-left':'0'},al);
		$('.contact-link').animate({'margin-right':'0'},al);
		setTimeout( function(){		
			$('.fistslide').removeClass('bc');
		},900);
	});

function initKlif() {

	"use strict";

//------------------------------init swiper-----------------------

	var mySwiper = new Swiper('.swiper-container',{
		initialSlide:1,

	});

	$('.arrow-left').on('click', function(e){
    	e.preventDefault()
   		mySwiper.swipePrev()
  	});
	
	$('.arrow-right').on('click', function(e){
		e.preventDefault()
		mySwiper.swipeNext()
	});
	
//------------------------------init countdown-----------------------

	$('.countdown').downCount({
		date: '09/12/2014 12:00:00', // your date
		offset: +10
	});	
	
// functions ------------------	

	function showprogresss() { 
		$(".show-progress").removeClass('isDown');
		$('.fade').addClass('bc');
			setTimeout( function(){	
				$('.progress-holder').fadeIn(1000);		
			},650);				    
			$({value: 0}).animate({value: $('.num2').attr("name")}, {
				duration: 2000,
				easing:'swing',
				step: function() 
					{
						$('.num2').val(Math.ceil(this.value)).trigger('change');
					}
			})
	}
	
	function hideprogresss() { 
		$(".show-progress").addClass('isDown');
		$('.progress-holder').fadeOut(1000);	
		setTimeout( function(){	
			$('.fade').removeClass('bc');	
		},650);				    
	}
	function showform() { 
		$('.fade2').addClass('bc2');
		setTimeout( function(){	
			$('.contact-form').fadeIn(500);			
		},650);		   
	}
	function hideform() { 
		$('.contact-form').fadeOut(500);
		setTimeout( function(){	
			$('.fade2').removeClass('bc2');		
		},650);				   
	}	
	
	$('.lanch-form').click(function(){showform();});
	$('.close-form').click(function(){hideform();});
	
	$('.num').knob();
	$(".show-progress").click( function(){
		$(this).toggleClass('but-rotade');
		if ($(this).hasClass("isDown") ) {
			showprogresss();			
		} else {
			hideprogresss();
		}	
		return false;
	});
	
	
// Subscribe   ----------------------------------------

	$('.subscriptionForm').submit(function(){		
		var email = $('#subscriptionForm').val();
		$.ajax({
			url:'php/subscription.php',
			type :'POST',
			dataType:'json',
			data: {'email': email},success: function(data){
				if(data.error){
					$('#error').fadeIn()
				}
				else{
					$('#success').fadeIn();
					$("#error").hide();}
				}
			});
		return false
	});
	
	$('#subscriptionForm').focus(function(){
		$('#error').fadeOut();
		$('#success').fadeOut();	
	});
	
	$('#subscriptionForm').keydown(function(){	
		$('#error').fadeOut();
		$('#success').fadeOut();		
	});		
};

// Contact submit  ----------------------------------------

	$("#submit_btn").click(function(){		
		var user_name=$('input[name=name]').val();
		var user_email=$('input[name=email]').val();
		var user_message=$('textarea[name=message]').val();
		var proceed=true;
			if(user_name==""){
				$('input[name=name]').css('border','1px solid #c33');
				proceed=false
			}
			if(user_email==""){
				$('input[name=email]').css('border','1px solid #c33');
				proceed=false
			}
			if(user_message==""){
				$('textarea[name=message]').css('border','1px solid #c33');
				proceed=false
			}
			if(proceed){
				post_data={'userName':user_name,'userEmail':user_email,'userMessage':user_message};
				$.post('php/contact_me.php',
				post_data,
				function(data){
					$("#result").hide().html('<div class="success">'+data+'</div>').fadeIn(500);
					$('#contact_form input').val('');
					$('#contact_form textarea').val('')}).fail(
						function(err){
							$("#result").hide().html('<div class="error">'+err.statusText+'</div>').fadeIn(1500)
					});
			}
	});
	
	$("#contact_form input, #contact_form textarea").keyup(function(){		
			$("#contact_form input, #contact_form textarea").css('border','1px solid #101011');
			$("#result").fadeOut(1500)			
	});	

$(document).ready(function(){
	initKlif();
});	
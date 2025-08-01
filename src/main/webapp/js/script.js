/**
 * 
 */

var layer = function() { $('#navi').toggleClass("layer"); }



$(function() {
	$('#hamburger').on('click', function() {
		$('#hamburger').toggleClass("open");
		$('#header-menu').toggleClass("open");
		$('.navi-close').toggleClass("open");

		setTimeout(layer, 80);
	});

	$('.navi-close').on('click', function() {
		$('#hamburger').click();
	});
});

$(function() {
	$('.cheese').on('click', function() {
		$('.cheese-detail').toggleClass("open");
		$('.cheese-detail').slideToggle();
	});
	
	$('.tomato').on('click', function() {
		$('.tomato-detail').toggleClass("open");
		$('.tomato-detail').slideToggle();
	});
	
	$('.lettuce').on('click', function() {
		$('.lettuce-detail').toggleClass("open");
		$('.lettuce-detail').slideToggle();
	});
	
	$('.ketchup').on('click', function() {
		$('.ketchup-detail').toggleClass("open");
		$('.ketchup-detail').slideToggle();
	});
	
	$('.egg').on('click', function() {
		$('.egg-detail').toggleClass("open");
		$('.egg-detail').slideToggle();
	});
	
	$('.patty').on('click', function() {
		$('.patty-detail').toggleClass("open");
		$('.patty-detail').slideToggle();
	});
});







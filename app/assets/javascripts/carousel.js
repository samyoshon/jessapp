$(document).on('turbolinks:load', function() {
// carousel js
	$('.scroller').slick({
		infinite: true,
		arrows: true,
		slidesToShow: 1,
		slidesToScroll: 1,
		dots: true
	});

	$('.slider-for').slick({
		slidesToShow: 1,
		slidesToScroll: 1,
		arrows: true,
		fade: true,
		asNavFor: '.slider-nav'
	});
	
	$('.slider-nav').slick({
		slidesToShow: 6,
		slidesToScroll: 1,
		asNavFor: '.slider-for',
		dots: true,
		centerMode: false,
		focusOnSelect: true
	});
});

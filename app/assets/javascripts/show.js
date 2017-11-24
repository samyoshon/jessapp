$(document).on('turbolinks:load', function() {
    $('.btn-contact-info').click(function() {
		console.log('works');
		$('.show-contact-info').toggleClass('show-contact-info-hidden');
		$(this).hide();
	});

	$('.product-container').hover(function() {
		$('.slick-arrow').show();
	});

	$('#form-phone-checkbox').change(function() {
		$('.form-phone-form').toggle();
	});
});
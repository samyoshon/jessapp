$(document).on('turbolinks:load', function() {
	$('.brand-image-container').hover(function() {
		$(this).children('.brand-logo-container-logo').hide();
		$(this).children('.brand-logo-container-product').show();
	}, function() {
		$(this).children('.brand-logo-container-logo').show();
		$(this).children('.brand-logo-container-product').hide();
	});
});
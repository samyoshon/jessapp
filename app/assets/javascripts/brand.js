$(document).on('turbolinks:load', function() {
	$('.hover-container').hover(function() {
		$(this).children('.brand-logo-container-first').hide();
		$(this).children('.brand-logo-container-second').show();
	}, function() {
		$(this).children('.brand-logo-container-first').show();
		$(this).children('.brand-logo-container-second').hide();
	});
});
$(function(){

	$('.drowpdown-toggle').dropdown()

	$(document).on('mouseenter', '.thumbnail_object', function(){
		var link = $(this).find('.pic-username')
		link.removeClass('hide-thumbnail')
	});

	$(document).on('mouseleave', '.thumbnail_object', function(){
		$(this).find('.pic-username').addClass('hide-thumbnail')
	});


});	
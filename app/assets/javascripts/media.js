$(function(){

	$(document).on('mouseenter', '.thumbnail_object', function(){
		var link = $(this).find('.pic-username')
		link.removeClass('hide-thumbnail')
		// link.on('mouseenter', function(){
		// 	$(this).css('visibility', 'visible')
		// });
	});

	$(document).on('mouseleave', '.thumbnail_object', function(){
		$(this).find('.pic-username').addClass('hide-thumbnail')
	});


});	
$(function(){

	$(document).on('click', '.dropdown', function(event){
		event.preventDefault();
		console.log($(this).find('.submenu'))
	})
})
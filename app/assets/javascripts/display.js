$(document).ready(function(){

	//Display media without refreshing the pages
	$(document).on('click', '.popular-button', function(event){
		event.preventDefault();

		console.log("click")

		$.ajax({
			url: 'popular',
			type: 'get',

				success: function(serverResponse){
					$('.container').html(serverResponse);

				}
		});
	});

});






// console.log(route)
// 		var save_url = $(this).attr('id');
// 		$.ajax({
// 	        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
// 	        url: route,
// 	        data: 'media_url=' + save_url,
// 		    type: "post",
// 			dataType: "json",

// 	        success: function(serverResponse){
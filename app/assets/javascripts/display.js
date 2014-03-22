$(document).ready(function(){

	//Display Popular media without refreshing the pages
	$(document).on('click', '.popular-button', function(event){
		event.preventDefault();

		$.ajax({
			url: 'popular',
			type: 'get',
				success: function(serverResponse){
					$('.container').html(serverResponse);
				}
		});
	});

	//Display Search media without refreshing page
	$(document).on('submit', '.search-form', function(event){
		event.preventDefault();

		$.ajax({
			url: 'search',
			data: $('form').serialize(),
			type: 'get', 
				success: function(serverResponse){
					$('.container').html(serverResponse);
				}
		})
	});

	//Display similar media without refreshing page
	$(document).on('click', '.sim-media', function(event){
		event.preventDefault();

		$.ajax({
			url: 'search',
			data: {var search_data: $(this).text()},
			type: 'get',
				success: function(serverResponse){
					$('.container').html(serverResponse);
				}
		})
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
$(document).ready(function(){
	//Display Popular media without refreshing the pages
	$(document).on('click', '.popular-button', function(event){
		event.preventDefault();

		$.ajax({
			url: '/popular',
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
			url: '/search',
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
		var data = {
			search_data: $(this).text()
		}

		$.ajax({
			url: '/search',
			data: data,
			type: 'get',
				success: function(serverResponse){
					$('.container').html(serverResponse);
				}
		})
	});

	//Display recent media without refreshing the page
	$(document).on('click', '.recent-media-button', function(event){
		event.preventDefault();

		$.ajax({
			url: '/recently_created_media',
			type: 'get',
				success: function(serverResponse){
					$('.container').html(serverResponse);
				}
		});
	});

	//Display recent media without refreshing the page
	$(document).on('click', '.view-selected-button', function(event){
		event.preventDefault();

		$.ajax({
			url: '/view_selected_media',
			type: 'get',
				success: function(serverResponse){
					$('.container').html(serverResponse);
				}
		});
	});
});




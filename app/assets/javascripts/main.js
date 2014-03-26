function bindEvents() {
	//bind fancybox to images and videos
	$("a[href$='.mp4'], a[href$='.jpg'],a[href$='.png'],a[href$='.gif']").attr('rel', 'gallery').fancybox({
		 beforeShow : function(){
		 	this.title = $(this.element).data("caption");
		}
	});

	//make the navbar dropdown work
	$('.drowpdown-toggle').dropdown()

	//when you click a video thumbnail, make it appear in a lightbox
	$('.video_thumbnail').on('click', function(){
	  var save_url = $(this).attr('id');

	  //make the video x% of the window width and height
	  var width = (50 / 100) * $(window).width();
	  var height = (50 / 100) * $(window).height();
			$.fancybox({
			    'width'        : '75%',
			    'height'       : '75%',
			    'autoScale'    : true,
			    'transitionIn' : 'none',
			    'transitionOut': 'none',
			    'type'         : 'iframe',
			    'href'         : 'this.href',
			    'content'	   : "<video autoplay id=\"example_video_1\" class=\"video-js vjs-default-skin\" controls preload=\"none\" width=\"" + width + "\" height=\"" + height + "\" data-setup='{'autoplay': true}'><source src=\" " + save_url + "\" type='video/mp4' /><track kind=\"captions\" src=\"demo.captions.vtt\" srclang=\"en\" label=\"English\"></track><!-- Tracks need an ending tag thanks to IE9 --><track kind=\"subtitles\" src=\"demo.captions.vtt\" srclang=\"en\" label=\"English\"></track><!-- Tracks need an ending tag thanks to IE9 --></video>"
		    });
	});

	//ensure that an images checkbox will always remain visible if checked,
	//and appear on mouse over if unchecked / dissapear on mouseoff if unchecked
	//also ensure that usernames/tags display over media when moused over
	$('.thumbnail_object').on({
		mouseover: function(){
			var inputDiv = $(this).find('input');
			//when you hover over a thumbnail, reveal the uploaders instagram username
			$(this).find('.pic-username').removeClass('hide-thumbnail');

			//when you hover over a thumbnail, reveal the tags associated with the image
			$(this).find('.tags').removeClass('hide-thumbnail');

			if (inputDiv.is(':checked') != true) {
				inputDiv.addClass('show-thumbnail');
				inputDiv.removeClass('hide-thumbnail');
			}
		},mouseout: function(){
			var inputDiv = $(this).find('input');
			//when you hover off of a thumbnail, hide the uploaders instagram username
			$(this).find('.pic-username').addClass('hide-thumbnail');

			//when you hover over a thumbnail, reveal the tags associated with the image
			$(this).find('.tags').addClass('hide-thumbnail');

			if (inputDiv.is(':checked') != true) {
				inputDiv.removeClass('show-thumbnail');
				inputDiv.addClass('hide-thumbnail');
			}
		}
	});

	//on the page where you view the users instagram media
	//when you click on the more results function, go to a route to grab the next set
	//of images, and then replace the search_results content with the updated media set
	$('.more_user_results').on('click',function(e) {
		e.preventDefault();
		console.log('he');
		route = 'event_media_pagination';
		var user_id = $(this).attr('id');

		$.ajax({
	        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
	        url: route,
	        data: {'user_id' : user_id},
		    type: "get",

	        success: function(serverResponse){
	        	$(".display_results").html(serverResponse);
	        	bindEvents();
	    	}
		});
	});

	//on any page with pagination with the exception of the user pagination results
	//when you click on the more results function (this link is on many pages...), go to a route to grab the next set
	//of images, and then replace the search_results content with the updated media set
	$('.more_results').on('click',function(e) {
		e.preventDefault();
		console.log("click");
		var route = 'paginate_results';

		$.ajax({
	        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
	        url: route,
		    	type: "get",

	        success: function(serverResponse){
	        	$('.display_results').html(serverResponse);
	        	bindEvents();
	    	}
		});
	});

	//when you check an image to be saved,
	//update its class to ensure that it won't
	//become hidden when you mouse off of the thumbnail.
	//Alternatively, ensure that it doesn't hvae this class if you're unchecking it.
	//Then go to a ruby method which saves the selected media into the database
	$('.selection_checkbox').on('click',function() {
		var route = undefined;
		var inputDiv = $(this).find('input');
		route = undefined;
		if($(this).is(':checked')){
			route = 'save_media_to_session';
			inputDiv.addClass('show-check-thumbnail');
			inputDiv.removeClass('show-thumbnail');
			inputDiv.removeClass('hide-thumbnail');
		}
		else {
		  route = 'remove_media_from_session';
			inputDiv.removeClass('show-check-thumbnail');
			inputDiv.removeClass('hide-thumbnail');
			inputDiv.addClass('show-thumbnail');
		}

		var save_url = $(this).attr('id');
		var thumbnail = $(this).parent().find('img').css('background-image');
		if (thumbnail === "none")
			thumbnail = save_url;
		else
			thumbnail = thumbnail.slice(4, -1);

		$.ajax({
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      url: route,
			data: {
				'media' : save_url,
				'media_thumbnail' : thumbnail
			},
    	type: "post",
			dataType: "json"
		}).always(function(serverResponse){
			console.log(serverResponse)
			$(".view-selected-button").html("View Selected Media (" + serverResponse.count + ")");
		});
	});
};

//on document load, make sure everything is bound
$(function(){
	bindEvents();
});

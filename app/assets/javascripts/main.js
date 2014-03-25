function bindEvents() {
	$("a[href$='.mp4'], a[href$='.jpg'],a[href$='.png'],a[href$='.gif']").attr('rel', 'gallery').fancybox();

	$('.drowpdown-toggle').dropdown()

	$(document).on('mouseenter', '.thumbnail_object', function(){
		var link = $(this).find('.pic-username')
		link.removeClass('hide-thumbnail')
	});

	$(document).on('mouseleave', '.thumbnail_object', function(){
		$(this).find('.pic-username').addClass('hide-thumbnail')
	});

	$('.pick-username').on('click', function(e){
		e.preventDefault;
		console.log('yo');
		// $(this).find('.pic-username').addClass('hide-thumbnail')
		console.log($('pic-username').attr('id'));
	});	

	$('.more_user_results').on('click',function(e) {
		e.preventDefault();
		console.log( "here")
		route = 'event_media_pagination';

		var user_id = 1;
		var page = 1;

		$.ajax({
	        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
	        url: route,
	        data: {'user_id' : user_id, 'page' : page},
    		type: "post",
			dataType: "json",
		    type: "get",

	        success: function(serverResponse){
	        	console.log(serverResponse);
	        	$(".display_results").html(serverResponse);
	        	$(document).unbind(); // for all events
	        	bindEvents();
	    	}
		});
	});

	$('.video_thumbnail').on('click', function(){
	  var save_url = $(this).attr('id');
			$.fancybox({
			    'width'        : '75%',
			    'height'       : '75%',
			    'autoScale'    : true,
			    'transitionIn' : 'none',
			    'transitionOut': 'none',
			    'type'         : 'iframe',
			    'href'         : 'this.href',
			    'content'			 : "<video autoplay id=\"example_video_1\" class=\"video-js vjs-default-skin\" controls preload=\"none\" width=\"640\" height=\"264\" data-setup='{'autoplay': true}'><source src=\" " + save_url + "\" type='video/mp4' /><track kind=\"captions\" src=\"demo.captions.vtt\" srclang=\"en\" label=\"English\"></track><!-- Tracks need an ending tag thanks to IE9 --><track kind=\"subtitles\" src=\"demo.captions.vtt\" srclang=\"en\" label=\"English\"></track><!-- Tracks need an ending tag thanks to IE9 --></video>"
		    });
	});

	//the next three functions ensure that an images checkbox will
	//always remain visible if checked, and appear on mouse over if
	//unchecked / dissapear on mouseoff if unchecked
	$('.thumbnail_object').on({
		mouseover: function(){
			if ($(this).find('input').is(':checked') != true) {
				$(this).find('input').addClass('show-thumbnail');
				$(this).find('input').removeClass('hide-thumbnail');
			}
		},
		mouseout: function(){
			if ($(this).find('input').is(':checked') != true) {
				$(this).find('input').removeClass('show-thumbnail');
				$(this).find('input').addClass('hide-thumbnail');
			}
		}
	});


	$('.more_results').on('click',function(e) {
		e.preventDefault();
		route = 'more_results';

		$.ajax({
	        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
	        url: route,
		    type: "get",

	        success: function(serverResponse){
	        	console.log(serverResponse);
	        	$(".display_results").html(serverResponse);
	        	// $(".search_header").html(header);
	        	bindEvents();

	    	}
		});
	});


	$('.selection_checkbox').on('click',function() {
		route = undefined;
		if($(this).is(':checked')){
			route = 'save_media_to_session';
			$(this).find('input').addClass('show-check-thumbnail');
			$(this).find('input').removeClass('show-thumbnail');
			$(this).find('input').removeClass('hide-thumbnail');
		}
		else {
		  route = 'remove_media_from_session';
			$(this).find('input').removeClass('show-check-thumbnail');
			$(this).find('input').removeClass('hide-thumbnail');
			$(this).find('input').addClass('show-thumbnail');
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
				data: {'media' : save_url,
  						 'media_thumbnail' : thumbnail },
		    	type: "post",
					dataType: "json"

		})
			.always(function(serverResponse){
			$(".view-selected-button").html("View Selected Media (" + serverResponse.count + ")");
			})
	});
}

$(function(){
	bindEvents();
});

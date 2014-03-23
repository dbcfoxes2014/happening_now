//we must call by the document because turbo links only updates the document handle
$(document).ready(function() {

	$(document).on('click', ".video_thumbnail", function(){
	  var save_url = $(this).attr('id');
			$.fancybox({
			    'width'             : '75%',
			    'height'            : '75%',
			    'autoScale'         : true,`
			    'transitionIn'      : 'none',
			    'transitionOut'     : 'none',
			    'type'              : 'iframe',
			    'href'              : 'this.href',
			    'content'			: "<video autoplay id=\"example_video_1\" class=\"video-js vjs-default-skin\" controls preload=\"none\" width=\"640\" height=\"264\" data-setup='{'autoplay': true}'><source src=\" " + save_url + "\" type='video/mp4' /><track kind=\"captions\" src=\"demo.captions.vtt\" srclang=\"en\" label=\"English\"></track><!-- Tracks need an ending tag thanks to IE9 --><track kind=\"subtitles\" src=\"demo.captions.vtt\" srclang=\"en\" label=\"English\"></track><!-- Tracks need an ending tag thanks to IE9 --></video>"
		    });
	});

	//the next three functions ensure that an images checkbox will
	//always remain visible if checked, and appear on mouse over if
	//unchecked / dissapear on mouseoff if unchecked
	$(document).on('mouseover', ".thumbnail_object", function(){
		if ($(this).find('input').is(':checked') != true) {
			$(this).find('input').addClass('show-thumbnail');
			$(this).find('input').removeClass('hide-thumbnail');
		}
	});

	$(document).on('mouseout', ".thumbnail_object", function(){
		if ($(this).find('input').is(':checked') != true) {
			$(this).find('input').removeClass('show-thumbnail');
			$(this).find('input').addClass('hide-thumbnail');
		}
	});

	$(document).on('click', '.selection_checkbox', function() {
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
		$.ajax({
	        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
	        url: route,
	        data: 'media_url=' + save_url,
		    type: "post",
			dataType: "json",

	        success: function(serverResponse){
	        }
		});
	});
});

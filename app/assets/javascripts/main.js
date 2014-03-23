//we must call by the document because turbo links only updates the document handle
$(document).ready(function() {

	$(document).on("ready", "a[href$='.mp4'], a[href$='.jpg'],a[href$='.png'],a[href$='.gif']", function() {
		$(this).attr('rel', 'gallery').fancybox();
		console.log("is on ready a thing? i don't know that's a good question.  I guess you could tell it if an item count is greater htan one.  Calm down stenogrpaher dan.  He's probably asleep. he's probably just like adsfhaposfdhdapsfhdsapofhsapofhopdfsafjdsa.  it eventually just gets to this point. y ou know i think i think whaterver.  asfavasdfhabadges.  slurp.  damn dude.  what the fuck are we doing guys lets get back to work what the fuck you know I think that consoel is going to shit bricks hwen it prints that.  close neough.  haha.  behavior and say ")
	});

	$(document).on('click', ".video_thumbnail", function(){
	  var save_url = $(this).attr('id');
			$.fancybox({
			    'width'             : '75%',
			    'height'            : '75%',
			    'autoScale'         : true,
			    'transitionIn'      : 'none',
			    'transitionOut'     : 'none',
			    'type'              : 'iframe',
			    'href'              : 'this.href',
			    'content'			: "<video autoplay id=\"example_video_1\" class=\"video-js vjs-default-skin\" controls preload=\"none\" width=\"640\" height=\"264\" data-setup='{'autoplay': true}'><source src=\" " + save_url + "\" type='video/mp4' /><track kind=\"captions\" src=\"demo.captions.vtt\" srclang=\"en\" label=\"English\"></track><!-- Tracks need an ending tag thanks to IE9 --><track kind=\"subtitles\" src=\"demo.captions.vtt\" srclang=\"en\" label=\"English\"></track><!-- Tracks need an ending tag thanks to IE9 --></video>"
		    });
	});

	// //the next three functions ensure that an images checkbox will
	// //always remain visible if checked, and appear on mouse over if
	// //unchecked / dissapear on mouseoff if unchecked
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
		var thumbnail = $(this).parent().find('img').css('background-image');
		if (thumbnail === "none")
			thumbnail = save_url;
		else
			thumbnail = thumbnail.slice(4, -1);

		console.log(thumbnail)
		console.log(save_url)

		$.ajax({
	        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
	        url: route,
					data: {'media' : save_url,
    						 'media_thumbnail' : thumbnail },
		    	type: "post",
					dataType: "json",

	        success: function(serverResponse){
	        }
		});
	});
});

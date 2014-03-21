$(document).ready(function() {
	$("a[href$='.mp4'], a[href$='.jpg'],a[href$='.png'],a[href$='.gif']").attr('rel', 'gallery').fancybox();//makes every image link on the site fancy

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


	$(document).on('mouseover', ".thumbnail_object", function(){
		$(this).find('input').removeClass('hide-thumbnail');
		$(this).find('input').addClass('show-thumbnail');    
	});

	$(document).on('mouseout', ".thumbnail_object", function(){		
		$(this).find('input').removeClass('show-thumbnail');
		$(this).find('input').addClass('hide-thumbnail');
	});

	$(document).on('click', '.selection_checkbox', function() {
		var save_url = $(this).attr('id');
		$.ajax({
	        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
	        url: 'save_media_to_session',
	        data: 'media_url=' + save_url,
		    type: "post",
			dataType: "json",

	        success: function(serverResponse){
	          console.log("good");    
		    }
		});
	});
});
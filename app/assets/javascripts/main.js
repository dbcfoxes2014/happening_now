$(document).ready(function() {

	$("a[href$='.mp4'], a[href$='.jpg'],a[href$='.png'],a[href$='.gif']").attr('rel', 'gallery').fancybox();//makes every image link on the site fancy
		
	$(".video-thumbnail").on('click',function(){
	  // var save_url = $(this).attr('id');
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
});

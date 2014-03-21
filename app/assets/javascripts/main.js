$(document).ready(function() {
	// $("a.fancybox").fancybox();

	$("a[href$='.mp4'], a[href$='.jpg'],a[href$='.png'],a[href$='.gif']").attr('rel', 'gallery').fancybox();//makes every image link on the site fancy
		
	$(".video-thumbnail").on('click',function(){
	  var save_url = $(this).attr('id');
  //     $.ajax({
  //       beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
  //       url: 'save_video_url',
  //       data: save_url,
	 //    type: "post",
		// dataType: "json",

  //       success: function(serverResponse){
  //         console.log("good");    
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
	      // }
		// });
	});
});
//"<video id='example_video_1' class='video-js' width='100%' height='95%' controls='controls' preload='auto' autoplay><source src="+save_url+" type='video/mp4'; codecs='avc1.42E01E, mp4a.40.2'/>
  //  	</object>
  	//	</video>"
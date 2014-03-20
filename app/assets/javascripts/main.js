$(document).ready(function() {
	// $("a.fancybox").fancybox();

	$("a[href$='.mp4'], a[href$='.jpg'],a[href$='.png'],a[href$='.gif']").attr('rel', 'gallery').fancybox();//makes every image link on the site fancy!
	$(".fancybox").attr('rel', 'gallery').fancybox();
	$("#video-thumbnail").on('click',function(){
	    $.fancybox({
	    'width'             : '75%',
	    'height'            : '75%',
	    'autoScale'         : true,
	    'transitionIn'      : 'none',
	    'transitionOut'     : 'none',
	    'type'              : 'iframe',
	    'href'              : 'video.html'
	    });
	});
});


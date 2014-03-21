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

	$(document).on('mouseover', ".video_thumbnail", function(){
		console.log('on');
	  	var checkbox = document.createElement('input');
		checkbox.type = "checkbox";
		checkbox.name = "name";
		checkbox.value = "value";
		checkbox.id = "id";
		var position = $(this).position();
		checkbox.style.cssText = 'position:absolute;top:' + position.top + ';left:' + position.left;
		console.log(position);
		console.log($(this).position());

		var label = document.createElement('label')
		label.htmlFor = "id";
		label.appendChild(document.createTextNode('Select for compilation'));

		var position = $(this).position();

//		label.style.cssText = 'position:absolute;top:' + position.top + ';left:' + position.left + ';width:200px;height:200px;-moz-border-radius:100px;border:1px  solid #ddd;-moz-box-shadow: 0px 0px 8px  #fff;';
		
		$('.target').append(checkbox);
//		$('.target').append(label);
	});

	$(document).on('mouseout', ".video_thumbnail", function(){
	  	console.log("off");

	});
	
});
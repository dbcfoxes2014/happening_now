var trackPallet = new Array();
var clipID = 0;
var timelineLength = 60.0;

var RenderTime = function(currentTime){
    var miliSec = String(currentTime - Math.floor(currentTime)).slice(2,5);
    var totalSec = Math.round(currentTime);
    var minutes = parseInt( totalSec / 60 ) % 60;
    var seconds = totalSec % 60;

    return (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds  < 10 ? "0" + seconds : seconds)+":"+miliSec;
};

var RenderVideo = function(movie_array){
  console.log("sending ajax request on render");
  //ask for a slot to render in
  $.ajax({
    type: "GET",
    url: "/editor/renderIO",
    //context: document.body,
    data: {query: 'slotAvaliable'}
  }).done(function(responce) {
    // console.log("Mapping: "+movie_array[0].url+" to: "+$.map(movie_array, function(clip) {
    //     return clip.url
    // }));
    //tell the avaliable slot what urls we need to copy
    $.ajax({
      type: "POST",
      url: "/editor/renderIO",
      data: {
        command: 'grabVideos',
        // urls: [
        //  'http://distilleryimage7.s3.amazonaws.com/ccccaaeeb11811e3ab9d123c21c1539b_101.mp4',
        //  'http://distilleryimage4.s3.amazonaws.com/b399a0a8b11411e3a2cf1215b493f9ac_101.mp4',
        //  'http://distilleryimage5.s3.amazonaws.com/52f0c9eeb10e11e3a27f0e1c4bab99dd_101.mp4',
        //  'http://distilleryimage6.s3.amazonaws.com/97714a5cb12d11e39b761240926e6356_101.mp4',
        //  'http://distilleryimage10.s3.amazonaws.com/2604628cb12311e3a0c81236548e9e2a_101.mp4',
        //  'http://distilleryimage5.s3.amazonaws.com/129710feb13311e3aaf30e0373b3d96d_101.mp4'
        // ]
        urls: $.map(movie_array, function(clip) {
            return clip.url
        })
      }
    }).done(function(responce){
      //tell the slot to start the render now the URL's are copied
      $.ajax({
        type: "POST",
        url: "/editor/renderIO",
        data: {
          command: 'startVideoRender'
        }
      }).done(function(responce){
        //tell the user the render is done (we need background jobs)
        alert('Your render is done!');
      });
    });
    console.log("AJAX responce done: "+responce.status+responce.slot);
  });
};

var RenderSlideshow = function(movie_array){
  console.log("sending ajax request on render");
  //ask for a slot to render in
  $.ajax({
    type: "GET",
    url: "/editor/renderIO",
    //context: document.body,
    data: {query: 'slotAvaliable'}
  }).done(function(responce) {
    // console.log("Mapping: "+movie_array[0].url+" to: "+$.map(movie_array, function(clip) {
    //     return clip.url
    // }));
    //tell the avaliable slot what urls we need to copy
    $.ajax({
      type: "POST",
      url: "/editor/renderIO",
      data: {
        command: 'grabPhotos',
        urls: $.map(movie_array, function(clip) {
            return clip.url
        })
      }
    }).done(function(responce){
      //tell the slot to start the render now the URL's are copied
      $.ajax({
        type: "POST",
        url: "/editor/renderIO",
        data: {
          command: 'startPhotoRender'
        }
      }).done(function(responce){
        //tell the user the render is done (we need background jobs)
        alert('Your render is done!');
      });
    });
    console.log("AJAX responce done: "+responce.status+responce.slot);
  });
};

var Track = function(e){
  this.clips = new Array();
};

var Clip = function(url,thumb,start,stop){
  this.url  = url; this.thumb = thumb;
  this.start=start;this.stop  = stop;

  //console.log(this.url+this.thumb+this.start+this.stop);
};
////////////////////////////////////////MOVIE STUDIO////////////////////////////////////////
var MovieStudio = function(){
  var trackOffset= $('#TrackWrapper').offset().left;
  var trackWidth = $('#TrackWrapper').width();
  //start the tracks up
  var TrackMain = new Track();
  // var TrackMain1 = new Track();
  // var TrackMain2 = new Track();
  // var TrackMerged= new Array;
  //resize handeling
  $(window).bind('resize', function () { trackWidth = $('#TrackWrapper').width(); });
  //debug load the movie pallet
  // $('#moviePallet div').load('/debug_grab_test_urls', function(){
  //   $('.palletThumb').each(function(){
  //     //add id to pallet clips
  //     $(this).attr('id',"palletClip_"+clipID);
  //     //add the id to the trackPallet array
  //     trackPallet.push("palletClip_"+clipID);
  //     clipID++;//incriment id
  //   }).on({
  //     mousedown: function() {
  //       $(this).css({
  //         position: 'absolute',
  //         zIndex: '400'
  //       });
  //     }, mouseup: function() {
  //       $(this).css({
  //         position: 'relative',
  //         left: '',//remove these elements by making them blank
  //         top: ''
  //       });
  //     }
  //   }).draggable({

  //   });
  // });

  $('#moviePallet .palletOverflow div').each(function(){
    //add id to pallet clips
    $(this).attr('id',"palletClip_"+clipID);
    //add the id to the trackPallet array
    trackPallet.push("palletClip_"+clipID);
    clipID++;//incriment id
  });

  $('.palletThumb').on({
    mousedown: function() {
      $(this).css({
        position: 'absolute',
        zIndex: '400'
      });
    }, mouseup: function() {
      $(this).css({
        position: 'relative',
        left: '',
        top: ''
      });
    }
  }).draggable({

  });

  $('#trackVideo2, #trackVideo1, #trackVideo0').droppable({
    accept: '.palletThumb',
    drop: function( event, ui ) {
      console.log("UI id: "+$(this).attr('id'));
      console.log("Drop Position Is: "+"<"+event.pageX+","+event.pageY+">");
      //clip = new Clip(ui.draggable.data('url'),"",0.0,15.0);
      //console.log(ui.draggable.data('url'));
      // switch($(this).attr('id')){
      //   case 'Track0':
      //     //console.log("Added clip to track 0");
      //     TrackMain0.clips.push(clip);
      //     break;
      //   case 'Track1':
      //     //console.log("Added clip to track 1");
      //     TrackMain1.clips.push(clip);
      //     break;
      //   case 'Track2':
      //     //console.log("Added clip to track 2");
      //     TrackMain2.clips.push(clip);
      //     break;
      // }


      //update the master track of all 3
      //TrackMerged = TrackMain0.clips.concat(TrackMain1.clips,TrackMain2.clips);
      console.log("Merged Tracks: "+TrackMain.clips);
      //$( this ).html( "Dropped!" );
      ui.draggable.remove();

      var clip_width= trackWidth * (15.0/timelineLength);
      var clip_leftX = event.pageX - trackOffset;
      var clip_rightX= clip_leftX+15.0;
      var clipObj = new Clip(
        ui.draggable.data('url'),
        ui.draggable.data('thumbnail'),
        (clip_leftX/trackWidth)*timelineLength,
        (clip_rightX/trackWidth)*timelineLength
      );

      $clip = $( "<div id='"+ui.draggable.attr('id')+"' class='timelineVideoClip'></div>" );
      $clip.data({'url':clipObj.url,'start':clipObj.start,'stop':clipObj.stop});
      $clip.html(
        "<div class='clipCrop'>"+
          "<div class='clipThumb' style='background: url("+clipObj.thumb+")'></div>"+
        "</div>"
      );
      $clip.draggable({//FIXME: make clips snap to each other
        snap: "#trackVideo2, #trackVideo1, #trackVideo0, "+$clip.id,
        snapMode: 'inner',
        stop: function(event, ui) {
          var clip_width= trackWidth * ($(this).width()/timelineLength);
          var clip_leftX = $(this).position().left - trackOffset;
          var clip_rightX= clip_leftX+$(this).width();
          clipObj.start = (clip_leftX/trackWidth)*timelineLength;
          clipObj.stop = (clip_rightX/trackWidth)*timelineLength;
        }
      }).resizable({
        handles:'e, w'
      });
      $clip.css({//mousePos - offset of time headers
        'left': clip_leftX + 'px',
        'width': clip_width + 'px'
      });

      $clip.appendTo( this );
      TrackMain.clips.push(clipObj);
    }
  });

  $('#editorTimeSlider').draggable({
    axis: "x",
    stop: function(event, ui) {
      console.log(ui.position.left)
      if(ui.position.left<trackOffset)
      {
        //alert('Return back');
        $("#editorTimeSlider,#editorTimeBar").animate({"left": "190px"}, 600);
        $('#editorTimeCurrent').text(RenderTime(0.0)+"000ms");
      }
      else if(ui.position.left>trackWidth-10.0)
      {
          $("#editorTimeSlider,#editorTimeBar").animate({"left": trackOffset+trackWidth-10.0+"px"}, 600);
          var currentTime=((ui.position.left-trackOffset)/trackWidth) * timelineLength;
          $('#editorTimeCurrent').text(RenderTime(currentTime)+"ms");
      }
    },
    drag: function(event,ui){
      $('#editorTimeBar').css({
        top: 50.0, left: ui.position.left
      });
      var currentTime=((ui.position.left-trackOffset)/trackWidth) * timelineLength;
      $('#editorTimeCurrent').text(RenderTime(currentTime)+"ms");
    }
  });

  $('#editorTools ul li span').on('click',function(e){
    //alert('Rendering that shit!');
    switch(e.target.id){
      case 'UI_render':
        RenderVideo(TrackMain.clips.sort(function(a,b){return a.start-b.start}));
        break;
      case 'UI_test':
        console.log(TrackMain.clips[0].stop);
        break;
    }
  });
  $('#editorTools').hover(function(){
    //enter
        $(this).animate({
            'bottom': '+=70px'
            }, "medium"
        );
    },function(){
    //leave
        $(this).animate({
            'bottom': '-=70px'
            }, "medium"
        );
    });
};
////////////////////////////////////////PHOTO STUDIO////////////////////////////////////////
var PhotoStudio = function(){
  var trackOffset= $('#TrackWrapper').offset().left;
  var trackWidth = $('#TrackWrapper').width();
  //start the tracks up
  var TrackMain = new Track();
  //resize handeling
  $(window).bind('resize', function () { trackWidth = $('#TrackWrapper').width(); });

  $('#moviePallet .palletOverflow div').each(function(){
    //add id to pallet clips
    $(this).attr('id',"palletClip_"+clipID);
    //add the id to the trackPallet array
    trackPallet.push("palletClip_"+clipID);
    clipID++;//incriment id
  });

  $('.palletThumb').on({
    mousedown: function() {
      $(this).css({
        position: 'absolute',
        zIndex: '400'
      });
    }, mouseup: function() {
      $(this).css({
        position: 'relative',
        left: '',
        top: ''
      });
    }
  }).draggable({

  });

  $('#trackPhotos').droppable({
    accept: '.palletThumb',
    drop: function( event, ui ) {
      ui.draggable.remove();

      var clip_width= trackWidth * (5.0/timelineLength);
      var clip_leftX = event.pageX - trackOffset;
      var clip_rightX= clip_leftX+5.0;
      var clipObj = new Clip(
        ui.draggable.data('url'),
        ui.draggable.data('thumbnail'),
        (clip_leftX/trackWidth)*timelineLength,
        (clip_rightX/trackWidth)*timelineLength
      );

      $clip = $( "<div id='"+ui.draggable.attr('id')+"' class='timelinePhotoClip'></div>" );
      $clip.data({'url':clipObj.url,'start':clipObj.start,'stop':clipObj.stop});
      $clip.html(
        "<div class='clipCrop'>"+
          "<div class='clipThumb' style='background: url("+clipObj.thumb+")'></div>"+
        "</div>"
      );
      $clip.draggable({
        snap: "#trackPhotos",
        snapMode: 'inner',
        stop: function(event, ui) {
          var clip_width= trackWidth * ($(this).width()/timelineLength);
          var clip_leftX = $(this).position().left - trackOffset;
          var clip_rightX= clip_leftX+$(this).width();
          clipObj.start = (clip_leftX/trackWidth)*timelineLength;
          clipObj.stop = (clip_rightX/trackWidth)*timelineLength;
        }
      });
      $clip.css({//mousePos - offset of time headers
        'left': clip_leftX + 'px',
        'width': clip_width + 'px'
      });

      $clip.appendTo( this );
      TrackMain.clips.push(clipObj);
    }
  });

  $('#editorTimeSlider').draggable({
    axis: "x",
    stop: function(event, ui) {
      console.log(ui.position.left)
      if(ui.position.left<trackOffset)
      {
        //alert('Return back');
        $("#editorTimeSlider,#editorTimeBar").animate({"left": "190px"}, 600);
        $('#editorTimeCurrent').text(RenderTime(0.0)+"000ms");
      }
      else if(ui.position.left>trackWidth-10.0)
      {
          $("#editorTimeSlider,#editorTimeBar").animate({"left": trackOffset+trackWidth-10.0+"px"}, 600);
          var currentTime=((ui.position.left-trackOffset)/trackWidth) * timelineLength;
          $('#editorTimeCurrent').text(RenderTime(currentTime)+"ms");
      }
    },
    drag: function(event,ui){
      $('#editorTimeBar').css({
        top: 50.0, left: ui.position.left
      });
      var currentTime=((ui.position.left-trackOffset)/trackWidth) * timelineLength;
      $('#editorTimeCurrent').text(RenderTime(currentTime)+"ms");
    }
  });

  $('#editorTools ul li span').on('click',function(e){
    //alert('Rendering that shit!');
    switch(e.target.id){
      case 'UI_render':
        RenderSlideshow(TrackMain.clips.sort(function(a,b){return a.start-b.start}));
        break;
      case 'UI_test':
        console.log(TrackMain.clips[0].stop);
        break;
    }
  });

  $('#editorTools').hover(function(){
    //enter
        $(this).animate({
            'bottom': '+=70px'
            }, "medium"
        );
    },function(){
    //leave
        $(this).animate({
            'bottom': '-=70px'
            }, "medium"
        );
    });
};


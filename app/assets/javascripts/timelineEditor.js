var trackPallet = new Array();
var clipID = 0;
var timelineLength = 60.0;

var drawTimeIncriments = function(containerDiv,timeRange){
  var headerWidth = containerDiv.width();


  var tickLargeCount = timeRange;
  //break the smaller ticks up into sets of 4 between the main ticks
  var tickSmallCount = tickLargeCount*5.0;
  var totalTicks = tickLargeCount + tickSmallCount;

  var margin = (headerWidth/totalTicks);

  //var margin = (totalTicks/headerWidth);

  for(var i=0;i<totalTicks;++i){
    if(i % 6 == 0)//every 6th tick
      $('<span class="timelineTickTall"></span>').css({
        left: ((i/totalTicks)*headerWidth)-1+'px'
      }).appendTo(containerDiv);
    else
      $('<span class="timelineTickShort"></span>').css({
        left: ((i/totalTicks)*headerWidth)-1+'px'
      }).appendTo(containerDiv);
  }
}

var drawProgressBar = function(dataperc){
  $('.progressbar').each(function(){
    var t = $(this),
      barperc = Math.round(dataperc*5.56);
    t.find('.bar').animate({width:barperc}, dataperc*25);

    var length = t.find('.bar').css('width'),
      perc = Math.round(parseInt(length)/5.56),
      labelpos = (parseInt(length)-2);
    t.find('.label').animate({left: labelpos-18+"px"},dataperc*25);
    t.find('.perc').text(perc+'%');
  });
};

var renderTime = function(currentTime){
    var miliSec = String(currentTime - Math.floor(currentTime)).slice(2,5);
    var totalSec = Math.round(currentTime);
    var minutes = parseInt( totalSec / 60 ) % 60;
    var seconds = totalSec % 60;

    return (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds  < 10 ? "0" + seconds : seconds)+":"+miliSec;
};

var renderVideo = function(movie_array,title){
  var statusDiv = $('#renderStatus');
  console.log("sending ajax request on render");
  //ask for a slot to render in
  $.ajax({
    type: "GET",
    url: "/editor/renderIO",
    data: {query: 'slotAvaliable'}
  }).done(function(response) {
    //tell the avaliable slot what urls we need to copy
    $.ajax({
      type: "POST",
      url: "/editor/renderIO",
      data: {
        command: 'grabVideos',
        urls: $.map(movie_array, function(clip) {
            return clip.url
        }),
        project_title: title
      }
    }).done(function(response){
      //check response from server for download status
      if(response.status == 'emptyList'){
        statusDiv.html('<p>Please add clips to your timeline.</p>');
        return;
      }
      var job_id = response.job_id;
      statusDiv.html(
        '<p>Copying files to server please wait...</p>'+
        '<div class="movingBallLine">'+
          '<div class="movingBallLineG"></div>'+
          '<div id="movingBallG_1" class="movingBallG"></div>'+
        '</div>'
      );
      //tell the slot to start the render now the URL's are copied
      //statusDiv.html('<p>Done copying, starting render...</p>');
      var intervalID = setInterval(function() {
          $.ajax({
            type: "get",
            url: "/editor/renderIO",
            data: {
              query: 'renderState',
              job_id: job_id
            }
          }).done(function(response){
            var para = $('#renderStatus').find('p');
            switch(response.status){
              case 'copying_videos':
                para.html("Copying files to server please wait...");
                break;
              case 'rendering_video':
                para.html("Rendering Video...");
                break;
              case 'done':
                para.html("Render Complete.");
                $('#renderStatus').find('div').remove();
                clearInterval(intervalID);
                break;
              default:
                para.html("Unknown Error.");
                clearInterval(intervalID);
            };
          });
        }, 3000);
      });
  });
};

var RenderSlideshow = function(movie_array,title){
  var statusDiv = $('#renderStatus');
  //ask for a slot to render in
  $.ajax({
    type: "GET",
    url: "/editor/renderIO",
    data: {query: 'slotAvaliable'}
  }).done(function(response) {
    //tell the avaliable slot what urls we need to copy
    $.ajax({
      type: "POST",
      url: "/editor/renderIO",
      data: {
        command: 'grabPhotos',
        urls: $.map(movie_array, function(clip) {
            return clip.url
        }),
        project_title: title
      }
    }).done(function(response){
      //check response from server for download status
      if(response.status == 'emptyList'){
        statusDiv.html('<p>Please add photos to your timeline.</p>');
        return;
      }
      var job_id = response.job_id;
      statusDiv.html(
        '<p>Copying files to server please wait...</p>'+
        '<div class="movingBallLine">'+
          '<div class="movingBallLineG"></div>'+
          '<div id="movingBallG_1" class="movingBallG"></div>'+
        '</div>'
      );
      //tell the slot to start the render now the URL's are copied
      //statusDiv.html('<p>Done copying, starting render...</p>');
      var intervalID = setInterval(function() {
          $.ajax({
            type: "get",
            url: "/editor/renderIO",
            data: {
              query: 'renderState',
              job_id: job_id
            }
          }).done(function(response){
            var para = $('#renderStatus').find('p');
            switch(response.status){
              case 'copying_photos':
                para.html("Copying files to server please wait...");
                break;
              case 'rendering_slideshow':
                para.html("Rendering Slideshow...");
                break;
              case 'done':
                para.html("Slideshow Complete.");
                $('#renderStatus').find('div').remove();
                clearInterval(intervalID);
                break;
              default:
                para.html("Unknown Error.");
                clearInterval(intervalID);
            };
          });
        }, 3000);
      });
  });
};

var Track = function(e){
  this.clips = new Array();
};

var Clip = function(url,thumb,start,stop,cropFront,cropEnd){
  this.url  = url; this.thumb = thumb;
  this.start=start;this.stop  = stop;
  this.cropFront=cropFront;
  this.cropEnd  =cropEnd;

  //console.log(this.url+this.thumb+this.start+this.stop);
};
////////////////////////////////////////MOVIE STUDIO////////////////////////////////////////
var MovieStudio = function(trackDiv){
  var trackOffset= trackDiv.offset().left;
  var trackWidth = trackDiv.width();
  //start the tracks up
  var TrackMain = new Track();
  //resize handeling
  $(window).bind('resize', function () { trackWidth = trackDiv.width(); });
  drawTimeIncriments($('#editorTimeRulerTrack'),60.0);
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

      var clip_width = trackWidth * (15.0/timelineLength);
      var clip_leftX = event.pageX - clip_width*0.5;
      var clip_rightX= clip_leftX+15.0;
      var clipObj = new Clip(
        ui.draggable.data('url'),
        ui.draggable.data('thumbnail'),
        (clip_leftX/trackWidth)*timelineLength,
        (clip_rightX/trackWidth)*timelineLength,
        0.0,
        0.0
      );

      $clip = $( "<div id='"+ui.draggable.attr('id')+"' class='timelineVideoClip'></div>" );
      $clip.data({'url':clipObj.url,'start':clipObj.start,'stop':clipObj.stop});
      $clip.html(
        "<div class='clipCrop'>"+
          "<div class='clipThumb' style='background: url("+clipObj.thumb+")'></div>"+
        "</div>"
      );
      $clip.draggable({//FIXME: make clips snap to each other, will write custom jquery method
        snap: "#trackVideo2, #trackVideo1, #trackVideo0, .timelineVideoClip",
        snapMode: 'inner',
        stop: function(event, ui) {
          clip_leftX = $(this).position().left - trackOffset;
          clip_rightX= clip_leftX+$(this).width();
          clipObj.start = (clip_leftX/trackWidth)*timelineLength;
          clipObj.stop = (clip_rightX/trackWidth)*timelineLength;
          //var clipTimeLength = clipObj.stop-clipObj.start;
          clip_width = $(this).width();
        }
      }).find('.clipCrop').resizable({
        handles:'e, w',
        stop: function(event,ui){
          var left_offset = $(this).position().left;
          //convert the offset to milliseconds
          clipObj.cropFront = (left_offset/trackWidth)*timelineLength;
          clipObj.cropEnd   = ((clip_width-$(this).width())/trackWidth)*timelineLength;
          console.log(clipObj.cropFront +" /// "+clipObj.cropEnd);
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
        $('#editorTimeCurrent span').text(renderTime(0.0)+"000ms");
      }
      else if(ui.position.left>trackWidth-10.0)
      {
          $("#editorTimeSlider,#editorTimeBar").animate({"left": trackOffset+trackWidth-10.0+"px"}, 600);
          var currentTime=((ui.position.left-trackOffset)/trackWidth) * timelineLength;
          $('#editorTimeCurrent span').text(renderTime(currentTime)+"ms");
      }
    },
    drag: function(event,ui){
      $('#editorTimeBar').css({
        top: 80.0+'px', left: ui.position.left
      });
      var currentTime=((ui.position.left-trackOffset)/trackWidth) * timelineLength;
      $('#editorTimeCurrent span').text(renderTime(currentTime)+"ms");
    }
  });

  $('#UI_render').on('click',function(e){
    var title = $('#UI_movieTitle').val();
    renderVideo(TrackMain.clips.sort(function(a,b){return a.start-b.start}),title);
  });
};
////////////////////////////////////////PHOTO STUDIO////////////////////////////////////////
var PhotoStudio = function(trackDiv){
  var trackOffset= trackDiv.offset().left;
  var trackWidth = trackDiv.width();
  //start the tracks up
  var TrackMain = new Track();
  //resize handeling
  $(window).bind('resize', function () { trackWidth = trackDiv.width(); });
  drawTimeIncriments($('#editorTimeRulerTrack'),60.0);

  var snapWidth = trackWidth * (5.0/timelineLength)-0.2;
  for(var i=0;i<(trackWidth/snapWidth)-1;++i){
    $('<div class="trackPhotoSnap"></div>').css({
      width: snapWidth+'px',
      float: 'left'
    }).appendTo('#trackPhotos');
  }

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
      var clip_leftX = event.pageX - clip_width*0.5;
      var clip_rightX= clip_leftX+5.0;
      var clipObj = new Clip(
        ui.draggable.data('url'),
        ui.draggable.data('thumbnail'),
        (clip_leftX/trackWidth)*timelineLength,
        0.0,0.0,0.0
      );

      $clip = $( "<div id='"+ui.draggable.attr('id')+"' class='timelinePhotoClip'></div>" );
      $clip.data({'url':clipObj.url,'start':clipObj.start,'stop':clipObj.stop});
      $clip.html(
        "<div class='clipCrop'>"+
          "<div class='clipThumb' style='background: url("+clipObj.thumb+")'></div>"+
        "</div>"
      );
      $clip.draggable({
        snap: ".trackPhotoSnap",
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
        $('#editorTimeCurrent span').text(renderTime(0.0)+"000ms");
      }
      else if(ui.position.left>trackWidth-10.0)
      {
          $("#editorTimeSlider,#editorTimeBar").animate({"left": trackOffset+trackWidth-10.0+"px"}, 600);
          var currentTime=((ui.position.left-trackOffset)/trackWidth) * timelineLength;
          $('#editorTimeCurrent span').text(renderTime(currentTime)+"ms");
      }
    },
    drag: function(event,ui){
      $('#editorTimeBar').css({
        top: 80.0+'px', left: ui.position.left
      });
      var currentTime=((ui.position.left-trackOffset)/trackWidth) * timelineLength;
      $('#editorTimeCurrent span').text(renderTime(currentTime)+"ms");
    }
  });

  $('#UI_render').on('click',function(e){
    var title = $('#UI_movieTitle').val();
    RenderSlideshow(TrackMain.clips.sort(function(a,b){return a.start-b.start}),title);
  });
};


$(function(){
    var trackPallet = new Array();
    var clipID = 0;
    var timelineLength = 60.0;

    var Track = function(e){
      this.clips = new Array();
    };

    var Clip = function(url,thumb,start,stop){
      this.url  = url; this.thumb = thumb;
      this.start=start;this.stop  = stop;

      console.log(this.url+this.thumb+this.start+this.stop);
    };
    //start the tracks up
    var TrackMain0 = new Track();
    var TrackMain1 = new Track();
    var TrackMain2 = new Track();

    $('#moviePallet .palletOverflow div').each(function(){
      //add id to pallet clips
      $(this).attr('id',"palletClip_"+clipID);
      //add the id to the trackPallet array
      trackPallet.push("palletClip_"+clipID);
      clipID++;//incriment id
    });
    console.log(trackPallet);

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
    $('#Track2,#Track1,#Track0').droppable({
      accept: '.palletThumb',
      drop: function( event, ui ) {
        console.log("UI id: "+$(this).attr('id'));
        $clip = new Clip("","",0.0,15.0);
        switch($(this).attr('id')){
          case 'Track0':
            console.log("Added clip to track 0");
            TrackMain0.clips.push($clip);
            break;
          case 'Track1':
            console.log("Added clip to track 1");
            TrackMain1.clips.push($clip);
            break;
          case 'Track2':
            console.log("Added clip to track 2");
            TrackMain2.clips.push($clip);
            break;
        }
        //$( this ).html( "Dropped!" );
        ui.draggable.remove();

        $( "<div id='"+ui.draggable.attr('id')+"' class='timelineClip'></div>" ).html(
          "<div class='clipCrop'>"+ui.draggable.text()+"</div>"
        ).draggable({
          snap: "#Track2, #Track1, #Track0",
          snapMode: 'inner'
        }).resizable({
          handles:'e, w'
        }).appendTo( this );
      }
    });
    console.log("ID IS: "+$('#Track2').id)

    $('#editorTimeSlider').draggable({
      axis: "x",
      stop: function(event, ui) {
        console.log(ui.position.left)
        if(ui.position.left<200)
        {
          //alert('Return back');
          $("#editorTimeSlider,#editorTimeBar").animate({"left": "190px"}, 600);
        }
        else if(ui.position.left>1000)
        {
            $("#editorTimeSlider,#editorTimeBar").animate({"left": "1000px"}, 600);
        }
      },
      drag: function(event,ui){
        $('#editorTimeBar').css({
          top: 50.0, left: ui.position.left
        });
        var currentTime=(ui.position.left/1000) * timelineLength;
        var miliSec = String(currentTime - Math.floor(currentTime)).slice(2,5);
        var totalSec = Math.round(currentTime);
        var minutes = parseInt( totalSec / 60 ) % 60;
        var seconds = totalSec % 60;

        var result = (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds  < 10 ? "0" + seconds : seconds)+":"+miliSec;
        $('#editorTimeCurrent').text(result+"ms");
      }
    });
    new Clip("My Url","My Thumb",1.0,2.0);
});

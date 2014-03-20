// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require turbolinks
//= require_tree .
//= require jquery.ui.all


$(function(){
    var PostIt = function(e) {
        var $post_it = $('#master').clone().fadeIn(500);
        $post_it.css({
            'top': e.pageY-$post_it.width()*0.1 + 'px',
            'left': e.pageX-$post_it.height()*0.5 + 'px',
            display: 'block',
            'z-index': ++stickyDepth
        })
        .draggable({
            handle: ".header"
        })
        .resizable();
        $post_it.on('mousedown', '.close', function() {
            var $sticky = $(this).parent().parent();
            $sticky.fadeOut(500, function() {
                $sticky.remove();
            });
        });
        $post_it.on('mousedown', function(e) {
            e.stopPropagation();
            $(this).css({
                'z-index': ++stickyDepth
            });
        });
        $post_it.find(".colors").spectrum({
            change: function(color) {
                $post_it.find('.header').css('background-color', color.toRgbString().slice(0, -1) + ",0.3)");
                console.log(color.toRgbString().slice(0, -1) + ",0.3)");
            }
        });
        $('#workspace'+workspaceCurrent).append($post_it);
    };

    var Track = function(e){
      this.clips = new Array();
    };

    var Clip = function(url,thumb,start,stop){
      this.url  = url; this.thumb = thumb;
      this.start=start;this.stop  = stop;

      console.log(this.url+this.thumb+this.start+this.stop);
    };

    $('.workspace').on('mousedown', function(e) {
        if(e.target.className == 'workspace')
            new PostIt(e);
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
    }).draggable();
    $('#Track2,#Track1,#Track0').droppable({
      drop: function( event, ui ) {
        console.log(ui.draggable.data);
        $( this ).html( "Dropped!" );
      }
    });
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
          top: 20.0, left: ui.position.left
        });
      }
    });
    new Clip("My Url","My Thumb",1.0,2.0);
});

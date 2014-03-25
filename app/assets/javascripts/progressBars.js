$(function() {

  $('.progressbar').each(function(){
    var t = $(this),
      dataperc = t.attr('data-perc'),
      barperc = Math.round(dataperc*5.56);
    t.find('.bar').animate({width:barperc}, dataperc*25);
    t.find('.label').append('<div class="perc"></div>');

    function perc() {
      var length = t.find('.bar').css('width'),
        perc = Math.round(parseInt(length)/5.56),
        labelpos = (parseInt(length)-2);
      t.find('.label').css('left', labelpos-15+"px");
      t.find('.perc').text(perc+'%');
    }
    perc();
    setInterval(perc, 0);
  });
});

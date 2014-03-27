$(function(){
  //Global Slide Nav
  //change 2 slide pages the dumb way
  $('.next_slide').on('click',function(){
    $(this).parent().hide();
    $('#tut_slide2').show();
  });

  //#1:2 Slide Nav
  $('#tut_search').on('click',function(){
    $(this).parent().html(
      "We are searching for a random subject, please wait..."
    );
    $(location).attr('href','/search?search_data=beautiful');
  });

  //#5:2
  $('#tut_end').on('click',function(){
    $.ajax({
      type: "POST",
      url: "/setTutorial",
      data: {
        toggle: "false"
      }
    }).done(function(response){
      $(location).attr('href','/');
    });
  });
});

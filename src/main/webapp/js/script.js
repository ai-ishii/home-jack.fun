/**
 * 
 */

 $(function(){
  $('#hamburger').on('click',function(){
    $('#hamburger').toggleClass("open");
    $('#header-menu').toggleClass("open", "close");
  });
});

$(function(){
  $('.cheese').on('click',function(){
    $('.cheese-detail').toggleClass("open");
    $('.cheese-detail').slideToggle();
  });
});

$(function(){
  $('.tomato').on('click',function(){
    $('.tomato-detail').toggleClass("open");
    $('.tomato-detail').slideToggle();
  });
});

$(function(){
  $('.lettuce').on('click',function(){
    $('.lettuce-detail').toggleClass("open");
    $('.lettuce-detail').slideToggle();
  });
});

$(function(){
  $('.ketchup').on('click',function(){
    $('.ketchup-detail').toggleClass("open");
    $('.ketchup-detail').slideToggle();
  });
});
$(function(){
  $('.egg').on('click',function(){
    $('.egg-detail').toggleClass("open");
    $('.egg-detail').slideToggle();
  });
});

$(function(){
  $('.patty').on('click',function(){
    $('.patty-detail').toggleClass("open");
    $('.patty-detail').slideToggle();
  });
});
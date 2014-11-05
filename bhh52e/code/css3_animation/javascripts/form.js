/***
 * Excerpted from "HTML5 and CSS3 Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhh52e for more book information.
***/
var processLogin = function(form, event){
  event.preventDefault();
  var request = $.ajax({
    url: "/login",
    type: "POST",
    data: form.serialize(),
    dataType: "json"
  });
  request.done = function(){
    // Do what you do when the login works.
  };
  return(request);
};

var addFormSubmitWithCSSAnimation = function(){
  $(".login").submit(function(event){
    var form = $(this);
    request = processLogin(form, event);
    request.fail(function(){   
      form.addClass("shake");
    });
  });
};

var addAnimationEndListener = function(){
  $(".login").on
    ("webkitAnimationEnd oanimationend msAnimationEnd animationend",
      function(event){
        $(this).removeClass("shake");
  });
};

var addTransitionFallbackListeners = function(){
  $(".login input[type=email], .login input[type=password]").focus(function(){
    $(this).animate({
        backgroundColor: "#ffe"
    }, 300 );
  });
  $(".login input[type=email], .login input[type=password]").blur(function(){
    $(this).animate({
        backgroundColor: "#fff"
    }, 300 );
  });
};

var addFormSubmitWithFallback = function(){
  $(".login").submit(function(event){
    var form = $(this);
    request = processLogin(form, event);
    request.fail(function(){
       form.animate({left: "-2%"}, 100)
         .animate({left: "2%"}, 100)
         .animate({left: "-2%"}, 100)
         .animate({left: "2%"}, 100)
         .animate({left: "0%"}, 100);
     });
  });
};


Modernizr.load(
  {
    test: Modernizr.csstransitions,
    nope: "javascripts/jquery.color-2.1.2.min.js",
    callback: function(url, result){
      if (!result){
        addTransitionFallbackListeners();
      }
    }
  }
);

if(Modernizr.cssanimations){
  addFormSubmitWithCSSAnimation();
  addAnimationEndListener();
}else{
  addFormSubmitWithFallback();
}





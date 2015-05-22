/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev2 for more book information.
***/
(function($){
  function setupButton() {
    var $pauseButton, $slideShow;

    $slideShow = $('#slideshow');
    $pauseButton = $('<button>Pause</button>');

    $pauseButton.on('click', function() {
      if (isPaused($slideShow)) {
        playSlideShow($slideShow, $(this));
      } else {
        pauseSlideShow($slideShow, $(this));
      }
    });

    function isPaused($player) {
      return $player.is('.cycle-paused');
    }

    function playSlideShow($player, $button) {
      $player.cycle('resume');
      $button.html('Pause');
    }

    function pauseSlideShow($player, $button) {
      $player.cycle('pause');
      $button.html('Resume');
    }

    $pauseButton.insertAfter($slideShow);
  }
  $('#slideshow').cycle({fx: 'fade'});
  setupButton();

})(jQuery);

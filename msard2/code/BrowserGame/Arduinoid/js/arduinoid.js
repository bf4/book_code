/***
 * Excerpted from "Arduino: A Quick-Start Guide, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/msard2 for more book information.
***/
const MAX_LIVES = 5;

var GameStates = {
  RUNNING: 'running',
  PAUSED: 'paused',
  LOST: 'lost',
  WON: 'won'
}

var Game = {
  lives: MAX_LIVES,
  score: 0,
  state: GameStates.PAUSED,

  paddle: {
    speed: 15,
    width: $("#paddle").width(),
    height: $("#paddle").height()
  },

  playfield: {
    width: $("#playfield").width(),
    height: $("#playfield").height(),
    rows: 4,
    columns: 10
  },

  ball: {
    diameter: $("#ball").width(),
    vx: 5 + Math.random() * 5,
    vy: -10
  },

  controller: new GameController('/dev/tty.usbmodem24321')
}

function initGame() {
  Game.state = GameStates.PAUSED;
  Game.lives = MAX_LIVES;
  Game.score = 0;
  resetMovingObjects();
  updateStatistics();
  drawPlayfield();
}

function resetMovingObjects() {
  $("#paddle").css("left", (Game.playfield.width - Game.paddle.width) / 2);
  $("#ball").css("left", (Game.playfield.width - Game.ball.diameter) / 2);
  $("#ball").css("top", parseInt($("#paddle").css("top")) - Game.paddle.height);
}

function updateStatistics() {
  $('#lives').text(Game.lives);
  $('#score').text(Game.score);
}

function drawPlayfield() {
  var colors = ['blue', 'green', 'red', 'yellow'];
  var $playfield = $('#playfield');
  $playfield.children('.row').remove(); 

  for (var row = 0; row < Game.playfield.rows; row++) {
    var $row = $('<div class="row"></div>'); 
    $row.appendTo($playfield);
    for (var col = 0; col < Game.playfield.columns; col++) {
      var $block = $("<div class='block'></div>");
      $block.css("background", 'url("img/' + colors[row] + '.png")');
      $block.appendTo($row);
    }
  }
}

function gameLoop() {
  switch (Game.state) {
    case GameStates.PAUSED:
      if (Game.controller.buttonPressed) {
        Game.state = GameStates.RUNNING;
      }
      break;
    case GameStates.RUNNING:
      movePaddle();
      moveBall();
      checkCollisions();
      updateStatistics();
      break;
    case GameStates.WON:
      handleMessageState("winner");
      break;
    case GameStates.LOST:
      handleMessageState("game_over");
      break;
    default:
      break;
  }
}

function handleMessageState(message) {
  $("#" + message).show();
  if (Game.controller.buttonPressed) {
    $("#" + message).hide();
    initGame();
  }
}

function checkCollisions() {
  if (ballDropped()) {
    Game.lives = Game.lives - 1;
    if (Game.lives == 0) {
      Game.state = GameStates.LOST;
    } else {
      Game.state = GameStates.PAUSED;
      resetMovingObjects();
    }
  }
  if (!checkBlockCollision()) {
    Game.state = GameStates.WON;
  }
}

function ballDropped() {
  var ball_y = $("#ball").position().top;
  var paddle_y = $("#paddle").position().top;
  return ball_y + Game.ball.diameter > paddle_y + Game.paddle.height;
}

function inXRange(ball_left, block_left, block_width) {
  return (ball_left + Game.ball.diameter >= block_left) && 
         (ball_left <= block_left + block_width);
}

function inYRange(ball_top, block_top, block_height) {
  return (ball_top + Game.ball.diameter >= block_top) &&
         (ball_top <= block_top + block_height);
}

function checkBlockCollision() {
  var block_width = $(".block").first().width(); 
  var block_height = $(".block").first().height();
  var ball_left = $("#ball").position().left;
  var ball_top = $("#ball").position().top;
  var blocks_left = false;
  $(".block").each(function() { 
    if ($(this).css("visibility") == "visible") {
      blocks_left = true;
      var block_top = $(this).position().top;
      var block_left = $(this).position().left;
      var in_x = inXRange(ball_left, block_left, block_width);
      var in_y = inYRange(ball_top, block_top, block_height);
      if (in_x && in_y) {
        Game.score += 10;
        $(this).css("visibility", "hidden");
        if (in_x) {
          Game.ball.vy *= -1;
        }
        if (in_y) {
          Game.ball.vx *= -1;
        }
      }
    }
  });
  return blocks_left;
}

function moveBall() {
  var ball_pos = $("#ball").position(); 
  var ball_x = ball_pos.left;
  var ball_y = ball_pos.top; 
  var next_x_pos = ball_x + Game.ball.vx;
  var next_y_pos = ball_y + Game.ball.vy;

  if (next_x_pos <= 0) { 
    Game.ball.vx *= -1;
    next_x_pos = 1;
  } else if (next_x_pos >= Game.playfield.width - Game.ball.diameter) {
    Game.ball.vx *= -1;
    next_x_pos = Game.playfield.width - Game.ball.diameter - 1;
  } 

  var paddle_y = $("#paddle").position().top; 
  if (next_y_pos <= 0) {
    Game.ball.vy *= -1;
    next_y_pos = 1;
  } else if (next_y_pos + Game.ball.diameter >= paddle_y) {
    var paddle_x = $("#paddle").position().left;
    if (next_x_pos >= paddle_x && 
        next_x_pos <= paddle_x + Game.paddle.width)
    {
      Game.ball.vy *= -1;
      next_y_pos = paddle_y - Game.ball.diameter;
    }
  } 

  $("#ball").css({ "left" : next_x_pos, "top" : next_y_pos }); 
}

function movePaddle() {
  if (Game.controller.moveLeft) {
    var paddle_x = $("#paddle").position().left;
    if (paddle_x - Game.paddle.speed >= 0) {
      $("#paddle").css("left", paddle_x - Game.paddle.speed);
    } else {
      $("#paddle").css("left", 0);
    }
  }

  if (Game.controller.moveRight) {
    var paddle_x = $("#paddle").position().left;
    var next_pos = paddle_x + Game.paddle.width + Game.paddle.speed;
    if (next_pos < Game.playfield.width) {
      $("#paddle").css("left", paddle_x + Game.paddle.speed); 
    }
  }
}

$(function() {
  initGame();
  setInterval(gameLoop, 30);
});


#include <Wire.h>
#include <TVout.h>
#include <fontALL.h>
#include "nunchuk.h"

const int WIDTH = 128;
const int HEIGHT = 96;
const int CH_LEN = 8;
const int MAX_TARGET = 10;
const int TARGET_LIFESPAN = 1500;

TVout tv;
Nunchuk nunchuk;

boolean up, down, left, right, c_button, z_button;
int chx, chy;
int chvx, chvy;
int target_x, target_y, target_r;
unsigned int target_count;
unsigned int hits;
unsigned long target_creation;

enum GameState { 
  INTRO, STARTING, RUNNING, DONE
};

GameState state;

void init_game() {
  up = down = left = right = c_button = z_button = false;
  chx = WIDTH / 2;
  chy = HEIGHT / 2;
  chvx = 1;
  chvy = 1;
  state = INTRO;
  target_count = 0;
  hits = 0;
  create_target();
}

void create_target() {
  target_r = random(7, 11);
  target_x = random(target_r, WIDTH - target_r);
  target_y = random(target_r, HEIGHT - target_r);
  target_count++;
  target_creation = millis();
}

void setup() {
  randomSeed(analogRead(A0));
  tv.begin(PAL, WIDTH, HEIGHT);
  nunchuk.initialize();
  init_game();
}

void loop() {
  check_controls();
  switch (state) {
    case INTRO:    intro();       break;
    case STARTING: start_game();  break;
    case RUNNING:  update_game(); break;
    case DONE:     game_over();   break;
  }
  tv.delay_frame(1); 
}

void check_controls() {
  up = down = left = right = c_button = z_button = false;
  if (nunchuk.update())
  {
    if (nunchuk.joystick_x() < 70)
      left = true;
    if (nunchuk.joystick_x() > 150)
      right = true;
    if (nunchuk.joystick_y() > 150)
      up = true;
    if (nunchuk.joystick_y() < 70)
      down = true;
    c_button = nunchuk.c_button();
    z_button = nunchuk.z_button();
  }
}

void move_crosshairs() {
  if (left) chx -= chvx;
  if (right) chx += chvx;
  if (up) chy -= chvy;
  if (down) chy += chvy;
  
  if (chx <= CH_LEN)
    chx = CH_LEN + 1;
  if (chx >= WIDTH - CH_LEN)
    chx = WIDTH - CH_LEN - 1;
  if (chy <= CH_LEN)
    chy = CH_LEN + 1;
  if (chy >= HEIGHT - CH_LEN)
    chy = HEIGHT - CH_LEN - 1;
}

void draw_crosshairs() {
  tv.draw_row(chy, chx - CH_LEN, chx - 1, WHITE);
  tv.draw_row(chy, chx + 1, chx + CH_LEN, WHITE);
  tv.draw_column(chx, chy - CH_LEN, chy - 1, WHITE);
  tv.draw_column(chx, chy + 1, chy + CH_LEN, WHITE);
}

bool target_hit() {
  if (z_button)
    return (target_x - chx) * (target_x - chx) +
           (target_y - chy) * (target_y - chy) < target_r * target_r;
  return false;
}

void check_target() {
  if (target_hit()) {
    hits++;
    create_target();
  }
  int remaining_time = millis() - target_creation;
  if (remaining_time >= TARGET_LIFESPAN) {
    create_target();
  }
  int w = map(TARGET_LIFESPAN - remaining_time, 0, TARGET_LIFESPAN, 0, WIDTH);
  tv.draw_rect(0, 0, w, 3, WHITE, WHITE);
}

void intro() {
  tv.select_font(font8x8);
  tv.printPGM(28, 20, PSTR("Pragduino")); 
  tv.select_font(font6x8);
  tv.printPGM(16, 40, PSTR("A Pragmatic Game"));
  tv.select_font(font4x6);
  tv.printPGM(18, 74, PSTR("Press Z-Button to Start"));
  if (z_button) {
    state = STARTING;
    z_button = false;
    delay(200);
  }
}

void start_game() {
  tv.clear_screen();
  tv.select_font(font8x8);
  tv.printPGM(40, 44, PSTR("READY?"));
  if (z_button) {
    init_game();
    state = RUNNING;
  }
}

void game_over() {
  tv.clear_screen();
  tv.select_font(font8x8);
  tv.printPGM(28, 38, PSTR("Game Over"));
  int x = (WIDTH - 7 * 8) / 2;
  if (hits > 9)
    x = (WIDTH - 8 * 8) / 2;
  tv.printPGM(x, 50, PSTR("Hits: "));
  tv.print(x + 6 * 8, 50, hits);
  if (z_button) {
    state = STARTING;
    z_button = false;
    delay(200);
  }
}

void update_game() {
  tv.clear_screen();
  tv.draw_circle(target_x, target_y, target_r, WHITE);
  move_crosshairs();
  draw_crosshairs();
  check_target();
  if (target_count == MAX_TARGET + 1) {
    state = DONE;
    z_button = false;
    delay(200);
  }
}


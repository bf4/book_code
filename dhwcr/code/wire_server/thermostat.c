/***
 * Excerpted from "Cucumber Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
***/
#define INVALID 999999

static int room_temp    = INVALID;
static int desired_temp = INVALID;
static int ac_on        = 0;
static void update_ac() {
    if (room_temp    != INVALID &&
        desired_temp != INVALID) {
        ac_on = (room_temp > desired_temp);
    }
}


int ac_is_on() {
    return ac_on;
}
void set_room_temp(int temperature) {
    room_temp = temperature;
    update_ac();
}
void set_thermostat(int temperature) {
    desired_temp = temperature;
    update_ac();
}

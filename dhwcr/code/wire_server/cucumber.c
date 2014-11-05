/***
 * Excerpted from "Cucumber Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
***/
#include <stdio.h>
#include <string.h>
#include "thermostat.h"
int the_room_is_at_f(const char* arg) {
    set_room_temp(atoi(arg));
    return 0;
}
int i_set_the_thermostat_to_f(const char* arg) {
    set_thermostat(atoi(arg));
    return 0;
}
int the_ac_should_be(const char* arg) {
    int want_ac_on = (0 == strcmp("on", arg));
    return ac_is_on() == want_ac_on ?
         0 :
        -1 ;
}


typedef int (*callback_t)(const char* arg);
typedef struct stepdef {
    const char* pattern;
    callback_t callback;
} stepdef_t;

#define NUMDEFS 3
stepdef_t stepdefs[NUMDEFS] = {
    { "the room is at %31[^\"] F",          the_room_is_at_f          },
    { "I set the thermostat to %31[^\"] F", i_set_the_thermostat_to_f },
    { "the A/C should be %31[^\"]",         the_ac_should_be          },
};



void respond_success(FILE* stream) {
    fputs("[\"success\",[]]\n", stream);
}
void respond_failure(FILE* stream) {
    fputs("[\"fail\",{\"message\":\"Step failed\"}]\n", stream);
}


void respond_with_match(FILE* stream, int id, const char* arg_val, int arg_pos) {
    fprintf(stream,
            "[\"success\","
            "[{\"id\":\"%d\", "
            "\"args\":[{\"val\":\"%s\", \"pos\":%d}]}]]\n",
            id,
            arg_val,
            arg_pos);
}


void respond_to_step_matches(FILE* stream, const char* msg) {
    int i;
	
    for (i = 0; i < NUMDEFS; ++i) {
        const char* step    = msg + 34;
        const char* pattern = stepdefs[i].pattern;
        char arg_val[32] = {0};
        if (sscanf(step, pattern, arg_val) > 0) {
            int arg_pos = strchr(pattern, '%') - pattern;
            respond_with_match(stream, i, arg_val, arg_pos);
            return;
        }
    }
    respond_success(stream); // no matches
}


void respond_to_invoke(FILE* stream, const char* msg) {
    const char* id_text  = msg + 17;
    const char* arg_text = msg + 29;

    int id = atoi(id_text);
	
    char arg_val[32] = {0};
    sscanf(arg_text, "%31[^\"]", arg_val);
	
    if (0 == stepdefs[id].callback(arg_val)) {
        respond_success(stream);
    } else {
        respond_failure(stream);
    }
}


#define MSG_TYPE_IS(msg, type) \
    (0 == strncmp(msg + 2, type, sizeof(type) - 1))
	
void respond_to_cucumber(FILE* stream, const char* msg) {
    if (MSG_TYPE_IS(msg, "step_matches")) {
        respond_to_step_matches(stream, msg);
    } else if (MSG_TYPE_IS(msg, "invoke")) {
        respond_to_invoke(stream, msg);
    } else {
        respond_success(stream);
    }
}

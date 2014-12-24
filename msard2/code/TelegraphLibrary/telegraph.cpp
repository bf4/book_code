#include <ctype.h>
#include <Arduino.h>
#include "telegraph.h"

const char* LETTERS[] = {
  ".-",   "-...", "-.-.", "-..",  ".",    // A-E
  "..-.", "--.",  "....", "..",   ".---", // F-J
  "-.-",  ".-..", "--",   "-.",   "---",  // K-O
  ".--.", "--.-", ".-.",  "...",  "-",    // P-T
  "..-",  "...-", ".--",  "-..-", "-.--", // U-Y
  "--.."                                  // Z
};

const char* DIGITS[] = {
  "-----", ".----", "..---", "...--", // 0-3
  "....-", ".....", "-....", "--...", // 4-7
  "---..", "----."                    // 8-9
};

Telegraph::Telegraph(const int output_pin, const int dit_length) {
  _output_pin = output_pin;
  _dit_length = dit_length;
  _dah_length = dit_length * 3;
  pinMode(_output_pin, OUTPUT);
}
  
void Telegraph::send_message(const char* message) {
  for (unsigned int i = 0; i < strlen(message); i++) {
    const char current_char = toupper(message[i]); 
    if (isalpha(current_char)) {
      output_code(LETTERS[current_char - 'A']);
      delay(_dah_length);
    } else if (isdigit(current_char)) {
      output_code(DIGITS[current_char - '0']);
      delay(_dah_length);
    } else if (current_char == ' ') { 
      Serial.print(" ");
      delay(_dit_length * 7);
    }
  }
  Serial.println();
}

void Telegraph::output_code(const char* code) {
  const unsigned int code_length = strlen(code);
  
  for (unsigned int i = 0; i < code_length; i++) {
    if (code[i] == '.')
      dit();
    else
      dah();
    if (i != code_length - 1)
      delay(_dit_length);
  }
}

void Telegraph::dit() {
  Serial.print(".");
  output_symbol(_dit_length);  
}

void Telegraph::dah() {
  Serial.print("-");
  output_symbol(_dah_length);
}
void Telegraph::output_symbol(const int length) {
  digitalWrite(_output_pin, HIGH);
  delay(length);
  digitalWrite(_output_pin, LOW);
}


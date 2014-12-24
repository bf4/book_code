const unsigned int MAX_MEMBERS = 10;

class Team {
  const char** _members;
  unsigned int _num_members;
  unsigned int _positions[MAX_MEMBERS];
  public:
  Team(const char** members) {
    _members = members;
    _num_members = 0; 
    const char** member = _members;
    while (*member++)
      _num_members++; 
      
    const unsigned int share = 180 / _num_members;
    unsigned int pos = share / 2;
    for (unsigned int i = 0; i < _num_members; i++) {
      _positions[i] = pos;
      pos += share;
    }
  }

  int get_position(const char* name) const {
    int position = 0;
    for (unsigned int i = 0; i < _num_members; i++) {
      if (!strcmp(_members[i], name)) {
        position = _positions[i];
        break;
      }
    }
    return position;
  }
};

#include <Servo.h> 
const unsigned int MOTOR_PIN = 9;
const unsigned int MOTOR_DELAY = 15;

class Blaminatr {
  Team  _team;
  Servo _servo;

  public:

  Blaminatr(const Team& team) : _team(team) {}
  
  void attach(const int sensor_pin) {
    _servo.attach(sensor_pin);
    delay(MOTOR_DELAY);
  }
  
  void blame(const char* name) {
    _servo.write(_team.get_position(name));
    delay(MOTOR_DELAY);
  }
};

const unsigned int MAX_NAME = 30;
const unsigned int BAUD_RATE = 9600;
const unsigned int SERIAL_DELAY = 5;

const char* members[] = { "nobody", "Bob", "Alice", "Maik", NULL };
Team team(members);
Blaminatr blaminatr(team);

void setup() {
  Serial.begin(BAUD_RATE);
  blaminatr.attach(MOTOR_PIN);
  blaminatr.blame("nobody");
}

void loop() {
  char name[MAX_NAME + 1];
  if (Serial.available()) {
    unsigned int i = 0;
    while (Serial.available() && i < MAX_NAME + 1) {
      const char c = Serial.read();
      if (c != -1 && c != '\n')
        name[i++] = c;
      delay(SERIAL_DELAY);
    }
    name[i] = 0;
    Serial.print(name);
    Serial.println(" is to blame.");
    blaminatr.blame(name); 
  }
}


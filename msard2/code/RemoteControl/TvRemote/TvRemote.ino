#include <IRremote.h>

class TvRemote {

  enum {
    CMD_LEN   = 32,         GUIDE     = 0xE0E0F20D,
    POWER     = 0xE0E040BF, TOOLS     = 0xE0E0D22D,
    SOURCE    = 0xE0E0807F, INFO      = 0xE0E0F807,
    HDMI      = 0xE0E0D12E, OPTIONS   = 0xE0E016E9,
    ONE       = 0xE0E020DF, UP_K      = 0xE0E006F9,
    TWO       = 0xE0E0A05F, LEFT_K    = 0xE0E0A659,
    THREE     = 0xE0E0609F, RIGHT_K   = 0xE0E046B9,
    FOUR      = 0xE0E010EF, DOWN_K    = 0xE0E08679,
    FIVE      = 0xE0E0906F, RETURN    = 0xE0E01AE5,
    SIX       = 0xE0E050AF, EXIT      = 0xE0E0B44B,
    SEVEN     = 0xE0E030CF, A         = 0xE0E036C9,
    EIGHT     = 0xE0E0B04F, B         = 0xE0E028D7,
    NINE      = 0xE0E0708F, C         = 0xE0E0A857,
    TXT       = 0xE0E034CB, D         = 0xE0E06897,
    ZERO      = 0xE0E08877, PIP       = 0xE0E004FB,
    PRE_CH    = 0xE0E0C837, SEARCH    = 0xE0E0CE31,
    VOL_UP    = 0xE0E0E01F, DUAL      = 0xE0E000FF,
    VOL_DOWN  = 0xE0E0D02F, USB_HUB   = 0xE0E025DA,
    MUTE      = 0xE0E0F00F, P_SIZE    = 0xE0E07C83,
    CH_LIST   = 0xE0E0D629, SUBTITLE  = 0xE0E0A45B,
    PROG_UP   = 0xE0E048B7, REWIND    = 0xE0E0A25D,
    PROG_DOWN = 0xE0E008F7, PAUSE     = 0xE0E052AD,
    MENU      = 0xE0E058A7, FORWARD   = 0xE0E012ED,
    SMART_TV  = 0xE0E09E61, RECORD    = 0xE0E0926D,
    PLAY      = 0xE0E0E21D, STOP      = 0xE0E0629D
  };

  IRsend tv; 

  void send_command(const long command) {
    tv.sendSAMSUNG(command, CMD_LEN);
  }

  public:

  void guide()     { send_command(GUIDE); }
  void power()     { send_command(POWER); }
  void tools()     { send_command(TOOLS); }
  void source()    { send_command(SOURCE); }
  void info()      { send_command(INFO); }
  void hdmi()      { send_command(HDMI); }
  void zero()      { send_command(ZERO); }
  void one()       { send_command(ONE); }
  void two()       { send_command(TWO); }
  void three()     { send_command(THREE); }
  void four()      { send_command(FOUR); }
  void five()      { send_command(FIVE); }
  void six()       { send_command(SIX); }
  void seven()     { send_command(SEVEN); }
  void eight()     { send_command(EIGHT); }
  void nine()      { send_command(NINE); }
  void up()        { send_command(UP_K); }
  void left()      { send_command(LEFT_K); }
  void right()     { send_command(RIGHT_K); }
  void down()      { send_command(DOWN_K); }
  void ret()       { send_command(RETURN); }
  void exit()      { send_command(EXIT); }
  void a()         { send_command(A); }
  void b()         { send_command(B); }
  void c()         { send_command(C); }
  void d()         { send_command(D); }
  void txt()       { send_command(TXT); }
  void pip()       { send_command(PIP); }
  void pre_ch()    { send_command(PRE_CH); }
  void search()    { send_command(SEARCH); }
  void vol_up()    { send_command(VOL_UP); }
  void vol_down()  { send_command(VOL_DOWN); }
  void dual()      { send_command(DUAL); }
  void usb_hub()   { send_command(USB_HUB); }
  void mute()      { send_command(MUTE); }
  void p_size()    { send_command(P_SIZE); }
  void ch_list()   { send_command(CH_LIST); }
  void subtitle()  { send_command(SUBTITLE); }
  void prog_up()   { send_command(PROG_UP); }
  void prog_down() { send_command(PROG_DOWN); }
  void pause()     { send_command(PAUSE); }
  void rewind()    { send_command(REWIND); }
  void forward()   { send_command(FORWARD); }
  void menu()      { send_command(MENU); }
  void smart_tv()  { send_command(SMART_TV); }
  void record()    { send_command(RECORD); }
  void play()      { send_command(PLAY); }
  void stop()      { send_command(STOP); }
};

const unsigned int BAUD_RATE = 9600;

TvRemote tv; 
String command = "";
boolean input_available = false; 

void setup() {
  Serial.begin(BAUD_RATE);
}

void serialEvent() { 
  while (Serial.available()) {
    const char c = Serial.read();
    if (c == '\n')
      input_available = true;
    else
      command += c;
  }
}

void loop() {
  if (input_available) {
    Serial.print("Received command: ");
    Serial.println(command);
    if (command == "guide")          tv.guide();
    else if (command == "power")     tv.power();
    else if (command == "tools")     tv.tools();
    else if (command == "source")    tv.source();
    else if (command == "info")      tv.info();
    else if (command == "hdmi")      tv.hdmi();
    else if (command == "zero")      tv.zero();
    else if (command == "one")       tv.one();
    else if (command == "two")       tv.two();
    else if (command == "three")     tv.three();
    else if (command == "four")      tv.four();
    else if (command == "five")      tv.five();
    else if (command == "six")       tv.six();
    else if (command == "seven")     tv.seven();
    else if (command == "eight")     tv.eight();
    else if (command == "nine")      tv.nine();
    else if (command == "up")        tv.up();
    else if (command == "left")      tv.left();
    else if (command == "right")     tv.right();
    else if (command == "down")      tv.down();
    else if (command == "ret")       tv.ret();
    else if (command == "exit")      tv.exit();
    else if (command == "a")         tv.a();
    else if (command == "b")         tv.b();
    else if (command == "c")         tv.c();
    else if (command == "d")         tv.d();
    else if (command == "txt")       tv.txt();
    else if (command == "pip")       tv.pip();
    else if (command == "pre_ch")    tv.pre_ch();
    else if (command == "search")    tv.search();
    else if (command == "vol_up")    tv.vol_up();
    else if (command == "vol_down")  tv.vol_down();
    else if (command == "dual")      tv.dual();
    else if (command == "usb_hub")   tv.usb_hub();
    else if (command == "mute")      tv.mute();
    else if (command == "p_size")    tv.p_size();
    else if (command == "ch_list")   tv.ch_list();
    else if (command == "subtitle")  tv.subtitle();
    else if (command == "prog_up")   tv.prog_up();
    else if (command == "prog_down") tv.prog_down();
    else if (command == "pause")     tv.pause();
    else if (command == "rewind")    tv.rewind();
    else if (command == "forward")   tv.forward();
    else if (command == "menu")      tv.menu();
    else if (command == "smart_tv")  tv.smart_tv();
    else if (command == "record")    tv.record();
    else if (command == "play")      tv.play();
    else if (command == "stop")      tv.stop();
    else Serial.println("Command is unknown.");

    command = ""; 
    input_available = false;
  }
}


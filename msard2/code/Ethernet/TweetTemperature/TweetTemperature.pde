import processing.serial.*;

final float  MAX_WORKING_TEMP = 32.0;
final int    LINE_FEED = 10;
final int    BAUD_RATE = 9600;
final int    FONT_SIZE = 32;
final int    WIDTH = 320;
final int    HEIGHT = 240;
final String API_KEY = "<YOUR API KEY>";
final String API_SECRET = "<YOUR API SECRET>";
final String ACCESS_TOKEN = "<YOUR ACCESS TOKEN>";
final String ACCESS_TOKEN_SECRET = "<YOUR ACCESS TOKEN SECRET>";

Serial _arduinoPort;
float _temperature;
boolean _isCelsius;
PFont _font;

void setup() {
  size(WIDTH, HEIGHT);
  _font = createFont("Arial", FONT_SIZE, true);
  println(Serial.list());
  _arduinoPort = new Serial(this, Serial.list()[0], BAUD_RATE);
  _arduinoPort.clear();
  _arduinoPort.bufferUntil(LINE_FEED);
  _arduinoPort.readStringUntil(LINE_FEED);
}

void draw() {
  background(255);
  fill(0);
  textFont(_font, FONT_SIZE);
  textAlign(CENTER, CENTER);
  if (_isCelsius)
    text(_temperature + " \u2103", WIDTH / 2, HEIGHT / 2);
  else 
    text(_temperature + " \u2109", WIDTH / 2, HEIGHT / 2);
} 

void serialEvent(Serial port) {
  final String arduinoData = port.readStringUntil(LINE_FEED);
  if (arduinoData != null) {
    final String[] data = split(trim(arduinoData), ' ');
    if (data.length == 2 && 
        (data[1].equals("C") || data[1].equals("F")))
    {
      _isCelsius = data[1].equals("C");
      _temperature = float(data[0]);
      if (Float.isNaN(_temperature))
        return;
      println(_temperature);
      int sleepTime = 5 * 60 * 1000;
      if (_temperature > MAX_WORKING_TEMP) {
        tweetAlarm();
        sleepTime = 120 * 60 * 1000;
      }
      try {
        Thread.sleep(sleepTime);
      }
      catch(InterruptedException ignoreMe) {}
    }
  }
}

void tweetAlarm() {
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setDebugEnabled(true)
    .setOAuthConsumerKey(API_KEY)
    .setOAuthConsumerSecret(API_SECRET)
    .setOAuthAccessToken(ACCESS_TOKEN)
    .setOAuthAccessTokenSecret(ACCESS_TOKEN_SECRET);
  TwitterFactory tf = new TwitterFactory(cb.build());
  Twitter twitter = tf.getInstance();  
  try {
    Status status = twitter.updateStatus(
      "Someone, please, take me to the beach!"
    );
    println(
      "Successfully updated status to '" + status.getText() + "'."
    );
  }
  catch (TwitterException e) {
    e.printStackTrace();
  }
}


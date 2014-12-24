/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.opencaption;

import java.util.List;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.location.Criteria;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.speech.RecognizerIntent;
import android.util.Log;
import android.widget.Toast;

/**
 * @author Eric Redmond
 * @twitter coderoshi
 */
public class OpenCaptionActivity
  extends Activity
  implements LocationListener
{
  private static final String TAG = OpenCaptionActivity.class.getName();
  private StringBuilder messageText;
  private LocationManager locationManager;
  private String locationMessage;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    messageText = new StringBuilder();
    setupLocationManager();
    startSpeechPrompt( 1 );
  }

  private void startSpeechPrompt( int speechRequest ) {
    Intent intent = new Intent( RecognizerIntent.ACTION_RECOGNIZE_SPEECH );
    intent.putExtra( RecognizerIntent.EXTRA_PROMPT, R.string.voice_prompt );
    startActivityForResult( intent, speechRequest );
  }

  /*
  protected void onResume() {
    Log.d(TAG, "onResume");
    super.onResume();
    messageText = new StringBuilder();
    List<String> results =
        getIntent().getStringArrayListExtra( RecognizerIntent.EXTRA_RESULTS );
    if( !results.isEmpty() ) {
      // save the spoken text, we'll do something with it later
      messageText.append( results.get(0) );
    }
    finish();
  }
  */

  @Override
  protected void onActivityResult(int requestCode, int resultCode,
                                  Intent intent) {
    Log.d(TAG, "onActivityResult resultCode: " + resultCode);
    if( resultCode == RESULT_OK ) {
      List<String> results =
          intent.getStringArrayListExtra( RecognizerIntent.EXTRA_RESULTS );
      if( !results.isEmpty() ) {
        // save the spoken text, we'll do something with it later
        messageText.append( results.get(0) );
        messageText.append( "\n" );
      }
      // run recognizer again, increment the next request code
      startSpeechPrompt( ++requestCode );
    } else if( resultCode == RESULT_CANCELED ) {
      // end this activity
      finish();
    }
    super.onActivityResult(requestCode, resultCode, intent);
  }
  protected void onPause() {
    super.onPause();
    // email the spoken text to the Glass owner
    messageText.append( "\nLocation: " );
    messageText.append( getLocationMessage() );
    new EmailWebServiceTask(this).execute( messageText.toString() );
    messageText.setLength(0);
  }

  private synchronized void setLocationMessage(String locMsg) {
    this.locationMessage = locMsg;
  }
  
  private String getLocationMessage() {
    if( this.locationMessage != null ) {
      return this.locationMessage;
    } else {
      return "unknown";
    }
  }

  private void setupLocationManager() {
    locationManager = (LocationManager)getSystemService(Context.LOCATION_SERVICE);

    Criteria criteria = new Criteria();
    criteria.setAccuracy( Criteria.ACCURACY_COARSE );
    // criteria.setAltitudeRequired(true);

    List<String> providers = locationManager.getProviders(criteria, true);
    for (String provider : providers) {
      locationManager.requestLocationUpdates(provider, 15*1000, 100, this);
    }
  }

  @Override
  public void onStatusChanged(String provider, int stat, Bundle extras) { }

  @Override
  public void onProviderEnabled(String provider) { }

  @Override
  public void onProviderDisabled(String provider) { }

  @Override
  public void onLocationChanged(Location location) {
    if( this.locationMessage == null ) {
      Toast.makeText(this, R.string.location_found, Toast.LENGTH_LONG).show();
    }
    String msg = 
        location.getLatitude() + "," +
        location.getLongitude();
    setLocationMessage( msg );
  }
}

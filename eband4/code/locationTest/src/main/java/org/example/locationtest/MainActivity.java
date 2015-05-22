/***
 * Excerpted from "Hello, Android",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/eband4 for more book information.
***/
package org.example.locationtest;

import android.app.Activity; 
import android.app.Dialog;
import android.content.Intent;
import android.content.IntentSender;
import android.location.Location;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ScrollView;
import android.widget.TextView;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesUtil;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.location.LocationListener;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationServices;

public class MainActivity extends Activity implements 
      GoogleApiClient.ConnectionCallbacks,
      GoogleApiClient.OnConnectionFailedListener,
      LocationListener {
   private static final long UPDATE_INTERVAL = 5000; 
   private static final long FASTEST_INTERVAL = 1000;
   private static final int CONNECTION_FAILURE_RESOLUTION_REQUEST = 9000;

   private TextView mOutput; 
   private ScrollView mScroller;
   private GoogleApiClient mGoogleApiClient;
   private long mLastTime;
   // ...

   @Override
   public void onCreate(Bundle savedInstanceState) { 
      super.onCreate(savedInstanceState);
      setContentView(R.layout.activity_main); 

      // Define new API client
      mGoogleApiClient = new GoogleApiClient.Builder(this) 
            .addConnectionCallbacks(this)
            .addOnConnectionFailedListener(this)
            .addApi(LocationServices.API)
            .build();

      // Get view references
      mOutput = (TextView) findViewById(R.id.output); 
      mScroller = (ScrollView) findViewById(R.id.scroller);

      // Get current time so we can tell how far apart the updates are
      mLastTime = System.currentTimeMillis(); 
   }

   @Override
   public boolean onCreateOptionsMenu(Menu menu) { 
      // Inflate the menu; this adds items to the action bar if it is present.
      getMenuInflater().inflate(R.menu.menu_main, menu);
      return true;
   }

   @Override
   public boolean onOptionsItemSelected(MenuItem item) {
      // Handle action bar item clicks here. The action bar will
      // automatically handle clicks on the Home/Up button, so long
      // as you specify a parent activity in AndroidManifest.xml.
      int id = item.getItemId();
      if (id == R.id.action_settings) {
         return true;
      }
      return super.onOptionsItemSelected(item);
   }

   @Override
   protected void onResume() {
      super.onResume();
      // Connect the client if Google Services are available
      if (servicesAvailable()) {
         mGoogleApiClient.connect();
      }
   }

   @Override
   protected void onPause() {
      if (mGoogleApiClient.isConnected()) {
         // Stop updates to save power while app paused
         mGoogleApiClient.unregisterConnectionCallbacks(this);
         mGoogleApiClient.disconnect();
      }
      super.onPause();
   }

   @Override
   public void onLocationChanged(Location location) {
      dumpLocation(location);
   }

   /** Check that Google Play Services is available */
   private boolean servicesAvailable() {
      int resultCode = GooglePlayServicesUtil.
            isGooglePlayServicesAvailable(this);
      if (ConnectionResult.SUCCESS == resultCode) {
         log("Google Play services is available");
         return true;
      } else {
         log("Google Play services is not available");
         showErrorDialog(resultCode);
         return false;
      }
   }

   /** Show a Google Play Services error message */
   private void showErrorDialog(int resultCode) {
      // Get the error dialog from Google Play Services
      Dialog errorDialog = GooglePlayServicesUtil.getErrorDialog(
            resultCode, this, CONNECTION_FAILURE_RESOLUTION_REQUEST);

      if (errorDialog != null) {
         // Display error
         errorDialog.show();
      }
   }

   /**
    * Called by Location Services when the request to connect the
    * client finishes successfully. At this point, you can
    * request the current location or start periodic updates.
    */
   @Override
   public void onConnected(Bundle dataBundle) {
      // Display the connection status
      log("Connected");

      // Get current location
      Location location = LocationServices.FusedLocationApi.getLastLocation(
            mGoogleApiClient);
      log("Locations (starting with last known):");
      if (location != null) {  
         dumpLocation(location);
      }
      // ...
      // Request update every 1-5 seconds, high accuracy
      LocationRequest locationRequest = LocationRequest.create();
      locationRequest.setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY);
      locationRequest.setInterval(UPDATE_INTERVAL);
      locationRequest.setFastestInterval(FASTEST_INTERVAL);
      LocationServices.FusedLocationApi.requestLocationUpdates(
            mGoogleApiClient, locationRequest, this);
   }



   /**
    * Called by Location Services if the attempt to connect to the
    * location client fails.
    */
   @Override
   public void onConnectionFailed(ConnectionResult connectionResult) {
      // Can it be resolved, for example by installing a new version?
      log("Connection failed");
      if (connectionResult.hasResolution()) {
         try {
            // Start an Activity that tries to resolve the error
            log("Trying to resolve the error...");
            connectionResult.startResolutionForResult(
                  this, CONNECTION_FAILURE_RESOLUTION_REQUEST);
         } catch (IntentSender.SendIntentException e) {
            log("Exception during resolution: " + e.toString());
         }
      } else {
         // No resolution is available
         showErrorDialog(connectionResult.getErrorCode());
      }
   }

   /**
    * Called by Location Services when the client is temporarily in a
    * disconnected state.
    */
   @Override
   public void onConnectionSuspended(int cause) {
      log("Connection suspended");
   }

   /** Handle resolution results from Google Play Services */
   @Override
   protected void onActivityResult(int requestCode, int resultCode,
                                   Intent data) {
      // Decide what to do based on the original request code
      switch (requestCode) {
         case CONNECTION_FAILURE_RESOLUTION_REQUEST:
            // If the result code is OK, try to connect again
            log("Resolution result code is: " + resultCode);
            switch (resultCode) {
               case Activity.RESULT_OK:
                  // Try to connect again here
                  mGoogleApiClient.connect();
                  break;
            }
            break;
      }
   }

   /** Write a string to the output window */
   private void log(String string) {
      long newTime = System.currentTimeMillis();
      mOutput.append(String.format("+%04d: %s\n",
            newTime - mLastTime, string));
      mLastTime = newTime;

      // A little trick to make the text view scroll to the end
      mScroller.post(new Runnable() {
         @Override
         public void run() {
            mScroller.fullScroll(View.FOCUS_DOWN);
         }
      });
   }

   /** Describe the given location, which might be null */
   private void dumpLocation(Location location) {
      if (location == null)
         log("Location[unknown]");
      else
         log(location.toString());
   }

}

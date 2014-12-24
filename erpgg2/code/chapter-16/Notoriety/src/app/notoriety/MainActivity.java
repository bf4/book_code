/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package app.notoriety;

import java.util.List;

import android.app.ActionBar;
import android.app.Activity;
import android.app.Fragment;
import android.content.Context;
import android.location.Criteria;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.support.v4.widget.DrawerLayout;
import android.view.Menu;
import android.view.MenuItem;
import app.notoriety.models.Note;
import app.notoriety.models.NoteList;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesUtil;

public class MainActivity
  extends Activity
  implements NotesDrawerFragment.NoteNavCallback, LocationListener
{
  /**
   * Fragment managing the behaviors, interactions and presentation of the
   * navigation drawer.
   */
  private NotesDrawerFragment mNavigationDrawerFragment;
  private LocationManager locationManager;
  private Location currentLocation;

  /**
   * Used to store the last screen title. For use in {@link #restoreActionBar()}.
   */
  private CharSequence mTitle;
  private NoteList     mNotes;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    int playServiceResult = GooglePlayServicesUtil.isGooglePlayServicesAvailable(this);
    if( playServiceResult != ConnectionResult.SUCCESS ) {
      GooglePlayServicesUtil.getErrorDialog(playServiceResult, this, 1).show();
    }
    setupLocationManager();

    mNotes = new NoteList( this );

    setContentView(R.layout.activity_main);

    mNavigationDrawerFragment = (NotesDrawerFragment)getFragmentManager()
        .findFragmentById(R.id.navigation_drawer);
    mTitle = getTitle();

    // Set up the drawer
    mNavigationDrawerFragment.setUp(R.id.navigation_drawer, 
        (DrawerLayout)findViewById(R.id.drawer_layout));
  }

  @Override
  public String newNote() {
    Note note = new Note().setBody("<New Note>");
    synchronized( this ) {
      if( currentLocation != null ) {
        note.setLatitude( currentLocation.getLatitude() );
        note.setLongitude( currentLocation.getLongitude() );
      }
    }
    mNotes.addNote( note );
    // notify the fragment of the new note
    mNavigationDrawerFragment.addNote( note );
    return note.getId();
  }

  public void updateNote( String noteId, String body ) {
    mNotes.updateNote( noteId, body );
    // notify the fragment of the new note body
    mNavigationDrawerFragment.notesChanged();
  }

  @Override
  public void deleteNote(String noteId) {
    mNotes.deleteNote( noteId );
    mNavigationDrawerFragment.notesChanged();
    getFragmentManager()
      .beginTransaction()
      .replace(R.id.container, new Fragment())
      .commit();
  }

  @Override
  public void onNoteSelected( String id ) {
    Note note = null;
    if( mNotes != null ) {
      note = mNotes.get( id );
    }
    if( note == null ) {
      return;
    }
    // update the main content by replacing fragments
    getFragmentManager()
      .beginTransaction()
      .replace(R.id.container, NoteFragment.newInstance(note))
      .commit();
  }

  public void onSectionAttached( String id ) {
    if( mNotes != null ) {
      Note note = mNotes.get( id );
      mTitle = note.getTitle();
    }
  }

  public void restoreActionBar() {
    ActionBar actionBar = getActionBar();
    actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_STANDARD);
    actionBar.setDisplayShowTitleEnabled(true);
    actionBar.setTitle(mTitle);
  }

  @Override
  public boolean onCreateOptionsMenu(Menu menu) {
    if( !mNavigationDrawerFragment.isDrawerOpen() ) {
      // Only show items in the action bar relevant to this screen
      // if the drawer is not showing. Otherwise, let the drawer
      // decide what to show in the action bar.
      getMenuInflater().inflate(R.menu.main, menu);
      restoreActionBar();
      return true;
    }
    return super.onCreateOptionsMenu(menu);
  }
  
  @Override
  public boolean onOptionsItemSelected(MenuItem item) {
    // Handle action bar item clicks here. The action bar will
    // automatically handle clicks on the Home/Up button, so long
    // as you specify a parent activity in AndroidManifest.xml.
    switch( item.getItemId() ) {
    case R.id.action_new_note:
      String id = newNote();
      if (mNavigationDrawerFragment != null) {
        mNavigationDrawerFragment.selectNote( id );
      }
      return true;
    default:
      return super.onOptionsItemSelected(item);
    }
  }

  private void setupLocationManager() {
    locationManager = (LocationManager)getSystemService(Context.LOCATION_SERVICE);

    Criteria criteria = new Criteria();
    criteria.setAccuracy( Criteria.ACCURACY_COARSE );

    List<String> providers = locationManager.getProviders(criteria, true);
    for( String provider : providers ) {
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
    currentLocation = location;
  }
}
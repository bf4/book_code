/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.notoriety;

import java.util.ArrayList;
import java.util.List;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.location.Criteria;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.media.AudioManager;
import android.net.Uri;
import android.os.Bundle;
import android.speech.RecognizerIntent;
import android.speech.tts.TextToSpeech;
import android.view.Menu;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import app.notoriety.models.Note;
import app.notoriety.models.NoteList;

import com.google.android.glass.media.Sounds;
import com.google.android.glass.touchpad.Gesture;
import com.google.android.glass.touchpad.GestureDetector;
import com.google.android.glass.view.WindowUtils;
import com.google.android.glass.widget.CardBuilder;
import com.google.android.glass.widget.CardBuilder.Layout;
import com.google.android.glass.widget.CardScrollAdapter;
import com.google.android.glass.widget.CardScrollView;

public class MainActivity
  extends Activity
  implements GestureDetector.BaseListener,
             TextToSpeech.OnInitListener,
             LocationListener
{
  private static final int SPEECH_REQ_CODE = 101;

  private GestureDetector    mGestureDetector;
  private AudioManager       mAudioManager;
  private TextToSpeech       mTTS;
  private LocationManager    mLocationManager;
  private CardScrollView     mScrollView;
  private NotesScrollAdapter mAdapter;
  private NoteList           mNotes;
  private Location           mCurrentLocation;
  private List<CardBuilder>  mCards;
  private boolean            mEmptyCardsList = true;
  private boolean            mTTSInit;

  class NotesScrollAdapter
    extends CardScrollAdapter
  {
    @Override
    public int getPosition(Object item) {
      return mCards.indexOf(item);
    }
    @Override
    public int getCount() {
      return mCards.size();
    }
    @Override
    public Object getItem(int position) {
      return mCards.get(position);
    }
    @Override
    public int getViewTypeCount() {
      return CardBuilder.getViewTypeCount();
    }
    @Override
    public int getItemViewType(int position){
      return mCards.get(position).getItemViewType();
    }
    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
      return mCards.get(position).getView(convertView, parent);
    }
  }

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    getWindow().requestFeature( WindowUtils.FEATURE_VOICE_COMMANDS );
    setupManagers();
    mNotes = new NoteList( this );
    mCards = new ArrayList<>();
    for( Note note : mNotes ) {
      addNoteCardToAdapter( note );
    }
    if( mEmptyCardsList ) {
      mCards.add( new CardBuilder(this, Layout.TEXT).setText("[tap to add a note]") );
    }
    mAdapter = new NotesScrollAdapter();
    mAdapter.notifyDataSetChanged();
    mScrollView = new CardScrollView( this );
    mScrollView.setAdapter( mAdapter );
    mScrollView.setHorizontalScrollBarEnabled( true );
    mScrollView.activate();
    setContentView( mScrollView );
  }

  private void setupManagers() {
    mGestureDetector = new GestureDetector(this).setBaseListener(this);
    mTTS = new TextToSpeech(this, this);
    mLocationManager = setupLocationManager();
    mAudioManager = (AudioManager)getSystemService(Context.AUDIO_SERVICE);
  }

  @Override
  protected void onDestroy() {
    super.onDestroy();
    if( mTTS != null ) {
      mTTS.stop();
      mTTS.shutdown();
    }
    if( mLocationManager != null ) {
      mLocationManager.removeUpdates( this );
    }
  }

  private void addNoteCardToAdapter( Note note ) {
    CardBuilder cb = new CardBuilder( this, Layout.TEXT );
    cb.setText( note.getBody() );
    if( mEmptyCardsList ) {
      mCards.clear();
      mEmptyCardsList = false;
    }
    mCards.add( cb );
  }

  @Override
  public boolean onCreatePanelMenu(int featureId, Menu menu) {
    if( featureId == WindowUtils.FEATURE_VOICE_COMMANDS ||
        featureId == Window.FEATURE_OPTIONS_PANEL ) {
      getMenuInflater().inflate( R.menu.main, menu );
      return true;
    }
    return false;
  }

  @Override
  public boolean onMenuItemSelected( int featureId, MenuItem item ) {
    if( featureId == WindowUtils.FEATURE_VOICE_COMMANDS ||
        featureId == Window.FEATURE_OPTIONS_PANEL ) {
      Note currentNote = getSelectedNote();
      switch( item.getItemId() ) {
      case R.id.action_new_note:
        Intent intent = new Intent( RecognizerIntent.ACTION_RECOGNIZE_SPEECH );
        startActivityForResult( intent, SPEECH_REQ_CODE );
        break;
      // ... other menu action cases...
      case R.id.action_read_note:
        if( mTTSInit && currentNote != null ) {
          mTTS.speak(currentNote.getBody(), TextToSpeech.QUEUE_FLUSH, null);
        }
        break;
      case R.id.action_delete_note:
        if( currentNote != null ) {
        int selectedNotePos = mScrollView.getSelectedItemPosition();
        mNotes.deleteNote( currentNote.getId() );
        mCards.remove( selectedNotePos );
        mAdapter.notifyDataSetChanged();
        }
        break;
      case R.id.action_map:
        if( currentNote != null ) {
        String nav = String.format("google.navigation:ll=%s,%s",
            currentNote.getLatitude(), currentNote.getLongitude() );
        Intent mapIntent = new Intent( Intent.ACTION_VIEW, Uri.parse(nav) );
        startActivity( mapIntent );
        }
        break;
      }
    }
    return super.onMenuItemSelected(featureId, item);
  }

  private Note getSelectedNote() {
    int selectedNotePos = mScrollView.getSelectedItemPosition();
    // HACK: poor man's note position retrieval, better to keep track
    int pos = 0;
    for( Note note : mNotes.allNotes().values() ) {
      if( selectedNotePos > pos++ ) continue;
      return note;
    }
    return null;
  }
  
  @Override
  public boolean onGenericMotionEvent(MotionEvent event) {
    return mGestureDetector.onMotionEvent(event);
  }

  @Override
  public boolean onGesture( Gesture gesture ) {
    switch( gesture ) {
    case TAP:
      mAudioManager.playSoundEffect( Sounds.TAP );
      openOptionsMenu();
      return true;
    default:
      return false;
    }
  }

  protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    if( resultCode == RESULT_OK && requestCode == SPEECH_REQ_CODE ) {
      List<String> results =
          data.getStringArrayListExtra( RecognizerIntent.EXTRA_RESULTS );
      if( !results.isEmpty() ) {
        String body = results.get( 0 );
        Note note = new Note().setBody( body );
        if( mCurrentLocation != null ) {
          note.setLatitude( mCurrentLocation.getLatitude() );
          note.setLongitude( mCurrentLocation.getLongitude() );
        }
        mNotes.addNote( note );
        addNoteCardToAdapter( note );
        mAdapter.notifyDataSetChanged();
      }
    }
  }

  private LocationManager setupLocationManager() {
    mLocationManager = (LocationManager)getSystemService(Context.LOCATION_SERVICE);
    Criteria criteria = new Criteria();
    criteria.setAccuracy( Criteria.ACCURACY_COARSE );
    List<String> providers = mLocationManager.getProviders(criteria, true);
    for( String provider : providers ) {
      mLocationManager.requestLocationUpdates(provider, 15*1000, 100, this);
    }
    return mLocationManager;
  }

  @Override
  public void onStatusChanged(String provider, int stat, Bundle extras) { }

  @Override
  public void onProviderEnabled(String provider) { }

  @Override
  public void onProviderDisabled(String provider) { }

  @Override
  public void onLocationChanged(Location location) {
    mCurrentLocation = location;
  }

  @Override
  public void onInit( int status ) {
    mTTSInit = mTTSInit || status == TextToSpeech.SUCCESS;
  }
}
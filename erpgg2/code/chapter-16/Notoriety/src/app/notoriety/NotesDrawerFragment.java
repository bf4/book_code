/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package app.notoriety;

import java.util.ArrayList;
import java.util.List;

import android.app.ActionBar;
import android.app.Activity;
import android.app.Fragment;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.Configuration;
import android.os.Bundle;
import android.os.Handler;
import android.preference.PreferenceManager;
import android.support.v4.app.ActionBarDrawerToggle;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import app.notoriety.models.Note;
import app.notoriety.models.NoteList;

import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.GoogleMapOptions;
import com.google.android.gms.maps.MapFragment;
import com.google.android.gms.maps.model.CameraPosition;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;

/**
 * Fragment used for managing interactions for and presentation of a navigation
 * drawer. See the <a href=
 * "https://developer.android.com/design/patterns/navigation-drawer.html#Interaction"
 * > design guidelines</a> for a complete explanation of the behaviors
 * implemented here.
 */
public class NotesDrawerFragment
  extends Fragment
{
  /**
   * Remember the position of the selected item.
   */
  private static final String   STATE_SELECTED_POSITION  = "selected_navigation_drawer_position";

  /**
   * Per the design guidelines, you should show the drawer on launch until the
   * user manually expands it. This shared preference tracks this.
   */
  private static final String   PREF_USER_LEARNED_DRAWER = "navigation_drawer_learned";

  /**
   * A pointer to the current callback instance (the Activity).
   */
  private NoteNavCallback       mCallback;
  
  /**
   * Helper component that ties the action bar to the navigation drawer.
   */
  private ActionBarDrawerToggle mDrawerToggle;

  private DrawerLayout          mDrawerLayout;
  private ListView              mDrawerListView;
  private View                  mFragmentContainerView;
  private String                mCurrentSelectedId;
  private boolean               mFromSavedInstanceState;
  private boolean               mUserLearnedDrawer;
  private NoteList              mNotes;
  private NoteListAdapter       mAdapter;

  private class NoteListAdapter
    extends ArrayAdapter<Note>
  {
    public NoteListAdapter( Context context, List<Note> notes) {
      super(context, android.R.layout.simple_list_item_activated_1, notes);
    }
  }

  /**
   * inform the adapter that a new note was added
   * @param note
   */
  public void addNote( Note note ) {
    if( mAdapter != null ) {
      mAdapter.add( note );
    }
  }

  public void notesChanged() {
    if( mAdapter != null ) {
      mAdapter.notifyDataSetChanged();
    }
  }

  @Override
  public void onCreate( Bundle savedInstanceState ) {
    super.onCreate(savedInstanceState);

    mNotes = new NoteList( getActivity() );

    // Read in the flag indicating whether or not the user has demonstrated
    // awareness of the drawer. See PREF_USER_LEARNED_DRAWER for details.
    SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(getActivity());
    mUserLearnedDrawer = sp.getBoolean(PREF_USER_LEARNED_DRAWER, false);
  
    if (savedInstanceState != null) {
      mCurrentSelectedId = savedInstanceState.getString(STATE_SELECTED_POSITION);
      mFromSavedInstanceState = true;
    }
    if( mCurrentSelectedId != null ) {
      selectNote( mCurrentSelectedId );
    }
  }

  @Override
  public void onActivityCreated( Bundle savedInstanceState ) {
    super.onActivityCreated(savedInstanceState);
    // Indicate that this fragment would like to influence the set of
    // actions in the action bar.
    setHasOptionsMenu(true);
  }

  @Override
  public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState)
  {
    mDrawerListView = (ListView) inflater.inflate(R.layout.fragment_navigation_drawer, container, false);
    mDrawerListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
      @Override
      public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        if( mAdapter != null ) {
          Note note = mAdapter.getItem(position);
          selectNote( note.getId() );
        }
      }
    });
    List<Note> notes = new ArrayList<Note>(mNotes.allNotes().values());
    mAdapter = new NoteListAdapter( getActionBar().getThemedContext(), notes );
    if( !notes.isEmpty() ) {
      mCurrentSelectedId = notes.get(0).getId();
    }
    mDrawerListView.setAdapter( mAdapter );
    mDrawerListView.setItemChecked( 0, true );
    return mDrawerListView;
  }

  public boolean isDrawerOpen() {
    return mDrawerLayout != null
        && mDrawerLayout.isDrawerOpen(mFragmentContainerView);
  }

  /**
   * Users of this fragment must call this method to set up the navigation drawer
   * interactions.
   * 
   * @param fragmentId
   *          The android:id of this fragment in its activity's layout.
   * @param drawerLayout
   *          The DrawerLayout containing this fragment's UI.
   */
  public void setUp(int fragmentId, DrawerLayout drawerLayout) {
    mFragmentContainerView = getActivity().findViewById(fragmentId);
    mDrawerLayout = drawerLayout;
  
    // set a custom shadow that overlays the main content when the drawer opens
    mDrawerLayout.setDrawerShadow(R.drawable.drawer_shadow, GravityCompat.START);
    // set up the drawer's list view with items and click listener

    ActionBar actionBar = getActionBar();
    actionBar.setDisplayHomeAsUpEnabled(true);
    actionBar.setHomeButtonEnabled(true);

    // ActionBarDrawerToggle ties together the the proper interactions
    // between the navigation drawer and the action bar app icon.
    mDrawerToggle = new ActionBarDrawerToggle(
      getActivity(), // host Activity
      mDrawerLayout, // DrawerLayout object
      R.drawable.ic_drawer, // nav drawer image to replace 'Up' caret
      R.string.navigation_drawer_open, // "open drawer" description for accessibility
      R.string.navigation_drawer_close // "close drawer" description for accessibility
    ) {
      @Override
      public void onDrawerClosed(View drawerView) {
        super.onDrawerClosed(drawerView);
        if (!isAdded()) {
          return;
        }
        getActivity().invalidateOptionsMenu(); // calls onPrepareOptionsMenu()
      }
  
      @Override
      public void onDrawerOpened(View drawerView) {
        super.onDrawerOpened(drawerView);
        if (!isAdded()) {
          return;
        }
        if( !mUserLearnedDrawer ) {
          // The user manually opened the drawer; store this flag to prevent
          // auto-showing
          // the navigation drawer automatically in the future.
          mUserLearnedDrawer = true;
          SharedPreferences sp = PreferenceManager
              .getDefaultSharedPreferences(getActivity());
          sp.edit().putBoolean(PREF_USER_LEARNED_DRAWER, true).apply();
        }
        getActivity().invalidateOptionsMenu(); // calls onPrepareOptionsMenu()
      }
    };
    // If the user hasn't 'learned' about the drawer, open it to introduce them
    // to the drawer, per the navigation drawer design guidelines.
    if (!mUserLearnedDrawer && !mFromSavedInstanceState) {
      mDrawerLayout.openDrawer(mFragmentContainerView);
    }
    // Defer code dependent on restoration of previous instance state.
    mDrawerLayout.post(new Runnable() {
      @Override
      public void run() {
        mDrawerToggle.syncState();
      }
    });
    mDrawerLayout.setDrawerListener(mDrawerToggle);
  }

  void selectNote( String id ) {
    mCurrentSelectedId = id;
    if( mDrawerListView != null ) {
      // get position from the list 
      int itemPos = 0;
      for( Note note : mNotes ) {
        if( note.getId().equals( id )) break;
        itemPos++;
      }
      mDrawerListView.setItemChecked(itemPos, true);
    }
    if( mDrawerLayout != null ) {
      mDrawerLayout.closeDrawer(mFragmentContainerView);
    }
    if( mCallback != null ) {
      mCallback.onNoteSelected( id );
    }
  }

  @Override
  public void onAttach(Activity activity) {
    super.onAttach(activity);
    try {
      mCallback = (NoteNavCallback)activity;
    } catch( ClassCastException e ) {
      throw new ClassCastException(
          "Activity must implement NavigationDrawerCallbacks.");
    }
  }

  @Override
  public void onDetach() {
    super.onDetach();
    mCallback = null;
  }

  @Override
  public void onSaveInstanceState(Bundle outState) {
    super.onSaveInstanceState(outState);
    outState.putString(STATE_SELECTED_POSITION, mCurrentSelectedId);
  }

  @Override
  public void onConfigurationChanged(Configuration newConfig) {
    super.onConfigurationChanged(newConfig);
    // Forward the new configuration the drawer toggle component.
    mDrawerToggle.onConfigurationChanged(newConfig);
  }

  @Override
  public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
    // If the drawer is open, show the global app actions in the action bar. See
    // also showGlobalContextActionBar, which controls the top-left area of the
    // action bar.
    if (mDrawerLayout != null && isDrawerOpen()) {
      inflater.inflate(R.menu.global, menu);
      showGlobalContextActionBar();
    }
    super.onCreateOptionsMenu(menu, inflater);
  }

  @Override
  public boolean onOptionsItemSelected(MenuItem item) {
    if( mDrawerToggle.onOptionsItemSelected(item) ) {
      return true;
    }
    switch( item.getItemId() ) {
    case R.id.action_new_note:
      if( mCallback != null ) {
        String id = mCallback.newNote();
        selectNote( id );
      }
      return true;
    case R.id.action_delete_note:
      if( mCallback != null ) {
        mCallback.deleteNote( mCurrentSelectedId );
      }
      return true;
    case R.id.action_map:
      GoogleMapOptions opts = new GoogleMapOptions();
      final Note note = mNotes.get( mCurrentSelectedId );
      LatLng latLng = null;
      if( note != null ) {
        latLng = new LatLng(note.getLatitude(), note.getLongitude());
        CameraPosition cameraPosition = new CameraPosition(latLng, 13, 0, 0);
        opts.camera(cameraPosition);
      }
      final MapFragment mapFragment = MapFragment.newInstance(opts);
      getFragmentManager()
        .beginTransaction()
        .replace(R.id.container, mapFragment)
        .commit();
      // Try adding a marker after the map is loaded
      final Handler handler = new Handler();
      handler.postDelayed(new Runnable() {
        @Override
        public void run() {
          GoogleMap map = mapFragment.getMap();
          if( map == null ) {
            handler.postDelayed(this, 500);
            return;
          }
          LatLng latLng = new LatLng(note.getLatitude(), note.getLongitude());
          map.addMarker(new MarkerOptions().position(latLng).title( note.getTitle() ));
        }
      }, 500);
      return true;
    default:
      return super.onOptionsItemSelected(item);
    }
  }

  /**
   * Per the navigation drawer design guidelines, updates the action bar to show
   * the global app 'context', rather than just what's in the current screen.
   */
  private void showGlobalContextActionBar() {
    ActionBar actionBar = getActionBar();
    actionBar.setDisplayShowTitleEnabled(true);
    actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_STANDARD);
    actionBar.setTitle(R.string.app_name);
  }

  private ActionBar getActionBar() {
    return getActivity().getActionBar();
  }

  /**
   * Callbacks interface that all activities using this fragment must implement.
   */
  public static interface NoteNavCallback {
    void onNoteSelected( String noteId );
    void deleteNote( String noteId );
    String newNote();
  }
}
/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package app.notoriety;

import android.app.Activity;
import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import app.notoriety.models.Note;

/**
 * A placeholder fragment containing a note view.
 */
public class NoteFragment
  extends Fragment
{
  // The fragment argument representing the note id for this fragment.
  public static final String ARG_NOTE_ID = "note_id";
  public static final String ARG_NOTE_OBJ = "note_obj";
  private Note note;

  /**
   * Returns a new instance of this fragment for the given section number.
   */
  public static NoteFragment newInstance(Note note) {
    NoteFragment fragment = new NoteFragment();
    Bundle args = new Bundle();
    args.putString(ARG_NOTE_ID, note.getId());
    args.putSerializable(ARG_NOTE_OBJ, note);
    fragment.setArguments(args);
    return fragment;
  }

  @Override
  public View onCreateView(LayoutInflater inflater,
                           ViewGroup container,
                           Bundle savedInstanceState)
  {
    View rootView = inflater.inflate(R.layout.fragment_main, container, false);
    Note note = getNote();
    final EditText text = (EditText)rootView.findViewById(R.id.body_text);
    if( note != null ) {
      text.setText( note.getBody() );
    }
    final Button button = (Button)rootView.findViewById(R.id.save_button);
    button.setOnClickListener(new Button.OnClickListener() {
      @Override
      public void onClick(View v) {
        // save text to button, and reload this fragment
        String noteId = getArguments().getString(ARG_NOTE_ID);
        String body = text.getText().toString();
        MainActivity activity = (MainActivity)getActivity();
        activity.updateNote( noteId, body );
        activity.onNoteSelected( noteId );
      }
    });
    return rootView;
  }

  private Note getNote() {
    if( note != null ) return note;
    return (Note)getArguments().getSerializable(ARG_NOTE_OBJ);    
  }
  
  @Override
  public void onAttach(Activity activity) {
    super.onAttach(activity);
    ((MainActivity)activity).onSectionAttached(getArguments().getString(ARG_NOTE_ID));
  }
}
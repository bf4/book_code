/***
 * Excerpted from "Hello, Android",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/eband4 for more book information.
***/
package org.example.tictactoe;

import android.app.AlertDialog;
import android.app.Fragment;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

public class MainFragment extends Fragment {

   private AlertDialog mDialog;

   @Override
   public View onCreateView(LayoutInflater inflater, ViewGroup container,
                            Bundle savedInstanceState) {
      View rootView =
            inflater.inflate(R.layout.fragment_main, container, false);
      // Handle buttons here...
      View newButton = rootView.findViewById(R.id.new_button);
      View continueButton = rootView.findViewById(R.id.continue_button);
      View aboutButton = rootView.findViewById(R.id.about_button);
      newButton.setOnClickListener(new View.OnClickListener() {
         @Override
         public void onClick(View view) {
            Intent intent = new Intent(getActivity(), GameActivity.class);
            getActivity().startActivity(intent);
         }
      });
      continueButton.setOnClickListener(new View.OnClickListener() {
         @Override
         public void onClick(View view) {
            Intent intent = new Intent(getActivity(), GameActivity.class);
            intent.putExtra(GameActivity.KEY_RESTORE, true);
            getActivity().startActivity(intent);
         }
      });
      aboutButton.setOnClickListener(new View.OnClickListener() {
         @Override
         public void onClick(View view) {
            AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
            builder.setMessage(R.string.about_text);
            builder.setCancelable(false);
            builder.setPositiveButton(R.string.ok_label,
                  new DialogInterface.OnClickListener() {
                     @Override
                     public void onClick(DialogInterface dialogInterface, int i) {
                        // nothing
                     }
                  });
            mDialog = builder.show();
         }
      });
      return rootView;
   }

   @Override
   public void onPause() {
      super.onPause();

      // Get rid of the about dialog if it's still up
      if (mDialog != null)
         mDialog.dismiss();
   }
}

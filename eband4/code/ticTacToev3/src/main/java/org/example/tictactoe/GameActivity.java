/***
 * Excerpted from "Hello, Android",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/eband4 for more book information.
***/
package org.example.tictactoe;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.os.Bundle;
import android.util.Log;
import android.view.View;

public class GameActivity extends Activity {
   // ...
   public static final String KEY_RESTORE = "key_restore";
   public static final String PREF_RESTORE = "pref_restore";
   private GameFragment mGameFragment;

   @Override
   protected void onCreate(Bundle savedInstanceState) {
      super.onCreate(savedInstanceState);
      setContentView(R.layout.activity_game);
      // Restore game here...
      mGameFragment = (GameFragment) getFragmentManager()
            .findFragmentById(R.id.fragment_game);
      boolean restore = getIntent().getBooleanExtra(KEY_RESTORE, false);
      if (restore) {
         String gameData = getPreferences(MODE_PRIVATE)
               .getString(PREF_RESTORE, null);
         if (gameData != null) {
            mGameFragment.putState(gameData);
         }
      }
      Log.d("UT3", "restore = " + restore);
   }

   public void restartGame() {
      mGameFragment.restartGame();
   }

   public void reportWinner(final Tile.Owner winner) {
      AlertDialog.Builder builder = new AlertDialog.Builder(this);
      builder.setMessage(getString(R.string.declare_winner, winner));
      builder.setCancelable(false);
      builder.setPositiveButton(R.string.ok_label,
            new DialogInterface.OnClickListener() {
               @Override
               public void onClick(DialogInterface dialogInterface, int i) {
                  finish();
               }
            });
      final Dialog dialog = builder.create();
      dialog.show();

      // Reset the board to the initial position
      mGameFragment.initGame();
   }

   public void startThinking() {
      View thinkView = findViewById(R.id.thinking);
      thinkView.setVisibility(View.VISIBLE);
   }

   public void stopThinking() {
      View thinkView = findViewById(R.id.thinking);
      thinkView.setVisibility(View.GONE);
   }

   @Override
   protected void onPause() {
      super.onPause();
      String gameData = mGameFragment.getState();
      getPreferences(MODE_PRIVATE).edit()
            .putString(PREF_RESTORE, gameData)
            .commit();
      Log.d("UT3", "state = " + gameData);
   }
}

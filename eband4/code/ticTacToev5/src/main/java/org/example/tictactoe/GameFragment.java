/***
 * Excerpted from "Hello, Android",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/eband4 for more book information.
***/
package org.example.tictactoe;

import android.app.Fragment;
import android.media.AudioManager;
import android.media.SoundPool;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageButton;

import java.util.HashSet;
import java.util.Set;

public class GameFragment extends Fragment {
   static private int mLargeIds[] = {R.id.large1, R.id.large2, R.id.large3,
         R.id.large4, R.id.large5, R.id.large6, R.id.large7, R.id.large8,
         R.id.large9,};
   static private int mSmallIds[] = {R.id.small1, R.id.small2, R.id.small3,
         R.id.small4, R.id.small5, R.id.small6, R.id.small7, R.id.small8,
         R.id.small9,};
   private Handler mHandler = new Handler();
   private Tile mEntireBoard = new Tile(this);
   private Tile mLargeTiles[] = new Tile[9];
   private Tile mSmallTiles[][] = new Tile[9][9];
   private Tile.Owner mPlayer = Tile.Owner.X;
   private Set<Tile> mAvailable = new HashSet<Tile>();
   private int mSoundX, mSoundO, mSoundMiss, mSoundRewind;
   private SoundPool mSoundPool;
   private float mVolume = 1f;
   private int mLastLarge;
   private int mLastSmall;

   @Override
   public void onCreate(Bundle savedInstanceState) {
      super.onCreate(savedInstanceState);
      // Retain this fragment across configuration changes.
      setRetainInstance(true);
      initGame();
      mSoundPool = new SoundPool(3, AudioManager.STREAM_MUSIC, 0);
      mSoundX = mSoundPool.load(getActivity(), R.raw.sergenious_movex, 1);
      mSoundO = mSoundPool.load(getActivity(), R.raw.sergenious_moveo, 1);
      mSoundMiss = mSoundPool.load(getActivity(), R.raw.erkanozan_miss, 1);
      mSoundRewind = mSoundPool.load(getActivity(), R.raw.joanne_rewind, 1);
   }

   private void clearAvailable() {
      mAvailable.clear();
   }

   private void addAvailable(Tile tile) {
      tile.animate();
      mAvailable.add(tile);
   }

   public boolean isAvailable(Tile tile) {
      return mAvailable.contains(tile);
   }

   @Override
   public View onCreateView(LayoutInflater inflater, ViewGroup container,
                            Bundle savedInstanceState) {
      View rootView =
            inflater.inflate(R.layout.large_board, container, false);
      initViews(rootView);
      updateAllTiles();
      return rootView;
   }

   private void initViews(View rootView) {
      mEntireBoard.setView(rootView);
      for (int large = 0; large < 9; large++) {
         View outer = rootView.findViewById(mLargeIds[large]);
         mLargeTiles[large].setView(outer);

         for (int small = 0; small < 9; small++) {
            ImageButton inner = (ImageButton) outer.findViewById
                  (mSmallIds[small]);
            final int fLarge = large;
            final int fSmall = small;
            final Tile smallTile = mSmallTiles[large][small];
            smallTile.setView(inner);
            // ...
            inner.setOnClickListener(new View.OnClickListener() {
               @Override
               public void onClick(View view) {
                  smallTile.animate();
                  // ...
                  if (isAvailable(smallTile)) {
                     ((GameActivity)getActivity()).startThinking();
                     mSoundPool.play(mSoundX, mVolume, mVolume, 1, 0, 1f);
                     makeMove(fLarge, fSmall);
                     think();
                  } else {
                     mSoundPool.play(mSoundMiss, mVolume, mVolume, 1, 0, 1f);
                  }
               }
            });
            // ...
         }
      }
   }

   private void think() {
      mHandler.postDelayed(new Runnable() {
         @Override
         public void run() {
            if (getActivity() == null) return;
            if (mEntireBoard.getOwner() == Tile.Owner.NEITHER) {
               int move[] = new int[2];
               pickMove(move);
               if (move[0] != -1 && move[1] != -1) {
                  switchTurns();
                  mSoundPool.play(mSoundO, mVolume, mVolume,
                        1, 0, 1f);
                  makeMove(move[0], move[1]);
                  switchTurns();
               }
            }
            ((GameActivity) getActivity()).stopThinking();
         }
      }, 1000);
   }

   private void pickMove(int move[]) {
      Tile.Owner opponent = mPlayer == Tile.Owner.X ? Tile.Owner.O : Tile
            .Owner.X;
      int bestLarge = -1;
      int bestSmall = -1;
      int bestValue = Integer.MAX_VALUE;
      for (int large = 0; large < 9; large++) {
         for (int small = 0; small < 9; small++) {
            Tile smallTile = mSmallTiles[large][small];
            if (isAvailable(smallTile)) {
               // Try the move and get the score
               Tile newBoard = mEntireBoard.deepCopy();
               newBoard.getSubTiles()[large].getSubTiles()[small]
                     .setOwner(opponent);
               int value = newBoard.evaluate();
               Log.d("UT3",
                     "Moving to " + large + ", " + small + " gives value " +
                           "" + value
               );
               if (value < bestValue) {
                  bestLarge = large;
                  bestSmall = small;
                  bestValue = value;
               }
            }
         }
      }
      move[0] = bestLarge;
      move[1] = bestSmall;
      Log.d("UT3", "Best move is " + bestLarge + ", " + bestSmall);
   }

   private void switchTurns() {
      mPlayer = mPlayer == Tile.Owner.X ? Tile.Owner.O : Tile
            .Owner.X;
   }

   private void makeMove(int large, int small) {
      mLastLarge = large;
      mLastSmall = small;
      Tile smallTile = mSmallTiles[large][small];
      Tile largeTile = mLargeTiles[large];
      smallTile.setOwner(mPlayer);
      setAvailableFromLastMove(small);
      Tile.Owner oldWinner = largeTile.getOwner();
      Tile.Owner winner = largeTile.findWinner();
      if (winner != oldWinner) {
         largeTile.animate();
         largeTile.setOwner(winner);
      }
      winner = mEntireBoard.findWinner();
      mEntireBoard.setOwner(winner);
      updateAllTiles();
      if (winner != Tile.Owner.NEITHER) {
         ((GameActivity)getActivity()).reportWinner(winner);
      }
   }

   public void restartGame() {
      mSoundPool.play(mSoundRewind, mVolume, mVolume, 1, 0, 1f);
      // ...
      initGame();
      initViews(getView());
      updateAllTiles();
   }

   public void initGame() {
      Log.d("UT3", "init game");
      mEntireBoard = new Tile(this);
      // Create all the tiles
      for (int large = 0; large < 9; large++) {
         mLargeTiles[large] = new Tile(this);
         for (int small = 0; small < 9; small++) {
            mSmallTiles[large][small] = new Tile(this);
         }
         mLargeTiles[large].setSubTiles(mSmallTiles[large]);
      }
      mEntireBoard.setSubTiles(mLargeTiles);

      // If the player moves first, set which spots are available
      mLastSmall = -1;
      mLastLarge = -1;
      setAvailableFromLastMove(mLastSmall);
   }

   private void setAvailableFromLastMove(int small) {
      clearAvailable();
      // Make all the tiles at the destination available
      if (small != -1) {
         for (int dest = 0; dest < 9; dest++) {
            Tile tile = mSmallTiles[small][dest];
            if (tile.getOwner() == Tile.Owner.NEITHER)
               addAvailable(tile);
         }
      }
      // If there were none available, make all squares available
      if (mAvailable.isEmpty()) {
         setAllAvailable();
      }
   }

   private void setAllAvailable() {
      for (int large = 0; large < 9; large++) {
         for (int small = 0; small < 9; small++) {
            Tile tile = mSmallTiles[large][small];
            if (tile.getOwner() == Tile.Owner.NEITHER)
               addAvailable(tile);
         }
      }
   }

   private void updateAllTiles() {
      mEntireBoard.updateDrawableState();
      for (int large = 0; large < 9; large++) {
         mLargeTiles[large].updateDrawableState();
         for (int small = 0; small < 9; small++) {
            mSmallTiles[large][small].updateDrawableState();
         }
      }
   }

   /** Create a string containing the state of the game. */
   public String getState() {
      StringBuilder builder = new StringBuilder();
      builder.append(mLastLarge);
      builder.append(',');
      builder.append(mLastSmall);
      builder.append(',');
      for (int large = 0; large < 9; large++) {
         for (int small = 0; small < 9; small++) {
            builder.append(mSmallTiles[large][small].getOwner().name());
            builder.append(',');
         }
      }
      return builder.toString();
   }

   /** Restore the state of the game from the given string. */
   public void putState(String gameData) {
      String[] fields = gameData.split(",");
      int index = 0;
      mLastLarge = Integer.parseInt(fields[index++]);
      mLastSmall = Integer.parseInt(fields[index++]);
      for (int large = 0; large < 9; large++) {
         for (int small = 0; small < 9; small++) {
            Tile.Owner owner = Tile.Owner.valueOf(fields[index++]);
            mSmallTiles[large][small].setOwner(owner);
         }
      }
      setAvailableFromLastMove(mLastSmall);
      updateAllTiles();
   }
}


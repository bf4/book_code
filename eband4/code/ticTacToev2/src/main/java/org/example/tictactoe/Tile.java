/***
 * Excerpted from "Hello, Android",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/eband4 for more book information.
***/
package org.example.tictactoe;

import android.graphics.drawable.Drawable;
import android.view.View;
import android.widget.ImageButton;

public class Tile {

   public enum Owner {
      X, O /* letter O */, NEITHER, BOTH
   }

   // These levels are defined in the drawable definitions
   private static final int LEVEL_X = 0;
   private static final int LEVEL_O = 1; // letter O
   private static final int LEVEL_BLANK = 2;
   private static final int LEVEL_AVAILABLE = 3;
   private static final int LEVEL_TIE = 3;

   private final GameFragment mGame;
   private Owner mOwner = Owner.NEITHER;
   private View mView;
   private Tile mSubTiles[];

   public Tile(GameFragment game) {
      this.mGame = game;
   }

   public View getView() {
      return mView;
   }

   public void setView(View view) {
      this.mView = view;
   }

   public Owner getOwner() {
      return mOwner;
   }

   public void setOwner(Owner owner) {
      this.mOwner = owner;
   }

   public Tile[] getSubTiles() {
      return mSubTiles;
   }

   public void setSubTiles(Tile[] subTiles) {
      this.mSubTiles = subTiles;
   }

   public void updateDrawableState() {
      if (mView == null) return;
      int level = getLevel();
      if (mView.getBackground() != null) {
         mView.getBackground().setLevel(level);
      }
      if (mView instanceof ImageButton) {
         Drawable drawable = ((ImageButton) mView).getDrawable();
         drawable.setLevel(level);
      }
   }

   private int getLevel() {
      int level = LEVEL_BLANK;
      switch (mOwner) {
         case X:
            level = LEVEL_X;
            break;
         case O: // letter O
            level = LEVEL_O;
            break;
         case BOTH:
            level = LEVEL_TIE;
            break;
         case NEITHER:
            level = mGame.isAvailable(this) ? LEVEL_AVAILABLE : LEVEL_BLANK;
            break;
      }
      return level;
   }

   private void countCaptures(int totalX[], int totalO[]) {
      int capturedX, capturedO;
      // Check the horizontal
      for (int row = 0; row < 3; row++) {
         capturedX = capturedO = 0;
         for (int col = 0; col < 3; col++) {
            Owner owner = mSubTiles[3 * row + col].getOwner();
            if (owner == Owner.X || owner == Owner.BOTH) capturedX++;
            if (owner == Owner.O || owner == Owner.BOTH) capturedO++;
         }
         totalX[capturedX]++;
         totalO[capturedO]++;
      }

      // Check the vertical
      for (int col = 0; col < 3; col++) {
         capturedX = capturedO = 0;
         for (int row = 0; row < 3; row++) {
            Owner owner = mSubTiles[3 * row + col].getOwner();
            if (owner == Owner.X || owner == Owner.BOTH) capturedX++;
            if (owner == Owner.O || owner == Owner.BOTH) capturedO++;
         }
         totalX[capturedX]++;
         totalO[capturedO]++;
      }

      // Check the diagonals
      capturedX = capturedO = 0;
      for (int diag = 0; diag < 3; diag++) {
         Owner owner = mSubTiles[3 * diag + diag].getOwner();
         if (owner == Owner.X || owner == Owner.BOTH) capturedX++;
         if (owner == Owner.O || owner == Owner.BOTH) capturedO++;
      }
      totalX[capturedX]++;
      totalO[capturedO]++;
      capturedX = capturedO = 0;
      for (int diag = 0; diag < 3; diag++) {
         Owner owner = mSubTiles[3 * diag + (2 - diag)].getOwner();
         if (owner == Owner.X || owner == Owner.BOTH) capturedX++;
         if (owner == Owner.O || owner == Owner.BOTH) capturedO++;
      }
      totalX[capturedX]++;
      totalO[capturedO]++;
   }

   public Owner findWinner() {
      // If owner already calculated, return it
      if (getOwner() != Owner.NEITHER)
         return getOwner();

      int totalX[] = new int[4];
      int totalO[] = new int[4];
      countCaptures(totalX, totalO);
      if (totalX[3] > 0) return Owner.X;
      if (totalO[3] > 0) return Owner.O;

      // Check for a draw
      int total = 0;
      for (int row = 0; row < 3; row++) {
         for (int col = 0; col < 3; col++) {
            Owner owner = mSubTiles[3 * row + col].getOwner();
            if (owner != Owner.NEITHER) total++;
         }
         if (total == 9) return Owner.BOTH;
      }

      // Neither player has won this tile
      return Owner.NEITHER;
   }
}

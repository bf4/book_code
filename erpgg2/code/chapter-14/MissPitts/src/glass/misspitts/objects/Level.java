/***
 * Excerpted from "Programming Google Glass, Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/erpgg2 for more book information.
***/
package glass.misspitts.objects;

import glass.misspitts.objects.Block.Type;

import java.util.ArrayList;
import java.util.Random;

import android.graphics.Canvas;
import android.util.Log;

public class Level {
  private static final int LEVEL_LENGTH = 50;
  private int              levelNumber;
  private ArrayList<Block> blocks;
  private MissPitts        missPitts;

  public Level( int levelNumber, int firstBlock, MissPitts missPitts ) {
    Log.d("glass.misspitts", "level: "+levelNumber);
    this.levelNumber = levelNumber;
    blocks = new ArrayList<Block>();
    this.missPitts = missPitts;
    generateBlocks( firstBlock ); // @see code in Level.java
  }

  public ArrayList<Block> getBlocks() {
    return blocks;
  }
  public Level next() {
    Block block = blocks.get(blocks.size()-1);
    int firstBlock = block.getX() / Block.BLOCK_SIZE + block.getCount() - 1;
    return new Level( levelNumber + 1, firstBlock, missPitts );
  }
  public void update() {
    for( int i = 0; i < blocks.size(); i++ ) {
      blocks.get(i).update();
    }
  }
  public void paint( Canvas c ) {
    for( int i = 0; i < blocks.size(); i++ ) {
      blocks.get(i).paint( c );
    }
  }

  private void generateBlocks( int firstBlock ) {
    Block lastBlock = null;
    int startBlock = 1; // either 1 or 10
    if( levelNumber == 0 ) {
      // start with a 10 length runway
      lastBlock = new Block( 0, 10, Type.BLOCK, missPitts );
      lastBlock.setPointGiven( true );
      blocks.add( lastBlock );
      startBlock = 10;
    }

    // increase the odds you'll encounter a pit in higher levels
    double blockChance = 0.5 - levelNumber * 0.05;
    blockChance = blockChance < 0.1 ? 0.1 : blockChance;

    final Random randBlockWidth = new Random();
    for( int i = startBlock; i < LEVEL_LENGTH; ) {
      // make this random
      Type type = Type.PIT;
      // the longer you go, the chance of 8 lowers
      if( Math.random() <= blockChance ) {
        type = Type.BLOCK;
      }
      // 5 is the longest pit
      int blockWidth = randBlockWidth.nextInt(3) + 2;
      if( lastBlock != null && lastBlock.getType() == type ) {
        lastBlock.addWidth(blockWidth);
      } else {
        lastBlock = new Block( firstBlock+i, blockWidth, type, missPitts );
        blocks.add( lastBlock );
      }
      i += blockWidth;
      if( type == Type.PIT ) {
        // append at least one block at the end of a pit
        lastBlock = new Block( firstBlock+i, 1, Type.BLOCK, missPitts );
        blocks.add( lastBlock );
        i++;
      }
    }
    if( this.levelNumber != 0 ) {
      blocks.get((blocks.size()/2)).setMiddle(true);
    }
  }
}

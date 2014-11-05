/***
 * Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
***/
package arrayaddmoreblocks;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import net.canarymod.plugin.Plugin;
import net.canarymod.logger.Logman;
import net.canarymod.Canary;
import net.canarymod.commandsys.*;
import net.canarymod.chat.MessageReceiver;
import net.canarymod.api.entity.living.humanoid.Player;
import net.canarymod.api.world.position.Location;
import net.canarymod.api.world.blocks.Block;
import net.canarymod.api.world.blocks.BlockType;
import com.pragprog.ahmine.ez.EZPlugin;

public class ArrayAddMoreBlocks extends EZPlugin {

  public static List<BlockType> towerMaterials = new ArrayList<BlockType>();
  public static Location towerLoc = null;
  public static Location towerBase = null;

  public void buildTower(Player me) {
    if (towerLoc == null) {
      towerLoc = new Location(me.getLocation());//(1)
      towerLoc.setX(towerLoc.getX() + 2); // Not right on top of player
      towerBase = new Location(towerLoc);//(2)
    }
    
    towerMaterials.add(BlockType.Glass);
    towerMaterials.add(BlockType.Stone);
    towerMaterials.add(BlockType.OakWood);
        
    for (BlockType material : towerMaterials) {
      logger.info("Building block at " + printLoc(towerLoc));
      setBlockAt(towerLoc, material);
      towerLoc.setY(towerLoc.getY() + 1); // go up one each time
    }    
  }

  public void clearTower() {
    if (towerLoc == null) {
      return;
    }
    while (towerBase.getY() < towerLoc.getY()) {
      setBlockAt(towerBase, BlockType.Air);
      logger.info("Clearing block at " + printLoc(towerBase));
      towerBase.setY(towerBase.getY() + 1); // go up one each time
    } 
    towerLoc = null; // Reset for next tower  
    towerBase = null;
    towerMaterials.clear();
  }  

  @Command(aliases = { "arrayaddmoreblocks" },
            description = "Create and add to an array of blocks",
            permissions = { "" },
            toolTip = "/arrayaddmoreblocks")
  public void arrayaddmoreblocksCommand(MessageReceiver caller, String[] args) {
    if (caller instanceof Player) { 
      Player me = (Player)caller;
      buildTower(me);
    }
  } 
  
  @Command(aliases = { "arrayclearblocks" },
            description = "Clear an array of blocks",
            permissions = { "" },
            toolTip = "/arrayclearblocks")
  public void arrayclearCommand(MessageReceiver caller, String[] args) {
    if (caller instanceof Player) { 
      Player me = (Player)caller;
      clearTower();
    }
  } 
  
}    

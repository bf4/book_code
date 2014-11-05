/***
 * Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
***/
package caketower;

import net.canarymod.plugin.Plugin;
import net.canarymod.logger.Logman;
import net.canarymod.Canary;
import net.canarymod.commandsys.*;
import net.canarymod.chat.MessageReceiver;
import net.canarymod.api.entity.living.humanoid.Player;
import net.canarymod.api.world.position.Location;
import net.canarymod.api.world.blocks.BlockType;
import com.pragprog.ahmine.ez.EZPlugin;

public class CakeTower extends EZPlugin {

  public static int cakeHeight = 100; //(1)

  @Command(aliases = { "caketower" },
            description = "Build a tall tower of cakes",
            permissions = { "" },
            toolTip = "/caketower")
  public void cakeTowerCommand(MessageReceiver caller, String[] parameters) {
    if (caller instanceof Player) {
      Player me = (Player)caller;

      me.chat("1) cake height is " + cakeHeight); // Print it

      cakeHeight = 50;
      
      int cakeHeight;  //(2) 
      cakeHeight = 5;
      me.chat("2) cake height is " + cakeHeight); // Print it
      
      makeCakes(me);

    }
  }
  
  public void makeCakes(Player me) {
    me.chat("3) cake height is " + cakeHeight);  // Print it
    Location loc = me.getLocation();
    loc.setY(loc.getY() + 2);
    setBlockAt(loc, BlockType.Stone);
    for(int i = 0;i < cakeHeight;i++) {
      loc.setY(loc.getY() + 1);
      setBlockAt(loc, BlockType.Cake);
    }
  }
}

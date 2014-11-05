/***
 * Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
***/
package squidbomb; //(1)

import net.canarymod.plugin.Plugin;
import net.canarymod.logger.Logman;
import net.canarymod.Canary;
import net.canarymod.commandsys.*;
import net.canarymod.chat.MessageReceiver;
import net.canarymod.api.entity.living.humanoid.Player;
import net.canarymod.api.world.position.Location;
import net.canarymod.api.world.blocks.Block;
import net.canarymod.api.world.blocks.BlockType;
import net.canarymod.api.entity.EntityType;
import com.pragprog.ahmine.ez.EZPlugin;

public class SquidBomb extends EZPlugin { 
  
  @Command(aliases = { "squidbomb" },
            description = "Drop a fixed number of squid on your head.",
            permissions = { "" },
            toolTip = "/squidbomb")
  public void squidbombCommand(MessageReceiver caller, String[] args) {
    if (caller instanceof Player) { 
      Player me = (Player)caller;
      Location loc = me.getLocation();

      //spawning some squids.  Inky.
      for (int i = 0; i < 10; i++) {
          Location newloc = new Location(
            loc.getX() + (Math.random() * 5), 
            loc.getY() + (Math.random() + 10),
            loc.getZ() + (Math.random() * 5));
         spawnEntityLiving(newloc, EntityType.SQUID);
      }      
    }
  }
}

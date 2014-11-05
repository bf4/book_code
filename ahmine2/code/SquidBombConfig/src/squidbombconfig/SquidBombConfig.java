/***
 * Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
***/
package squidbombconfig;

import java.util.Collection;
import java.util.Iterator;
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
import net.canarymod.api.entity.living.EntityLiving;
import net.canarymod.api.entity.living.animal.Squid;
import com.pragprog.ahmine.ez.EZPlugin;
import net.visualillusionsent.utils.PropertiesFile;

public class SquidBombConfig extends EZPlugin {   
  private static int numSquids;
  private static double squidDropHeight;
  private static boolean setFire;
  
  // Server/config/SquidBombConfig/SquidBombConfig.cfg:
  //    numSquids=6
  //    squidDropHeight=5
  //    setFire=false
  
  public boolean enable() {
    super.enable();//Compiler will call this if you don't
    logger.info("Getting config data");
    PropertiesFile config = getConfig();
    numSquids = config.getInt("numSquids", 6);
    squidDropHeight = config.getDouble("squidDropHeight", 5.0);
    setFire = config.getBoolean("setFire", false);
    config.save(); // Create a new one if needed
    return true;
  }

  @Command(aliases = { "squidbombc" },
            description = "Drop a configurable number of squid on your head.",
            permissions = { "" },
            toolTip = "/squidbombc")
  public void squidbombCommand(MessageReceiver caller, String[] args) {
    if (caller instanceof Player) { 
      Player me = (Player)caller;
      Location loc = me.getLocation();
      double y = loc.getY();
      loc.setY(y + squidDropHeight);  
      me.chat("Spawning " + numSquids + " squid.");
      // Spawning some squid. Derp.
      for (int i = 0; i < numSquids; i++) {
          spawnEntityLiving(loc, EntityType.SQUID);
      }
    }
  } 

  @Command(aliases = { "squidpurge" },
            description = "Get rid of squid.",
            permissions = { "" },
            toolTip = "/squidpurge")
  public void squidpurgeCommand(MessageReceiver caller, String[] args) {
    if (caller instanceof Player) { 
      Player me = (Player)caller;    
 
      Collection<EntityLiving> squidlist = me.getWorld().getEntityLivingList();
      for (EntityLiving entity : squidlist) {
        if (entity instanceof Squid) {
          Squid victim = (Squid)entity;
          if (setFire) {
            victim.setFireTicks(600);
          } else {
            victim.setHealth(0.0f);
          }
        }
      } 
    }
  }
}


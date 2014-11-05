/***
 * Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
***/
package creepercow;

import java.util.HashMap;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Collection;
import net.canarymod.plugin.Plugin;
import net.canarymod.logger.Logman;
import net.canarymod.Canary;
import net.canarymod.commandsys.*;
import net.canarymod.chat.MessageReceiver;
import net.canarymod.api.entity.Entity;
import net.canarymod.api.entity.living.humanoid.Player;
import net.canarymod.api.world.World;
import net.canarymod.api.world.position.Location;
import net.canarymod.api.world.position.Vector3D;
import net.canarymod.hook.HookHandler;
import net.canarymod.api.inventory.ItemType;
import net.canarymod.api.world.blocks.Block;
import net.canarymod.api.world.blocks.BlockType;
import net.canarymod.api.entity.EntityType;
import net.canarymod.api.entity.living.animal.Cow;
import net.canarymod.api.entity.EntityType;
import net.canarymod.plugin.PluginListener;
import net.canarymod.hook.world.ChunkLoadedHook;
import net.canarymod.hook.world.ChunkCreatedHook;
import net.canarymod.hook.world.ChunkUnloadHook;
import net.canarymod.hook.entity.DamageHook;
import net.canarymod.api.DamageType;
import net.canarymod.api.world.Chunk;
import com.pragprog.ahmine.ez.EZPlugin;

public class CreeperCow extends EZPlugin implements PluginListener {
  
  private static HashMap<Cow, CreeperCowTimer> allCows = 
    new HashMap<Cow, CreeperCowTimer>();
    
  private static boolean enabled = false;
        
  private final static int CHUNK_SIZE = 16;
  
  @Override
  public boolean enable() {  
    Canary.hooks().registerListener(this, this);
    return super.enable(); // Call parent class's version too.
  } 
  
  public void spawnCows(Location target, int size, int count) {
    World world = target.getWorld();
    double x = target.getX();
    double z = target.getZ();
    for (int i=0; i< count; i++) {
      Location loc = new Location(world,
        x + (Math.random() * size),
        0,
        z + (Math.random() * size),
        0,0
      );
      loc.setY(world.getHighestBlockAt((int)loc.getX(), (int)loc.getZ()) + 2);
      logger.info("[CreeperCow] spawned cow at " + printLoc(loc));
      Cow cow = (Cow)spawnEntityLiving(loc, EntityType.COW);
      CreeperCowTimer task = new CreeperCowTimer(this, cow);
      Canary.getServer().addSynchronousTask(task);
      allCows.put(cow, task);
    }
  }
  
  public void cowDied(Cow cow) {
    logger.info("[CreeperCow] cow died.");
    allCows.remove(cow);
  }

  @Command(aliases = { "creepercows" },
      description = "Turn Creeper Cows on and off",
      permissions = { "" },
      min = 2, // Number of arguments
      toolTip = "/creepercows on|off")
  public void enabledCommand(MessageReceiver caller, String[] args) {
    if (caller instanceof Player) { 
      Player me = (Player)caller;
      if (args[1].equalsIgnoreCase("on") || 
        args[1].equalsIgnoreCase("yes") || 
        args[1].equalsIgnoreCase("true")) {
        enabled = true;
        me.chat("Creeper Cows are enabled");
        // Start off with a few right here ;)
        spawnCows(me.getLocation(), 25, 5);
      } else {
        enabled = false;
        me.chat("Creeper Cows are disabled");
      }
    }
  }
  
  @Command(aliases = { "testspawncows" },
      description = "Test cow spawning",
      permissions = { "" },
      min = 3, // Number of arguments
      toolTip = "/testspawncows <size of square> <number to spawn>")
  public void testSpawnCommand(MessageReceiver caller, String[] args) {
    if (caller instanceof Player) { 
      Player me = (Player)caller;       
      Location loc = me.getLocation();
      spawnCows(loc,
          Integer.parseInt(args[1]), 
          Integer.parseInt(args[2]));
    }
  }

  @Command(aliases = { "testjump" },
      description = "Test cow jumping",
      permissions = { "" },
      min = 1, // Number of arguments
      toolTip = "/testjump")
  public void testJumpCommand(MessageReceiver caller, String[] args) {
    if (caller instanceof Player) { 
      Player me = (Player)caller; 
      for (Cow c : allCows.keySet()) {
        CreeperCowTimer superCow = allCows.get(c);
        superCow.jump(me.getLocation());
      }
    }
  }
 
  @Command(aliases = { "testexplode" },
      description = "Test cow explode",
      permissions = { "" },
      min = 1, // Number of arguments
      toolTip = "/testexplode")
  public void testExplodeCommand(MessageReceiver caller, String[] args) {
    if (caller instanceof Player) { 
      Player me = (Player)caller; 
      List<CreeperCowTimer> list = new ArrayList<CreeperCowTimer>();
      for (Cow c : allCows.keySet()) {
        CreeperCowTimer superCow = allCows.get(c);
        list.add(superCow);
      }  
      for (CreeperCowTimer superCow : list) {
        superCow.explode();
      }
    }    
  }  
 
  @HookHandler
  public void onChunkLoad(ChunkLoadedHook event) {
    if (enabled) {
      World world = event.getWorld();
      Chunk chunk = event.getChunk();
      
      if (Math.random() > 0.10) { // Only make a cow 1 in 10
        return;
      }
      logger.info("[CreeperCow] Spawning");
      // The X and Z from the chunk are indexes;
      // we have to multiply by 16 to get an actual
      // block location.
      Location start = new Location( 
          chunk.getX() * CHUNK_SIZE,
          0,
          chunk.getZ() * CHUNK_SIZE);
      spawnCows(start, 16, 1);
    }
  } 
  
  @HookHandler
  public void onChunkUnload(ChunkUnloadHook event) {
    Chunk chunk = event.getChunk();
    List<Entity>[] all = chunk.getEntityLists();
    for(int i = 0; i < all.length; i++) {
      for (Entity ent : all[i]) { // List of 16 block subchunks
        if (ent instanceof Cow) {
          Cow cow = (Cow) ent;
          if (allCows.containsKey(cow)) {
            allCows.get(cow).removeMe();
            allCows.remove(cow);
          }
        }
      }
    }
  }

  @HookHandler
  public void onEntityDamage(DamageHook event) {
    Entity ent = event.getDefender();
    if (ent instanceof Cow) {
      Cow cow = (Cow) ent;
      if (event.getDamageSource().getDamagetype() == DamageType.FALL) {
        if (allCows.containsKey(cow)) {
          event.setCanceled();
        }
      }
    }
  }

}

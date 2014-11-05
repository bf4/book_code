/***
 * Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
***/
package com.pragprog.ahmine.ez;
import net.canarymod.plugin.Plugin;
import net.canarymod.logger.Logman;
import net.canarymod.Canary;
import net.canarymod.commandsys.CommandListener;
import net.canarymod.commandsys.CommandDependencyException;
import net.canarymod.chat.MessageReceiver;
import net.canarymod.api.world.position.Location;
import net.canarymod.api.entity.living.humanoid.Player;
import net.canarymod.api.world.effects.SoundEffect;
import net.canarymod.api.factory.EntityFactory;
import net.canarymod.api.entity.EntityType;
import net.canarymod.api.entity.living.LivingBase;
import net.canarymod.api.entity.living.EntityLiving;
import net.canarymod.api.world.effects.Particle;
import net.canarymod.api.world.effects.Particle.Type;
import net.canarymod.api.world.blocks.Block;
import net.canarymod.api.world.blocks.BlockType;
import net.canarymod.api.world.position.Vector3D;

public class EZPlugin extends Plugin implements CommandListener {
  /* Boilerplate methods for all of our plugins */
  public static Logman logger;
    
  public EZPlugin() { 
    logger = getLogman();
  }
  
  @Override
  public boolean enable() { 
    logger.info ("Starting up"); 
    try {
      Canary.commands().registerCommands(this, this, false);
    } catch (CommandDependencyException e) {
      logger.error("Duplicate command name");
    }
    return true;
  }
  
  @Override
  public void disable() {
  }
  
  /**************************************************
   * Convenience helper methods you can call from 
   * within our plugins, or anywhere else as EZ.name
   **************************************************/
  

  /* Warning, doing a Block.setType doesn't work as expected. */
  public static void setBlockAt(Location loc, BlockType type) {
    loc.getWorld().setBlockAt(loc, type);
  }
  
 
  public static void playSound(Location loc,
                               SoundEffect.Type type,
                               double volume,
                               double pitch) {
    loc.getWorld().playSound(new SoundEffect(type, 
      loc.getX(), 
      loc.getY(), 
      loc.getZ(), (float)volume, (float)pitch));
  }
  
  public static void playSound(Location loc,
                               SoundEffect.Type type) {
    playSound(loc, type, 1.0, 1.0);
  }
  

  /* Pass in the entity type as EntityType.COW, etc. */
  /* You may need to cast the result to the specific entity, e.g (Cow) */
  public static EntityLiving spawnEntityLiving(Location loc, EntityType type) {
    EntityFactory factory = Canary.factory().getEntityFactory();
    EntityLiving thing = factory.newEntityLiving(type, loc);
    thing.spawn();
    return thing;
  }
  

  public static void spawnParticle(Location loc, Particle.Type type) {
    loc.getWorld().spawnParticle(new Particle(loc.getX(), 
      loc.getY(), loc.getZ(), type));
  }
    
  public static void fling(LivingBase player, LivingBase entity, double factor) {
    double pitch = (player.getPitch() + 90.0F) * Math.PI / 180.0D;
    double rot = (player.getRotation() + 90.0F) * Math.PI / 180.0D;
    double x = Math.sin(pitch) * Math.cos(rot);
    double z = Math.sin(pitch) * Math.sin(rot);
    double y = Math.cos(pitch);
 
    entity.moveEntity(x * factor, y + 0.5, z * factor);
  }
  
  public static String printLoc(Location loc) {
    return "" + (int)loc.getX() + ", " +
    (int)loc.getY() + ", " +
    (int)loc.getZ();
  }
      
}

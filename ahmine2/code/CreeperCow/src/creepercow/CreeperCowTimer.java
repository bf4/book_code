/***
 * Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
***/
package creepercow;

import java.util.List;
import java.util.ArrayList;
import net.canarymod.Canary;
import net.canarymod.api.entity.EntityType;
import net.canarymod.api.world.position.Location;
import net.canarymod.api.entity.living.humanoid.Player;
import net.canarymod.api.entity.living.animal.Cow;
import net.canarymod.api.world.position.Vector3D;
import net.canarymod.api.world.blocks.Block;
import net.canarymod.api.world.blocks.BlockType;
import net.canarymod.tasks.ServerTask;
import com.pragprog.ahmine.ez.EZPlugin;


public class CreeperCowTimer extends ServerTask {
  private Cow cow;
  private CreeperCow plugin;
  
  CreeperCowTimer(CreeperCow parentPlugin, Cow aCow) {
    super(Canary.getServer(), 0, true); // delay, isContinuous
    cow = aCow;
    plugin = parentPlugin;
  }
  
  public Player getClosestPlayer(Location loc) { //return -1 on failure
    List<Player> list = Canary.getServer().getPlayerList();
    Player closestPlayer = null;
    double minDistance = -1;
    for(int i = 0; i < list.size(); i++) {
      Player p = list.get(i);
      Location ploc = p.getLocation();
      if (Math.abs(ploc.getY() - loc.getY()) < 15) {
        double dist = distance(loc, ploc);
        if (dist < minDistance || minDistance == -1) {
          minDistance = dist;
          closestPlayer = p;
        }
      }
    }
    return closestPlayer;
  }
  //
  // Find the distance on the ground (ignores height)
  // between two Locations
  //
  public double distance(Location loc1, Location loc2) {
    return Math.sqrt(
      Math.pow(loc1.getX() - loc2.getX(), 2) +
      Math.pow(loc1.getZ() - loc2.getZ(), 2)
    );
  }
  
  // Explode yourself
  public void explode() {
    plugin.cowDied(cow); // notify parent
    Location cowLoc = cow.getLocation();
    cow.getWorld().makeExplosion(cow, 
          cowLoc.getX(), cowLoc.getY(), cowLoc.getZ(), 
          3.0f, true);
    removeMe();
  }
  
  // We are all done, either from chunk unload or explosion      
  public void removeMe() {
    cow.kill();
    Canary.getServer().removeSynchronousTask(this);
  }
    
  // Jump this cow toward the target
  public void jump(Location target) {
    Location cowLoc = cow.getLocation();
    double multFactor = 0.075;
    Vector3D v = new Vector3D(
      (target.getX() - cowLoc.getX()) * multFactor,
      0.8,
      (target.getZ() - cowLoc.getZ()) * multFactor
    );
    cow.moveEntity(v.getX() + (Math.random() * -0.1), 
      v.getY(), 
      v.getZ() + (Math.random() * -0.1)); 
  }  
    
  // Callback to run and execute body of task
  public void run() {
    if (cow.isOnGround()) { // otherwise it's still jumping
      Location cowLoc = cow.getLocation();
      Player p = cow.getWorld().getClosestPlayer(cow, 10000);
      if (p == null) {
        return;
      }
      Location pLoc = p.getLocation();
      double dist = distance(cowLoc, pLoc);
    
      if (dist <= 4) {
        explode();
      } else if (dist <= 200) {
        jump(pLoc);
      }
    }
  }
        
}


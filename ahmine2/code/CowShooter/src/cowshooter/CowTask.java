/***
 * Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
***/
package cowshooter;

import net.canarymod.Canary;
import net.canarymod.api.entity.EntityType;
import net.canarymod.api.world.position.Location;
import net.canarymod.api.entity.living.animal.Cow;
import net.canarymod.api.world.position.Vector3D;
import net.canarymod.api.world.blocks.Block;
import net.canarymod.api.world.blocks.BlockType;
import net.canarymod.tasks.ServerTask;
import com.pragprog.ahmine.ez.EZPlugin;

public class CowTask extends ServerTask {
    
    private Cow cow;
        
    public CowTask(Cow myCow) {
        super(Canary.getServer(), 0, true); // delay, isContinuous
        cow = myCow;
    }
    
    public void run() {
      if (cow.isOnGround()) { 
        Location loc = cow.getLocation();
        cow.setHealth(0);
        cow.kill();       
        cow.getWorld().makeExplosion(cow, 
          loc.getX(), loc.getY(), loc.getZ(), 
          2.0f, true);
        Canary.getServer().removeSynchronousTask(this);
      } else {
        cow.setFireTicks(600);
        cow.setHealth((float)cow.getMaxHealth());
      }
    }
}

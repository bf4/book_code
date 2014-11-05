/***
 * Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
***/
package cowshooter;

import java.util.ArrayList;
import java.util.List;

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
import net.canarymod.api.entity.living.LivingBase;
import net.canarymod.api.entity.living.animal.Cow;
import net.canarymod.hook.player.ItemUseHook;
import net.canarymod.plugin.PluginListener;
import com.pragprog.ahmine.ez.EZPlugin;

public class CowShooter extends EZPlugin implements PluginListener {

  @Override
  public boolean enable() {  
    Canary.hooks().registerListener(this, this);
    return super.enable(); // Call parent class's version too.
  }  
   
  @HookHandler
  public void onInteract(ItemUseHook event) {

    Player player = event.getPlayer();

    if (player.getItemHeld().getType() == ItemType.Leather) {
      Location loc = player.getLocation();     
      loc.setY(loc.getY() + 2);
      
      Cow victim = (Cow)spawnEntityLiving(loc, EntityType.COW);//(1)
      
      Canary.getServer().addSynchronousTask(new CowTask(victim));
      
      fling(player, victim, 3);
      victim.setFireTicks(600);
    }
  } 
}

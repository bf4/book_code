/***
 * Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
***/
package firebow; //(1)

import net.canarymod.plugin.Plugin;
import net.canarymod.logger.Logman;
import net.canarymod.Canary;
import net.canarymod.commandsys.*;
import net.canarymod.chat.MessageReceiver;
import net.canarymod.api.entity.Entity;
import net.canarymod.api.entity.living.humanoid.Player;
import net.canarymod.api.world.World;
import net.canarymod.api.world.position.Location;
import net.canarymod.hook.HookHandler;
import net.canarymod.hook.entity.ProjectileHitHook;
import net.canarymod.plugin.PluginListener;
import com.pragprog.ahmine.ez.EZPlugin;

/* With bow in your inventory, hold a right-click to launch arrow */

public class FireBow extends EZPlugin implements PluginListener {
  
  public static boolean enabled = true; // For all players
  
  @Override
  public boolean enable() {  
    Canary.hooks().registerListener(this, this);
    return super.enable(); // Call parent class's version too.
  }  
    
  @HookHandler
  public void onArrowHit(ProjectileHitHook event) {
    if (enabled) {
      Entity arrow = event.getProjectile();
      World world = arrow.getWorld();

      Entity victim = event.getEntityHit();
      Location loc = arrow.getLocation();
      world.makeExplosion(victim, 
          loc.getX(), loc.getY(), loc.getZ(), 
          100.0f, true);

      event.setCanceled();
    }
  }
  
  @Command(aliases = { "nofirebow" },
            description = "Disable firebow behavior",
            permissions = { "" },
            toolTip = "/nofirebow")
  public void nofirebowCommand(MessageReceiver caller, String[] args) {
    if (caller instanceof Player) { 
      Player me = (Player)caller;
      enabled = false;
      logger.info("[FireBow] Turning off arrow -> fireball");  
    }
  }

  @Command(aliases = { "firebow" },
            description = "Enable firebow behavior",
            permissions = { "" },
            toolTip = "/firebow")
  public void firebowCommand(MessageReceiver caller, String[] args) {
    if (caller instanceof Player) { 
      Player me = (Player)caller;
      enabled = true;
      logger.info("[FireBow] Turning on arrow -> fireball");  
    }
  }   
}
   
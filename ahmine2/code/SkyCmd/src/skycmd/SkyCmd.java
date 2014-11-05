/***
 * Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
***/
package skycmd;
import net.canarymod.plugin.Plugin;
import net.canarymod.logger.Logman;
import net.canarymod.Canary;
import net.canarymod.commandsys.*;
import net.canarymod.chat.MessageReceiver;
import net.canarymod.api.entity.living.humanoid.Player;
import net.canarymod.api.world.position.Location;
import net.canarymod.api.entity.living.EntityLiving;
import java.util.List;
import com.pragprog.ahmine.ez.EZPlugin;

public class SkyCmd extends EZPlugin {
  @Command(aliases = { "sky" },//(1)
            description = "Fling all creatures into the air",
            permissions = { "" },
            toolTip = "/sky")
  public void skyCommand(MessageReceiver caller, String[] parameters) {
    if (caller instanceof Player) {//(2) 
      Player me = (Player)caller;//(3)       
      List<EntityLiving> list = me.getWorld().getEntityLivingList();
      for (EntityLiving target : list) {
        if (!(target instanceof Player)) {
          Location loc = target.getLocation();
          double y = loc.getY();
          loc.setY(y+50);
          target.teleportTo(loc);
        }
      }
    }
  }
}

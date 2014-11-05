/***
 * Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
***/
package backcmd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Stack;
import net.canarymod.plugin.Plugin;
import net.canarymod.logger.Logman;
import net.canarymod.Canary;
import net.canarymod.commandsys.*;
import net.canarymod.chat.MessageReceiver;
import net.canarymod.api.entity.living.humanoid.Player;
import net.canarymod.api.world.position.Location;
import net.canarymod.hook.HookHandler;
import net.canarymod.hook.player.TeleportHook;
import net.canarymod.plugin.PluginListener;
import com.pragprog.ahmine.ez.EZPlugin;


public class BackCmd extends EZPlugin implements PluginListener {//(1)
  private static List<Player> isTeleporting = new ArrayList<Player>();//(2)
  private static HashMap<String, Stack<Location>> playerTeleports = 
      new HashMap<String, Stack<Location>>();

  @Override
  public boolean enable() {  
    Canary.hooks().registerListener(this, this);//(3)
    return super.enable(); // Call parent class's version too.
  }  
  
  public boolean equalsIsh(Location loc1, Location loc2) {//(4)
    return ((int) loc1.getX()) == ((int) loc2.getX()) &&
           ((int) loc1.getZ()) == ((int) loc2.getZ());
  }

  @HookHandler
  public void onTeleport(TeleportHook event) {//(5)
    Player player = event.getPlayer();
    if (isTeleporting.contains(player)) {
      isTeleporting.remove(player);
    } else {
      Stack<Location> locs = playerTeleports.get(player.getName());
      if (locs == null) {
        locs = new Stack<Location>();
      }
      locs.push(player.getLocation());
      locs.push(event.getDestination());
      playerTeleports.put(player.getName(), locs);
    }
  }

  @Command(aliases = { "back" },
            description = "Go back to previous places that you teleported to.",
            permissions = { "" },
            toolTip = "/back")
  public void backCommand(MessageReceiver caller, String[] args) {
    if (caller instanceof Player) { 
      Player me = (Player)caller;
  
      Stack<Location> locs = playerTeleports.get(me.getName());
      
      if (locs != null && !locs.empty()) {
        Location loc = locs.peek();  
        while (equalsIsh(loc, me.getLocation()) && locs.size() > 1) {
          locs.pop();
          loc = locs.peek();
        }
        isTeleporting.add(me);
        me.teleportTo(loc);
      } else {
        me.chat("You have not teleported yet.");
      }
    }  
  }
}

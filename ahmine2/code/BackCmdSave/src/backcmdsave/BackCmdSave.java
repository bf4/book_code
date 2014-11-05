/***
 * Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
***/
package backcmdsave;

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


public class BackCmdSave extends EZPlugin implements PluginListener {
  private static List<Player> isTeleporting = new ArrayList<Player>();

  @Override
  public boolean enable() {  
    Canary.hooks().registerListener(this, this);
    return super.enable(); // Call parent class's version too.
  }  

  @HookHandler
  public void onTeleport(TeleportHook event) {
    Player player = event.getPlayer();
    if (isTeleporting.contains(player)) {
      isTeleporting.remove(player);
    } else {
      SavedLocation sp = new SavedLocation(player.getName());
      sp.push(player.getLocation());
    }
  }

  @Command(aliases = { "dback" },
            description = "Go back to previous places that you teleported to.",
            permissions = { "" },
            toolTip = "/dback")
  public void backCommand(MessageReceiver caller, String[] args) {
    if (caller instanceof Player) { 
      Player me = (Player)caller;
  
      SavedLocation sp = new SavedLocation(me.getName());
      Location loc = sp.pop(me.getLocation());
      
      if (loc != null) {
        isTeleporting.add(me);
        me.teleportTo(loc);
      } else {
        me.chat("You have not teleported yet.");
      }
      
    }  
  }
}


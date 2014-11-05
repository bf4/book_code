/***
 * Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
***/
package namedsigns;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import net.canarymod.plugin.Plugin;
import net.canarymod.logger.Logman;
import net.canarymod.Canary;
import net.canarymod.commandsys.*;
import net.canarymod.chat.MessageReceiver;
import net.canarymod.api.entity.living.humanoid.Player;
import net.canarymod.api.world.World;
import net.canarymod.api.world.position.Location;
import net.canarymod.api.world.blocks.Block;
import net.canarymod.api.world.blocks.BlockType;
import net.canarymod.api.world.blocks.Sign;
import com.pragprog.ahmine.ez.EZPlugin;

public class NamedSigns extends EZPlugin {
  private static Map<String,Location> signs = new HashMap<String,Location>();//(1)

  private void usage(Player me) {//(2)
    me.chat("Usage: signs new name");
    me.chat("       signs set name message"); 
  }
  
  private void parseArgs(Player me, String [] args) {    
    if (args.length < 3) {//(3)
      usage(me);
      return;
    }
    if (args[1].equalsIgnoreCase("new")) {
      makeNewSign(me, args);
    }
    if (args[1].equalsIgnoreCase("set")) {
      if (args.length < 4) {//(4)
        usage(me);
        return;
      }
      setSign(me, args);
    }
  }

  // signs new sign_name 
  private void makeNewSign(Player me, String [] args) {//(5) 
    Location loc = me.getLocation();
    loc.setX(loc.getX() + 1); // Not right on top of player
    int y = loc.getWorld().getHighestBlockAt((int)loc.getX(),(int)loc.getZ());
    loc.setY(y);
    signs.put(args[2], loc);
    setBlockAt(loc, BlockType.SignPost);
  }

  // signs set sign_name line1
  private void setSign(Player me, String [] args) {//(6) 
    String name = args[2];
    String msg = args[3];
    if (!signs.containsKey(name)) {
      // No such named sign
      me.chat("No sign named " + name);
      return;
    }
    Location loc = signs.get(name);
    World world = loc.getWorld();
    Sign sign = (Sign)world.getTileEntity(world.getBlockAt(loc));//(7)
    sign.setTextOnLine(msg, 0);
    sign.update();
  }

  @Command(aliases = { "signs" },
            description = "Create and name signposts",
            permissions = { "" },
            toolTip = "/signs new name, or /signs set name message")
  public void signsCommand(MessageReceiver caller, String[] args) {
    if (caller instanceof Player) { 
      Player me = (Player)caller; 
      parseArgs(me, args);
    }
  }
}

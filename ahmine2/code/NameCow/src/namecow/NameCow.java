/***
 * Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
***/
package namecow;
import net.canarymod.plugin.Plugin;
import net.canarymod.logger.Logman;
import net.canarymod.Canary;
import net.canarymod.commandsys.*;
import net.canarymod.chat.MessageReceiver;
import net.canarymod.api.entity.living.humanoid.Player;
import net.canarymod.api.factory.EntityFactory;
import net.canarymod.api.entity.EntityType;
import net.canarymod.api.entity.living.animal.Cow;
import com.pragprog.ahmine.ez.EZPlugin;

public class NameCow extends EZPlugin {

  @Command(aliases = { "namecow" },
            description = "Spawn and name a cow",
            permissions = { "" },
            min = 2,
            toolTip = "/namecow name")
  public void namecowCommand(MessageReceiver caller, String[] args) {
    if (caller instanceof Player) { 
      Player me = (Player)caller;
      
      Cow cow = (Cow)spawnEntityLiving(me.getLocation(), EntityType.COW);
        
      cow.setDisplayName(args[1]);
      cow.setShowDisplayName(true);
    }
  }
}

/***
 * Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
***/
package simple;
import net.canarymod.plugin.Plugin;
import net.canarymod.logger.Logman;
import net.canarymod.Canary;
import net.canarymod.commandsys.*;
import net.canarymod.chat.MessageReceiver;
import net.canarymod.api.entity.living.humanoid.Player;
import com.pragprog.ahmine.ez.EZPlugin;//(1)

public class Simple extends EZPlugin {
  
  @Command(aliases = { "simple" },
            description = "Displays simple variable assignments",
            permissions = { "" },
            toolTip = "/simple")
  public void simpleCommand(MessageReceiver caller, String[] parameters) {
    if (caller instanceof Player) { 
      Player me = (Player)caller;
      // Put your code after this line:
      //(2)
      // ...and finish your code before this line.
    }
  }
}

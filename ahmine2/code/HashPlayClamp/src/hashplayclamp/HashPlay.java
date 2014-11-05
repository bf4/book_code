/***
 * Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
***/
package hashplay;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import net.canarymod.plugin.Plugin;
import net.canarymod.logger.Logman;
import net.canarymod.Canary;
import net.canarymod.commandsys.*;
import net.canarymod.chat.MessageReceiver;
import net.canarymod.api.entity.living.humanoid.Player;
import com.pragprog.ahmine.ez.EZPlugin;

public class HashPlay extends EZPlugin { 
 
  HashMap<String, Integer> currentScores = new HashMap<String, Integer>();
 
   private static int clamp(int score) {
    if (score < 0) {
      score = 0;
    }
    if (score > 1000) {
      score = 1000;
    }
    return score;
  }
   
  public static void addToScore(HashMap<String, Integer> allScores, 
                      String playerName, 
                      int amount) {
    int score = allScores.get(playerName);
    score += amount;
    allScores.put(playerName, clamp(score));
  }

  @Command(aliases = { "hashplay" },
            description = "Play with a Java Hash",
            permissions = { "" },
            toolTip = "/hashplay")
  public void hashplayCommand(MessageReceiver caller, String[] args) {
    if (caller instanceof Player) { 
      Player me = (Player)caller;
       
      currentScores.put("Andy", 1001);
      currentScores.put("Bob", 20);
      currentScores.put("Carol", 50);
      currentScores.put("Alice", 896);    
      addToScore(currentScores, "Bob", 500);
      me.chat("Bob's score is " + currentScores.get("Bob"));
    }
  }
}

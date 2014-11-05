/***
 * Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
***/
package listplay;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import net.canarymod.plugin.Plugin;
import net.canarymod.logger.Logman;
import net.canarymod.Canary;
import net.canarymod.commandsys.*;
import net.canarymod.chat.MessageReceiver;
import net.canarymod.api.entity.living.humanoid.Player;
import net.canarymod.api.world.position.Location;
import net.canarymod.api.world.blocks.Block;
import net.canarymod.api.world.blocks.BlockType;
import com.pragprog.ahmine.ez.EZPlugin;

public class ListPlay extends EZPlugin {

  public void listDemo(Player me) {
    List<String> listOfStrings = new ArrayList<String>(); //(1)
    listOfStrings.add("This"); //(2)
    listOfStrings.add("is");
    listOfStrings.add("a");
    listOfStrings.add("list.");
    
    String third = listOfStrings.get(2);//(3)
    me.chat("The third element is " + third);
    
    me.chat("List contains " + listOfStrings.size() + " elements.");//(4)
    
    listOfStrings.add(3, "fancy"); //(5)
    
    boolean hasIt = listOfStrings.contains("is"); //(6)
    me.chat("Does list contain the word 'is'? " + hasIt);

    hasIt = listOfStrings.contains("kerfluffle");
    me.chat("Does the list contain the word 'kerfluffle'? " + hasIt);
     // Print out each value in the list
    for(String value : listOfStrings) {
      me.chat(value);
    }
     
    listOfStrings.clear(); //(7)
    me.chat("Now it's cleared out, size is " + listOfStrings.size());
    
    hasIt = listOfStrings.contains("is");
    me.chat("List contains the word 'is' now is " + hasIt);
  }

  @Command(aliases = { "listdemo" },
            description = "List play",
            permissions = { "" },
            toolTip = "/listdemo")
  public void listPlayCommand(MessageReceiver caller, String[] args) {
    if (caller instanceof Player) { 
      Player me = (Player)caller;
      listDemo(me);
    }
  }
}

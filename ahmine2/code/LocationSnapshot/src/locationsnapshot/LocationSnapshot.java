/***
 * Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
***/
package locationsnapshot;

import java.util.List;
import java.util.HashMap;
import java.util.Map;
import net.canarymod.Canary;
import net.canarymod.plugin.Plugin;
import net.canarymod.logger.Logman;
import net.canarymod.Canary;
import net.canarymod.commandsys.*;
import net.canarymod.chat.MessageReceiver;
import net.canarymod.api.entity.living.humanoid.Player;
import net.canarymod.api.world.position.Location;
import net.canarymod.database.Database;
import net.canarymod.database.DataAccess;
import net.canarymod.database.exceptions.*;
import com.pragprog.ahmine.ez.EZPlugin;

public class LocationSnapshot extends EZPlugin {

  private void saveLocations() {
    List<Player> playerList = Canary.getServer().getPlayerList();
    // For all players...
    for (Player player : playerList) {
      // Save the raw coordinates, not the Location
      AllPlayerLocations apl = new AllPlayerLocations();
      apl.player_name = player.getDisplayName();
      Location loc = player.getLocation();
      apl.x = loc.getX();
      apl.y = loc.getY();
      apl.z = loc.getZ();

      HashMap<String, Object> search = new HashMap<String, Object>();//(1)
      search.put("player_name", player.getDisplayName());
     
      try {
        Database.get().update(apl, search);//(2) 
      } catch (DatabaseWriteException e) {
        logger.error(e);
        logger.info("error");
      }
    }
  }

  private void loadLocations() {
    //Go through list of players; if they are in the hash, teleport them.
    List<Player> playerList = Canary.getServer().getPlayerList();
    for (Player player : playerList) {
      String name = player.getDisplayName();
      
      AllPlayerLocations apl = new AllPlayerLocations();
      HashMap<String, Object> search = new HashMap<String, Object>();
      search.put("player_name", name);
      
      try {
        Database.get().load(apl, search);
      } catch (DatabaseReadException e) {
        logger.info(name + " is not online");
        continue;
      }
      
      // Reconstitute a Location from coordinates
      Location loc = new Location(apl.x, apl.y, apl.z);
      logger.info("Teleporting " + name + " to " + printLoc(loc));
      player.teleportTo(loc);
    }
  }

  @Command(aliases = { "savelocations" },
      description = "Save locations for all players",
      permissions = { "" },
      toolTip = "/savelocations")
  public void saveCommand(MessageReceiver caller, String[] args) {
    saveLocations();
  }
  
  @Command(aliases = { "loadlocations" },
      description = "Load saved locations for all players and teleport",
      permissions = { "" },
      toolTip = "/loadlocations")
  public void loadCommand(MessageReceiver caller, String[] args) {
    loadLocations();
  }                       
  
}

/***
 * Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
***/
package stuck;

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

public class Stuck extends EZPlugin {

  @Command(aliases = { "stuck" },
            description = "Trap a player in cage of blocks",
            permissions = { "" },
            min = 2,
            toolTip = "/stuck name")
  public void stuckCommand(MessageReceiver caller, String[] args) {
    Player victim = Canary.getServer().getPlayer(args[1]);
    if (victim != null) {
      stuck(victim);
    }
  }

  public void stuck(Player player) {
    Location loc = player.getLocation();
    int playerX = (int) loc.getX(); 
    int playerY = (int) loc.getY(); 
    int playerZ = (int) loc.getZ();
    loc.setX(playerX + 0.5); loc.setY(playerY); loc.setZ(playerZ + 0.5);
    player.teleportTo(loc);

    int[][] offsets = {
     //x,  y,  z
      {0,  -1, 0},
      {0,  2,  0},
      {1,  0,  0},
      {1,  1,  0},
      {-1, 0,  0},
      {-1, 1,  0},
      {0,  0,  1},
      {0,  1,  1},
      {0,  0, -1},
      {0,  1, -1},
    };

    for(int i = 0; i < offsets.length; i++) {
      int x = offsets[i][0]; 
      int y = offsets[i][1]; 
      int z = offsets[i][2];
      setBlockAt(new Location(x+playerX, y+playerY, z+playerZ), 
	BlockType.Stone);
    }
  }
}

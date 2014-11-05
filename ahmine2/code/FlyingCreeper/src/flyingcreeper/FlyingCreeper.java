/***
 * Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
***/
package flyingcreeper;

import net.canarymod.plugin.Plugin;
import net.canarymod.logger.Logman;
import net.canarymod.Canary;
import net.canarymod.commandsys.*;
import net.canarymod.chat.MessageReceiver;
import net.canarymod.api.entity.living.humanoid.Player;
import net.canarymod.api.entity.living.animal.Bat;
import net.canarymod.api.entity.living.monster.Creeper;
import net.canarymod.api.world.position.Location;
import net.canarymod.api.factory.EntityFactory;
import net.canarymod.api.factory.PotionFactory;
import net.canarymod.api.potion.PotionEffect;
import net.canarymod.api.potion.PotionEffectType;
import net.canarymod.api.entity.EntityType;
import net.canarymod.api.entity.living.EntityLiving;
import com.pragprog.ahmine.ez.EZPlugin;

public class FlyingCreeper extends EZPlugin {

  @Command(aliases = { "flyingcreeper" },
            description = "Pure. Terror.",
            permissions = { "" },
            toolTip = "/flyingcreeper")
  public void fcCommand(MessageReceiver caller, String[] args) {
    if (caller instanceof Player) { 
      Player me = (Player)caller;
      Location loc = me.getLocation();
      loc.setY(loc.getY() + 5);
      
      EntityFactory factory = Canary.factory().getEntityFactory();
      EntityLiving bat = factory.newEntityLiving(EntityType.BAT, loc);
      EntityLiving creep = factory.newEntityLiving(EntityType.CREEPER, loc);
      bat.spawn(creep);
    
      PotionFactory potfact = Canary.factory().getPotionFactory();
      PotionEffect potion = 
	potfact.newPotionEffect(PotionEffectType.INVISIBILITY, 
		Integer.MAX_VALUE, 1);
      bat.addPotionEffect(potion);
    }
  }
}

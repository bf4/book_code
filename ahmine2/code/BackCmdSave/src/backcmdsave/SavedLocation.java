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
import net.canarymod.database.Column;
import net.canarymod.database.Column.DataType;
import net.canarymod.database.DataAccess;
import net.canarymod.database.exceptions.*;
import net.canarymod.api.entity.living.humanoid.Player;
import net.canarymod.api.world.position.Location;
import net.canarymod.api.world.World;
import net.canarymod.database.Database;
import net.canarymod.Canary;

public class SavedLocation extends DataAccess {

  @Column(columnName = "player_name", 
    columnType = Column.ColumnType.PRIMARY,
    dataType = DataType.STRING)
  public String player_name;
  
  @Column(columnName = "location_strings", 
      dataType = DataType.STRING, 
      isList = true)
  public ArrayList<String> location_strings;
  

  public SavedLocation() {
    super("saved_player_locations");
  }
  
  public SavedLocation(String name) {
    super("saved_player_locations");
    player_name = name;
  }
  
  public DataAccess getInstance() { 
    return new SavedLocation();
  }
  
  public void push(Location loc) {
    myRead(player_name);
    //Make sure previous location is different if it exists
    if (peek_stack() == null || 
      !equalsIsh(peek_stack(), loc)) { 
      push_stack(loc);
      myWrite();
    }
  }

  public Location pop(Location here) {    
    myRead(player_name);
    if (location_strings.size() == 0) {
      return null;
    }
    Location loc = pop_stack();
            
    myWrite();
    return loc;
  }
    
  private boolean equalsIsh(Location loc1, Location loc2) {
    return ((int) loc1.getX()) == ((int) loc2.getX()) &&
           ((int) loc1.getZ()) == ((int) loc2.getZ());
  }
 
  private void myRead(final String name) {
    player_name = name;
    
    HashMap<String, Object> search = new HashMap<String, Object>();
    search.put("player_name", name);
    
    try {
      Database.get().load(this, search);
    } catch (DatabaseReadException e) {
      // Not necessarily an error, could be first one
    }
    if (location_strings == null) {
      player_name = name;
      location_strings = new ArrayList<String>();
    }
  }
  
  private void myWrite() {
    HashMap<String, Object> search = new HashMap<String, Object>();
    search.put("player_name", player_name);

    try {
      Database.get().update(this, search);    
    } catch (DatabaseWriteException e) {
      //Error, couldn't write!
      System.err.println("Update failed");
    }
    
  }
  
  private void push_stack(Location loc) {
    String s = locationToString(loc);
    location_strings.add(s);
  }
  
  private Location peek_stack() {
    if (location_strings.isEmpty()) {
      return null;
    }
    String s = location_strings.get(location_strings.size()-1);
    return stringToLocation(s);
  }
  
  private Location pop_stack() {
    Location loc = peek_stack();
    location_strings.remove(location_strings.size()-1);
    return loc;
  }
    
  private String locationToString(Location loc) {
    return loc.getX() + "," +
            loc.getY() + "," +
            loc.getZ();
  }
    
  private Location stringToLocation(String str) {
    String[] arr = str.split(",");
    double x = Double.parseDouble(arr[0]);
    double y = Double.parseDouble(arr[1]);
    double z = Double.parseDouble(arr[2]);
    return new Location(x, y, z);
  }
  
}


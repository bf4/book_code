/***
 * Excerpted from "Learn to Program with Minecraft Plugins, CanaryMod Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/ahmine2 for more book information.
***/
package locationsnapshot;

import net.canarymod.database.Column;
import net.canarymod.database.Column.DataType;
import net.canarymod.database.DataAccess;

public class AllPlayerLocations extends DataAccess {
  @Column(columnName = "player_name",
          columnType = Column.ColumnType.PRIMARY,
          dataType   = DataType.STRING)
  public String player_name;
  
  @Column(columnName = "x", dataType = DataType.DOUBLE)
  public double x;
  
  @Column(columnName = "y", dataType = DataType.DOUBLE)
  public double y;
  
  @Column(columnName = "z", dataType = DataType.DOUBLE)
  public double z;
  
  public AllPlayerLocations() {
    super("all_player_locations");
  }
  
  public DataAccess getInstance() { 
    return new AllPlayerLocations();
  }
}


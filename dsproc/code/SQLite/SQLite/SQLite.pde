/**
 * <p>Ketai Sensor Library for Android: http://KetaiProject.org</p>
 *
 * <p>Ketai Data SQL Features:
 * <ul>
 * <li>Captures Sensor data into SQLite database</li>
 * <li>Sends query to SQLight database </li>
 * <li>Maps values onto the screen</li>
 * </ul>
 * <p>Updated: 2011-06-09 Daniel Sauter/j.duran</p>
 */

import ketai.data.*;
KetaiSQLite db;  //(1)
String output = "";
String CREATE_DB_SQL = "CREATE TABLE data (" +
"id INTEGER PRIMARY KEY AUTOINCREMENT, " +
"name TEXT, age INTEGER)";
orientation(PORTRAIT);
textSize(28);
db = new KetaiSQLite( this);  //(2)

if ( db.connect() ) {
  if (!db.tableExists("data"))  //(3)
    db.execute(CREATE_DB_SQL);  //(4)
  for (int i=0; i < 5; i++)  //(5)
    if (!db.execute( 
        "INSERT into data (`name`,`age`) " +   //(6)
        "VALUES ('Person_" + (char)random(65, 91) + 
        "', '" + (int)random(100) + "' )" 
        )
       )
       println("error w/sql insert");
  println("data count for data table after insert: " +
    db.getRecordCount("data"));  //(7)

  // read all in table "table_one"
  db.query( "SELECT * FROM data" );  //(8)
  while (db.next ()) //(9)
  {
    output +="--------------\n";
    output += "# " + db.getString("_id") + "\n";  //(10)
    output += db.getString("name") + "\n";
    output += db.getInt("age") + "\n";
  }
}
background(78, 93, 75);
text(output, 10, 10);  //(11)


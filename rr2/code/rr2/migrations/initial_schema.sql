CREATE TABLE 'ingredients' (
  'id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  'recipe_id' int(11) default NULL,
  'name' varchar(255) default NULL,
  'quantity' int(11) default NULL,
  'unit_of_measurement' varchar(255) default NULL
);
CREATE TABLE 'ratings' (
  'id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  'recipe_id' int(11) default NULL,
  'user_id' int(11) default NULL,
  'rating' int(11) default NULL
);
CREATE TABLE 'recipes' (
  'id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  'name' varchar(255) default NULL,
  'spice_level' int(11) default NULL,
  'region' varchar(255) default NULL,
  'instructions' text
);

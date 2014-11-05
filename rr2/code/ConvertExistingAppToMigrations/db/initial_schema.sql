CREATE TABLE `ingredients` (
  `id` int(11) NOT NULL auto_increment,
  `recipe_id` int(11) default NULL,
  `name` varchar(255) default NULL,
  `quantity` int(11) default NULL,
  `unit_of_measurement` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
);

CREATE TABLE `ratings` (
  `id` int(11) NOT NULL auto_increment,
  `recipe_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `rating` int(11) default NULL,
  PRIMARY KEY  (`id`)
);

CREATE TABLE `recipes` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `spice_level` int(11) default NULL,
  `region` varchar(255) default NULL,
  `instructions` text,
  PRIMARY KEY  (`id`)
);

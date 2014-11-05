-- zap schema

CREATE TABLE project (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE issue (
  id INTEGER PRIMARY KEY,
  project_id INTEGER REFERENCES project(id) NOT NULL,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  status INTEGER REFERENCES status(id) NOT NULL
);

CREATE TABLE status (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE comment (
  id INTEGER PRIMARY KEY,
  issue_id INTEGER REFERENCES issue(id) NOT NULL,
  content TEXT NOT NULL
);

-- status enums
INSERT INTO status (id, name) VALUES (1, 'open');
INSERT INTO status (id, name) VALUES (2, 'fixed');
INSERT INTO status (id, name) VALUES (3, 'wontfix');
INSERT INTO status (id, name) VALUES (4, 'invalid');

CREATE TABLE Bugs (
  bug_id        SERIAL PRIMARY KEY,
  date_reported DATE NOT NULL,
  summary       VARCHAR(80) NOT NULL,
  status        VARCHAR(10) NOT NULL,
  hours         NUMERIC(9,2),
  INDEX (bug_id), -- (1)
  INDEX (summary), -- (2)
  INDEX (hours), -- (3)
  INDEX (bug_id, date_reported, status) -- (4)
);

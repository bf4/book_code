CREATE TABLE Bugs (
  bug_id            SERIAL PRIMARY KEY,
  -- other columns
  assigned_to       BIGINT UNSIGNED NOT NULL,
  hours             NUMERIC(9,2) NOT NULL,
  FOREIGN KEY (assigned_to) REFERENCES Accounts(account_id)
);

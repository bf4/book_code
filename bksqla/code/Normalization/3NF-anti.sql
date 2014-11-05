CREATE TABLE Bugs (
  bug_id SERIAL PRIMARY KEY
  -- . . .
  assigned_to BIGINT,
  assigned_email VARCHAR(100),
  FOREIGN KEY (assigned_to) REFERENCES Accounts(account_id)
);

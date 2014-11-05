CREATE TABLE BugsAccounts (
  bug_id       BIGINT NOT NULL,
  reported_by  BIGINT,
  assigned_to  BIGINT,
  verified_by  BIGINT,
  FOREIGN KEY (bug_id) REFERENCES Bugs(bug_id),
  FOREIGN KEY (reported_by) REFERENCES Accounts(account_id),
  FOREIGN KEY (assigned_to) REFERENCES Accounts(account_id),
  FOREIGN KEY (verified_by) REFERENCES Accounts(account_id)
);

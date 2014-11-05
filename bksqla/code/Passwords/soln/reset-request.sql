CREATE TABLE PasswordResetRequest (
  token       CHAR(32) PRIMARY KEY,
  account_id  BIGINT UNSIGNED NOT NULL,
  expiration  TIMESTAMP NOT NULL,
  FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

SET @token = MD5('billkarwin' || CURRENT_TIMESTAMP || RAND());

INSERT INTO PasswordResetRequest (token, account_id, expiration)
  VALUES (@token, 123, CURRENT_TIMESTAMP + INTERVAL 1 HOUR);

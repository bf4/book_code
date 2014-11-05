CREATE TABLE DictionaryHashes (
  password       VARCHAR(100),
  password_hash  CHAR(64)
);

SELECT a.account_name, h.password
FROM Accounts AS a JOIN DictionaryHashes AS h
  ON a.password_hash = h.password_hash;

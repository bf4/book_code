SELECT CASE WHEN password_hash = SHA2('xyzzy') THEN 1 ELSE 0 END
  AS password_matches
FROM Accounts
WHERE account_id = 123;

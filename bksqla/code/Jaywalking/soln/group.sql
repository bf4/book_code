-- START:accountsperproduct
SELECT product_id, COUNT(*) AS accounts_per_product
FROM Contacts
GROUP BY product_id;
-- END:accountsperproduct
-- START:productsperaccount
SELECT account_id, COUNT(*) AS products_per_account
FROM Contacts
GROUP BY account_id;
-- END:productsperaccount
-- START:productwithmaxaccounts
SELECT c.product_id, c.contacts_per_product
FROM (
  SELECT product_id, COUNT(*) AS accounts_per_product
  FROM Contacts
  GROUP BY product_id
) AS c
ORDER BY c.contacts_per_product DESC LIMIT 1
-- END:productwithmaxaccounts

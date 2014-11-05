-- START:where
SELECT * FROM Products WHERE account_id REGEXP '[[:<:]]12[[:>:]]';
-- END:where
-- START:join
SELECT * FROM Products AS p JOIN Accounts AS a
    ON p.account_id REGEXP '[[:<:]]' || a.account_id || '[[:>:]]'
WHERE p.product_id = 123;
-- END:join

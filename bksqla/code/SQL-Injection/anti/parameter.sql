-- START:list
SELECT * FROM Bugs WHERE bug_id IN ( '1234,3456,5678' )
-- END:list
-- START:table
SELECT * FROM 'Bugs' WHERE bug_id = 1234
-- END:table
-- START:column
SELECT * FROM Bugs ORDER BY 'date_reported';
-- END:column
-- START:keyword
SELECT * FROM Bugs ORDER BY date_reported 'DESC'
-- END:keyword

SELECT * FROM Bugs JOIN Tags USING (bug_id)
WHERE tag = 'performance';

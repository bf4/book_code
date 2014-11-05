SELECT bug_id FROM Bugs GROUP BY bug_id HAVING COUNT(*) > 1;

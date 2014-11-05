UPDATE BugStatus SET status = 'INVALID' WHERE status = 'BOGUS'; -- ERROR!

UPDATE Bugs SET status = 'INVALID' WHERE status = 'BOGUS'; -- ERROR!

INSERT INTO BugsText (docid, summary, description)
  SELECT bug_id, summary, description FROM Bugs;

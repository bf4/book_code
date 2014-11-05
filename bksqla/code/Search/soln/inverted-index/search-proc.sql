DELIMITER //
-- START:create
CREATE PROCEDURE BugsSearch(keyword VARCHAR(40))
BEGIN
  SET @keyword = keyword;

  PREPARE s1 FROM 'SELECT MAX(keyword_id) INTO @k FROM Keywords
    WHERE keyword = ?'; -- (1)
  EXECUTE s1 USING @keyword;
  DEALLOCATE PREPARE s1;

  IF (@k IS NULL) THEN
    PREPARE s2 FROM 'INSERT INTO Keywords (keyword) VALUES (?)'; -- (2)
    EXECUTE s2 USING @keyword;
    DEALLOCATE PREPARE s2;
    SELECT LAST_INSERT_ID() INTO @k; -- (3)
                                     
    PREPARE s3 FROM 'INSERT INTO BugsKeywords (bug_id, keyword_id)
      SELECT bug_id, ? FROM Bugs
      WHERE summary REGEXP CONCAT(''[[:<:]]'', ?, ''[[:>:]]'')
	OR description REGEXP CONCAT(''[[:<:]]'', ?, ''[[:>]]'')'; -- (4)
    EXECUTE s3 USING @k, @keyword, @keyword;
    DEALLOCATE PREPARE s3;
  END IF;

  PREPARE s4 FROM 'SELECT b.* FROM Bugs b 
    JOIN BugsKeywords k USING (bug_id)
    WHERE k.keyword_id = ?'; -- (5)
  EXECUTE s4 USING @k;
  DEALLOCATE PREPARE s4;
END
-- END:create
//
DELIMITER ;
-- START:call
CALL BugsSearch('crash');
-- END:call

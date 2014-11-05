-- START:on
SELECT * FROM Bugs AS b JOIN BugsProducts AS bp ON (b.bug_id = bp.bug_id);
-- END:on
-- START:using
SELECT * FROM Bugs JOIN BugsProducts USING (bug_id);
-- END:using
-- START:verbose
SELECT * FROM Bugs AS b JOIN BugsProducts AS bp ON (b.id = bp.bug_id);
-- END:vebose

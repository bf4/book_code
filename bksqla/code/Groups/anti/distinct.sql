-- START:distinct
SELECT DISTINCT date_reported, reported_by FROM Bugs;
-- END:distinct
-- START:groupby
SELECT date_reported, reported_by FROM Bugs
GROUP BY date_reported, reported_by;
-- END:groupby

SELECT date_reported, COUNT(*)
FROM Bugs
GROUP BY date_reported;

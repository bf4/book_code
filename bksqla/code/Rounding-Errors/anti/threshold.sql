-- START:coarse
SELECT * FROM Accounts WHERE ABS(hourly_rate - 59.95) < 0.000001;
-- END:coarse
-- START:fine
SELECT * FROM Accounts WHERE ABS(hourly_rate - 59.95) < 0.0000001;
-- END:fine

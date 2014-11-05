SELECT * FROM Bugs WHERE ts_bugtext @@ to_tsquery('crash');

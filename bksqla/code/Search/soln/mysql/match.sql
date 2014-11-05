SELECT * FROM Bugs WHERE MATCH(summary, description) AGAINST ('crash');

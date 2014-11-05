SELECT *
FROM Comments AS c
WHERE c.path LIKE '1/4/' || '%';

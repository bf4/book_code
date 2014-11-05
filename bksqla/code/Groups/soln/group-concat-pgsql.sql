CREATE AGGREGATE GROUP_ARRAY (
  BASETYPE = ANYELEMENT,
     SFUNC = ARRAY_APPEND,
     STYPE = ANYARRAY,
  INITCOND = '{}'
);

SELECT product_id, MAX(date_reported) AS latest,
  ARRAY_TO_STRING(GROUP_ARRAY(bug_id), ',') AS bug_id_list
FROM Bugs JOIN BugsProducts USING (bug_id)
GROUP BY product_id;

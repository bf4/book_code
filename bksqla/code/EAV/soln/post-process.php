<?php

$objects = array();
$stmt = $pdo->query( 
    "SELECT issue_id, attr_name, attr_value
     FROM IssueAttributes
     WHERE issue_id = 1234");
while ($row = $stmt->fetch()) {
  $id    = $row['issue_id'];
  $field = $row['attr_name'];
  $value = $row['attr_value'];
  if (!array_key_exists($id, $objects)) {
    $objects[$id] = new stdClass();
  }
  $objects[$id]->$field = $value;
}

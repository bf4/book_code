<?php

$index = Zend_Search_Lucene::open("BugsText.idx");
$search_expr = Zend_Search_Lucene_Search_QueryParser::parse(
  "crash AND NOT save");
$matches = $index->find($search_expr);

$bug_id_list = array("0");
foreach ($matches as $match) {
  $bug_id_list[] = intval($match->bug_id);
}
$bug_id_list = join(",", $bug_id_list);

$stmt = $pdo->query("SELECT * FROM Bugs WHERE bug_id IN ($bug_id_list)");

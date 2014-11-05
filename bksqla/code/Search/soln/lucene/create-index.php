<?php

$index = Zend_Search_Lucene::create("BugsText.idx");
$stmt = $pdo->query("SELECT bug_id, summary, description FROM Bugs");

while ($row = $stmt->fetch()) {
  $doc = new Zend_Search_Lucene_Document();
  $doc->addField(Zend_Search_Lucene_Field::UnIndexed("bug_id",
      $row["bug_id"]));
  $doc->addField(Zend_Search_Lucene_Field::Text("summary",
      $row["summary"]));
  $doc->addField(Zend_Search_Lucene_Field::Text("description",
      $row["description"]));
  $index->addDocument($doc);
}

<?php

header('Content-type: image/jpg');

$stmt = $pdo->query("SELECT screenshot_image FROM Screenshots
		     WHERE bug_id = 1234 AND image_id = 1");
$row = $stmt->fetch();

print $row[0];

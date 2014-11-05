<?php

$stmt = $pdo->query("DELETE FROM Screenshots
		     WHERE bug_id = 1234 AND image_id =1");

unlink('images/screenshot1234-1.jpg');

// Other clients still see the row in the database,
// but not the image file.

$pdo->commit();

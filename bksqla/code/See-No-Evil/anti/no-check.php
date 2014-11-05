<?php
$pdo = new PDO("mysql:dbname=test;host=db.example.com", //(1)
    "dbuser", "dbpassword");
$sql = "SELECT bug_id, summary, date_reported FROM Bugs
    WHERE assigned_to = ? AND status = ?";
$stmt = $dbh->prepare($sql);         //(2)
$stmt->execute(array(1, "OPEN"));    //(3)
$bug = $stmt->fetch();               //(4)

<?php
try {
    $pdo = new PDO("mysql:dbname=test;host=localhost",
	"dbuser", "dbpassword");
} catch (PDOException $e) {                       //(1)
    report_error($e->getMessage());
    return;
}

$sql = "SELECT bug_id, summary, date_reported FROM Bugs
    WHERE assigned_to = ? AND status = ?";

if (($stmt = $pdo->prepare($sql)) === false) {    //(2)
    $error = $pdo->errorInfo();
    report_error($error[2]);
    return;
}

if ($stmt->execute(array(1, "OPEN")) === false) { //(3)
    $error = $stmt->errorInfo();
    report_error($error[2]);
    return;
}

if (($bug = $stmt->fetch()) === false) {          //(4)
    $error = $stmt->errorInfo();
    report_error($error[2]);
    return;
}

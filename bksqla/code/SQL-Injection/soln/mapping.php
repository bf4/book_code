<?php
$sortorder = $_REQUEST["order"];
$direction = $_REQUEST["dir"];
$sql = "SELECT * FROM Bugs ORDER BY $sortorder $direction";
$stmt = $pdo->query($sql);

$sortorders = array( "status" => "status", "date" => "date_reported" );
$directions = array( "up" => "ASC", "down" => "DESC" );

$sortorder = "bug_id";
$direction = "ASC";

if (array_key_exists($_REQUEST["order"], $sortorders)) {
  $sortorder = $sortorders[ $_REQUEST["order"] ];
}

if (array_key_exists($_REQUEST["dir"], $directions)) {
  $direction = $directions[ $_REQUEST["dir"] ];
}

$sql = "SELECT * FROM Bugs ORDER BY {$sortorder} {$direction}";
$stmt = $pdo->query($sql);

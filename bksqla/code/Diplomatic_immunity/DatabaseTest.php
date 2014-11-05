<?php
require_once "PHPUnit/Framework/TestCase.php";

class DatabaseTest extends PHPUnit_Framework_TestCase
{
    protected $pdo;

    public function setUp()
    {
	$this->pdo = new PDO("mysql:dbname=bugs", "testuser", "xxxxxx");
    }

    public function testTableFooExists()
    {
	$stmt = $this->pdo->query("SELECT COUNT(*) FROM Bugs");
	$err = $this->pdo->errorInfo();
	$this->assertType("object", $stmt, $err[2]);
	$this->assertEquals("PDOStatement", get_class($stmt));
    }

    public function testTableFooColumnBugIdExists()
    {
	$stmt = $this->pdo->query("SELECT COUNT(bug_id) FROM Bugs");
	$err = $this->pdo->errorInfo();
	$this->assertType("object", $stmt, $err[2]);
	$this->assertEquals("PDOStatement", get_class($stmt));
    }

    static public function main()
    {
	$suite  = new PHPUnit_Framework_TestSuite(__CLASS__);
	$result = PHPUnit_TextUI_TestRunner::run($suite);
    }

}

DatabaseTest::main();

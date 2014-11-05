<?php
class AdminController extends Zend_Controller_Action
{
  public function assignAction()
  {
    $bugsTable = Doctrine_Core::getTable("Bugs");
    $bug = $bugsTable->find($_POST["bug_id"]);
    $bug->Products[] = $_POST["product_id"];
    $bug->assigned_to = $_POST["user_assigned_to"];
    $bug->save();
  }
}

class BugController extends Zend_Controller_Action
{
  public function enterAction()
  {
    $bug = new Bugs();
    $bug->summary = $_POST["summary"];
    $bug->description = $_POST["description"];
    $bug->status = "NEW";

    $accountsTable = Doctrine_Core::getTable("Accounts");
    $auth = Zend_Auth::getInstance();
    if ($auth && $auth->hasIdentity()) {
      $bug->reported_by = $auth->getIdentity();
    }
    $bug->save();
  }

  public function displayAction()
  {
    $bugsTable = Doctrine_Core::getTable("Bugs");
    $this->view->bug = $bugsTable->find($_GET["bug_id"]);
    $accountsTable = Doctrine_Core::getTable("Accounts");
    $this->view->reportedBy = $accountsTable->find($bug->reported_by);
    $this->view->assignedTo = $accountsTable->find($bug->assigned_to);
    $this->view->verifiedBy = $accountsTable->find($bug->verified_by);

    $productsTable = Doctrine_Core::getTable("Products");
    $this->view->products = $bug->Products;
  }
}

class SearchController extends Zend_Controller_Action
{
  public function bugsAction()
  {
    $q = Doctrine_Query::create()
      ->from("Bugs b")
      ->join("b.Products p")
      ->where("b.status = ?", $_GET["status"])
      ->andWhere("MATCH(b.summary, b.description) AGAINST (?)", $_GET["search"]);
    $this->view->searchResults = $q->fetchArray();
  }
}

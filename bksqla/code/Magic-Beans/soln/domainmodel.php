<?php

class BugReport
{
  protected $bugsTable;
  protected $accountsTable;
  protected $productsTable;

  public function __construct()
  {
    $this->bugsTable = Doctrine_Core::getTable("Bugs");
    $this->accountsTable = Doctrine_Core::getTable("Accounts");
    $this->productsTable = Doctrine_Core::getTable("Products");
  }



  public function create($summary, $description, $reportedBy)
  {
    $bug = new Bugs();
    $bug->summary = $summary
    $bug->description = $description
    $bug->status = "NEW";
    $bug->reported_by = $reportedBy;
    $bug->save();
  }

  public function assignUser($bugId, $assignedTo)
  {
    $bug = $bugsTable->find($bugId);
    $bug->assigned_to = $assignedTo;
    $bug->save();
  }

  public function get($bugId)
  {
    return $bugsTable->find($bugId);
  }

  public function search($status, $searchString)
  {
    $q = Doctrine_Query::create()
      ->from("Bugs b")
      ->join("b.Products p")
      ->where("b.status = ?", $status)
      ->andWhere("MATCH(b.summary, b.description) AGAINST (?)", $searchString]);
    return $q->fetchArray();
  }
}


class AdminController extends Zend_Controller_Action
{
  public function assignAction()
  {
    $this->bugReport->assignUser(
      $this->_getParam("bug"),
      $this->_getParam("user"));
  }
}


class BugController extends Zend_Controller_Action
{
  public function enterAction()
  {
    $auth = Zend_Auth::getInstance();
    if ($auth && $auth->hasIdentity()) {
      $identity = $auth->getIdentity();
    }
    $this->bugReport->create(
      $this->_getParam("summary"),
      $this->_getParam("description"),
      $identity);
  }


  public function displayAction()
  {
    $this->view->bug = $this->bugReport->get(
      $this->_getParam("bug"));
  }
}


class SearchController extends Zend_Controller_Action
{
  public function bugsAction()
  {
    $this->view->searchResults = $this->bugReport->search(
      $this->_getParam("status", "OPEN"),
      $this->_getParam("search"));
  }
}

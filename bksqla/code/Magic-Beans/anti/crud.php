<?php
class CustomBugs extends BaseBugs
{
  public function assignUser(Accounts $a)
  {
    $this->assigned_to = $a->account_id;
    $this->save();
    mail($a->email, "Assigned bug",
      "You are now responsible for bug #{$this->bug_id}.");
  }
}
$bugsTable = Doctrine_Core::getTable('Bugs');
$bug = $bugsTable->find(1234);
$bug->assigned_to = $user->account_id;
$bug->save();

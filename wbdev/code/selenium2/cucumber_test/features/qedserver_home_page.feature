Feature: Testing the QED Server home page to make sure we have the 
  manage products link and the See a quick tutorial link

  Scenario: Verify the manage products link is on the home page
    Given I am on the QED Server home page
    Then I should see the "Manage products" link

  Scenario: Verify the See a quick tutorial link is on the home page
    Given I am on the QED Server home page
    Then I should see the "See a quick tutorial" link

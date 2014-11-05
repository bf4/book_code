Feature: Tables

  Scenario: Renaming headers
    Given I am logged in as a buyer
    When I search for available cars
    Then I should see the following cars:
      | color | model   |
      | rust  | Camaro  |
      | blue  | Gremlin |

  Scenario: Converting cells
    Given I am logged in as a buyer
    When I view warranty options
    Then I should see the following options:
      | name     | price |
      | Platinum | $1000 |
      | Gold     | $500  |
      | Silver   | $200  |

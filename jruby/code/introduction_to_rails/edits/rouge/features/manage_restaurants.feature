Feature: Manage restaurants
  In order to provide up-to-the-minute listings
  As a guidebook author
  I want to add, remove, and modify restaurants

  Background:
    Given I am logged in as an admin

  Scenario: Add a restaurant
    Given the following restaurants:
      | name             |
      | Kenny and Zuke's |
      | Horse Brass Pub  |
    When I add the following restaurant:
      | name           |
      | New Old Lompoc |
    Then I should see the following restaurants:
      | name             |
      | Kenny and Zuke's |
      | Horse Brass Pub  |
      | New Old Lompoc   |

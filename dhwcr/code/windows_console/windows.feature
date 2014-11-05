# -*- coding: utf-8 -*-

Feature: Windows console

  Scenario: Pass/fail colors
    Given I am on Windows
    When I run Cucumber
    Then I should see colors

  Scenario: European characters
    Given I am on Windows
    When my step contains an accented é
    Then it should show up in the output

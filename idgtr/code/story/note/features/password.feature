# START: password_feature
Feature: Password protection
So that only I (and the NSA) can read my documents
As a security-conscious person
I want to encrypt each document with a password
# END: password_feature

# START: password_scenario
Scenario: Changing the password
  Given a new document
  When I type "this is my document"
  And I save the document as "Secrets" with password "unguessable"
  And I exit the app
  And I open the document "Secrets" with password "unguessable"
  Then the app should be running
  And the text should be "this is my document"

  When I change the password from "unguessable" to "uncrackable"
  And I exit the app
  And I open the document "Secrets" with password "uncrackable"
  Then the app should be running
  And the text should be "this is my document"
# END: password_scenario

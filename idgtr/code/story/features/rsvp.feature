# START:rsvp_feature
Feature: minimalist RSVPs
  So that I can attend tons of parties
  As a guest with lots to do
  I want to RSVP to an invite with a minimum of mouse clicks
  # END:rsvp_feature

  # START:email_free
  Scenario: email-free RSVPs
    Given a party called "a disco anniversary"
    When I view the invitation
    Then I should see the party details

    When I answer that "Robert Bell" will not attend
    Then I should see "Robert Bell" in the list of decliners
    # END:email_free

  # START:rsvp_email
  Scenario: RSVP links from email
    Given a party called "a salute to e-mail"
    And a guest list of "one@example.com,two@example.com"
    When I view the invitation
    Then I should see that e-mail was sent to "one@example.com,two@example.com"

    When I view the e-mail that was sent to "one@example.com"
    Then I should see "Yes/No" links
    When I follow the "Yes" link
    Then I should see "one@example.com" in the list of partygoers
    # END:rsvp_email
Feature: Drawing

  Scenario: Green circle
    Given a white background
    When I draw a green circle
    Then the result should resemble "circle.png"

Feature: Cucumber With

Scenario: The one where I extend the cucumber gem
  Given I am on the facebook login page
  When I log in to facebook
    With the username "test"
    And the password "butts"
  Then I should still be on the facebook login page

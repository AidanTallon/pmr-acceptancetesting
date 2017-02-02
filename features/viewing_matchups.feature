@smoke @viewing_matchups
Feature: Viewing Matchups
  As a user
  I want to view the matchups I have recorded
  So that I can view my opinions

  Background:
    Given I am on the index page
    And matchups have been recorded

  @wip
  Scenario: Viewing matchups on main page
    Then I should see the recorded matchups on the main page

  @wip
  Scenario: Toggling 'Show matchups' button
    When I decide to hide matchups
    Then I should not see the recorded matchups on the main page
    When I decide to show matchups again
    Then I should see the recorded matchups on the main page

@smoke @recording_matchups
Feature: Recording matchups
  As a user
  I want to record matchup values
  So I can view my opinions clearly

  Background:
    Given I am on the index page
    And the index page is in a default state

  Scenario: Page default state
    When no data has been inputted
    Then there should be no matchup information displayed for any character

  Scenario: Recording a matchup
    When I assign a matchup value for two characters
    Then this value should be accurately recorded and displayed

  Scenario: Selecting characters
    When I click a character
    Then the character should appear
    When I click another character
    Then both characters should appear
    And informative text should be displayed

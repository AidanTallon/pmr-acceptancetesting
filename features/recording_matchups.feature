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
    And the matchup track bar should be enabled

  Scenario: No characters selected
    When no characters are selected
    Then the matchup track bar should be disabled

  Scenario: One character selected
    When I click a character
    Then the matchup track bar should be disabled

  @wip
  Scenario: Deselecting primary character using deselect button
    Given two characters are selected
    When I click the deselect button for the primary character
    Then no characters should be selected

  @wip
  Scenario: Deselecting primary character using character button
    Given two characters are selected
    When I click the primary character again
    Then no characters should be selected

  @wip
  Scenario: Deselecting secondary character using deselect button
    Given two characters are selected
    When I click the deselect button for the secondary character
    Then the primary character should be selected
    And the secondary character should be deselected

  @wip
  Scenario: Deselecting secondary character using character button
    Given two characters are selected
    When I click the secondary character again
    Then the primary character should be selected
    And the secondary character should be deselected

  @wip
  Scenario: Deleting matchup using delete matchup button
    Given I have selected two characters who have a matchup value
    When I click delete matchup
    Then I should be asked to confirm deletion
    When I confirm deletion
    Then the matchup values should no longer be displayed

  @wip
  Scenario: Nearly deleting matchup using delete matchup button
    Given I have selected two characters who have a matchup value
    When I click delete matchup
    Then I should be asked to confirm deletion
    When I cancel deletion
    Then the matchup values should still be displayed

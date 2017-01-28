@smoke @navigation
Feature: Navigation
  As a user
  I want to navigate between menus
  So I can fully experience the web apps features

  Background:
    Given I am on the index page

  Scenario: Default screen
    Then I should see the main screen

  Scenario Outline: Viewing overlays
    When I click the <overlay> button
    Then I should see the <overlay> overlay
    When I click the <overlay> button again
    Then I should see the main screen

    Examples:
      | overlay   |
      | help      |
      | about     |
      | settings  |
      | share     |

  Scenario: Viewing overlays in succession
    When I click the share button
    Then I should see the share overlay
    When I click the settings button
    Then I should see the settings overlay
    When I click the settings button again
    Then I should see the main screen

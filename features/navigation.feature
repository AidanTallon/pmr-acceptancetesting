@smoke @navigation
Feature: Navigation
  As a user
  I want to navigate between menus
  So I can fully experience the web apps features

  Background:
    Given I am on the index page

  Scenario: Viewing the Help overlay
    When I click the help button
    Then I should see the help overlay
    When I click the help button again
    Then I should see the main screen

  Scenario: Viewing the About overlay
    When I click the about button
    Then I should see the about overlay
    When I click the about button again
    Then I should see the main screen

  Scenario: Viewing the Settings overlay
    When I click the settings button
    Then I should see the settings overlay
    When I click the settings button again
    Then I should see the main screen

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
    When I click the help button
    Then I should see the main screen

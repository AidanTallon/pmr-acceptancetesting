@smoke @sharingmatchups
Feature: Sharing matchups
  As a fan of Pokken Tournament
  I want to share my opinions on character matchups
  So I can spark discussion with other fans

  Background:
    Given I am on the index page

  Scenario: Share matchups image
    When I assign matchup values for characters
    Then I should be able to see an image of the matchup values in the share tab

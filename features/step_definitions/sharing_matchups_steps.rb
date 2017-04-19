#frozen_string_literal: true

Given /^I assign matchup values for characters$/ do
  App.index_page.assign
    .matchup(:lucario, :gengar, 1)
    .matchup(:lucario, :charizard, -2)
end

Given /^I should be able to see an image of the matchup values in the share tab$/ do
  App.index_page
    .click_overlay_button(:share)
    .click_character(:lucario)
  raise unless App.share_page.matchups_image_visible?
end

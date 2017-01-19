Given /^the index page is in a default state$/ do
  # no action needs to be taken as previous step already reloads page
end

When /^no data has been inputted$/ do
  # nothing
end

Then /^there should be no matchup information displayed for any character$/ do
  raise 'At least one matchup label displaying value' unless App.index_page.all_matchup_labels_blank?
end

When /^I assign a matchup value for two characters$/ do
  pending
  @char1 = :charizard
  @char2 = :pikachu
  @value = 2
  App.index_page.assign_matchup_value :charizard, :pikachu, 2
end

Then /^this value should be accurately recorded and displayed$/ do
  pending
end

When /^I click a character$/ do
  @char1 = :lucario
  App.index_page.click_character @char1
end

Then /^the character should appear$/ do
  raise 'Primary character not appearing.' unless App.index_page.primary_character_is? @char1
end

When /^I click another character$/ do
  @char2 = :shadow_mewtwo
  App.index_page.click_character @char2
end

Then /^both characters should appear$/ do
  raise 'Primary character not appearing.' unless App.index_page.primary_character_is? @char1
  raise 'Secondary character not appearing.' unless App.index_page.secondary_character_is? @char2
end

Then /^informative text should be displayed$/ do
  pending
  text = App.index_page.get_middle_select_text
  unless text.include? @char1.to_s and text.include? @char2.to_s
    raise 'Helper text error.'
  end
end

When /^no characters are selected$/ do
  # Don't need to do anything
  # Can check that no characters are selected anyway?
end

Then /^the matchup track bar should be disabled$/ do
  raise 'Track bar enabled. Expected to be disabled.' if App.index_page.track_bar_enabled?
end

Then /^the matchup track bar should be enabled$/ do
  raise 'Track bar disabled. Expected to be enabled.' unless App.index_page.track_bar_enabled?
end

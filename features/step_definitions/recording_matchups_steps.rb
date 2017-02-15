# frozen_string_literal: true

Given /^the index page is in a default state$/ do
  # no action needs to be taken as previous step already reloads page
end

When /^no data has been inputted$/ do
  # nothing
end

Then /^there should be no matchup information displayed for any character$/ do
  unless App.index_page.all_matchup_labels_blank?
    raise 'At least one matchup label displaying value'
  end
end

When /^I assign a matchup value for two characters$/ do
  @char1 = :charizard
  @char2 = :pikachu
  @value = 2
  App.index_page.assign_matchup_value :charizard, :pikachu, 2
end

Then /^this value should be accurately recorded and displayed$/ do
  App.index_page.set_characters @char1
  expected_value1 = '2'
  displayed_value1 = App.index_page.matchup_label_for(@char2).text
  unless expected_value1 == displayed_value1
    raise "Error displaying matchup label value.
      Expected: #{expected_value1}. Got: #{displayed_value1}."
  end
  App.index_page.set_characters @char2
  expected_value2 = '-2'
  displayed_value2 = App.index_page.matchup_label_for(@char1).text
  unless expected_value2 == displayed_value2
    raise "Error displaying matchup label value.
      Expected: #{expected_value2}. Got: #{displayed_value2}"
  end
end

When /^I click a character$/ do
  @char1 = :lucario
  App.index_page.click_character @char1
end

Then /^the character should appear$/ do
  unless App.index_page.primary_character_is? @char1
    raise 'Primary character not appearing.'
  end
end

When /^I click another character$/ do
  @char2 = :shadow_mewtwo
  App.index_page.click_character @char2
end

Then /^both characters should appear$/ do
  unless App.index_page.primary_character_is? @char1
    raise 'Primary character not appearing.'
  end
  unless App.index_page.secondary_character_is? @char2
    raise 'Secondary character not appearing.'
  end
end

Then /^informative text should be displayed$/ do
  text = App.index_page.helper_text
  char1_text = @char1.to_s.tr('_', ' ').split(' ').map(&:capitalize).join(' ')
  char2_text = @char2.to_s.tr('_', ' ').split(' ').map(&:capitalize).join(' ')
  if !(text.include? char1_text) || !(text.include? char2_text)
    raise 'Helper text error.'
  end
end

When /^no characters are selected$/ do
  # Don't need to do anything
  # Can check that no characters are selected anyway?
end

Then /^the matchup track bar should be disabled$/ do
  if App.index_page.track_bar_enabled?
    raise 'Track bar enabled. Expected to be disabled.'
  end
end

Then /^the matchup track bar should be enabled$/ do
  unless App.index_page.track_bar_enabled?
    raise 'Track bar disabled. Expected to be enabled.'
  end
end

When /^I click the deselect button for the primary character$/ do
  App.index_page.deselect_primary_character_button.click
end

Then /^no characters should be selected$/ do
  raise "Primary character still selected" unless App.index_page.get_primary_character.nil?
  raise "Secondary character still selected" unless App.index_page.get_secondary_character.nil?
end

When /^I click the primary character again$/ do
  App.index_page.click_character @char1
end

When /^I click the deselect button for the secondary character$/ do
  App.index_page.deselect_secondary_character_button.click
end

Then /^the primary character should be selected$/ do
  unless App.index_page.primary_character_is? @char1
    raise "Primary character selection error: Expected: #{@char1}. Got: #{App.index_page.get_primary_character}"
  end
end

When /^I click the secondary character again$/ do
  App.index_page.click_character @char2
end

Then /^the secondary character should be deselected$/ do
  unless App.index_page.get_secondary_character.nil?
    raise "Secondary character selection error: Expected: nil. Got: #{App.index_page.get_secondary_character}"
  end
end

Given /^I have selected two characters who have a matchup value$/ do
  @char1 = :garchomp
  @char2 = :machamp
  @matchup_value1 = 2
  @matchup_value2 = -@matchup_value1
  App.index_page.assign_matchup_value @char1, @char2, @matchup_value1
end

When /^I click delete matchup$/ do
  App.index_page.delete_matchup_button.click
end

Then /^the matchup values should no longer be displayed$/ do
  App.index_page.set_characters @char1, @char2
  unless App.index_page.matchup_label_for(@char2).text == ''
    raise "Error displaying matchup value. Expected: ''. Got: #{App.index_page.matchup_label_for(@char2).text}"
  end
  App.index_page.set_characters @char2, @char1
  unless App.index_page.matchup_label_for(@char1).text == ''
    raise "Error displaying matchup value. Expected: ''. Got: #{App.index_page.matchup_label_for(@char1).text}"
  end
end

Then /^I should be asked to confirm deletion$/ do
  raise "No confirmation box" unless App.browser.alert.exists?
end

When /^I confirm deletion$/ do
  App.browser.alert.ok
end

When /^I cancel deletion$/ do
  App.browser.alert.close
end

Then /^the matchup values should still be displayed$/ do
  App.index_page.set_characters @char1, @char2
  unless App.index_page.matchup_label_for(@char2).text == @matchup_value1.to_s
    raise "Error displaying matchup value. Expected: #{@matchup_value1}. Got: #{App.index_page.matchup_label_for(@char2).text}"
  end
  App.index_page.set_characters @char2, @char1
  unless App.index_page.matchup_label_for(@char1).text == @matchup_value2.to_s
    raise "Error displaying matchup value. Expected: #{@matchup_value2}. Got: #{App.index_page.matchup_label_for(@char1).text}"
  end
end

Given /^two characters are selected$/ do
  @char1 = :gengar
  @char2 = :lucario
  App.index_page.set_characters @char1, @char2
end

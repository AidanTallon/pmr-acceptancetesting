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
  expected_value_1 = '2'
  displayed_value_1 = App.index_page.matchup_label_for(@char2).text
  unless expected_value_1 == displayed_value_1
    raise "Error displaying matchup label value.
      Expected: #{expected_value_1}. Got: #{displayed_value_1}."
  end
  App.index_page.set_characters @char2
  expected_value_2 = '-2'
  displayed_value_2 = App.index_page.matchup_label_for(@char1).text
  unless expected_value_2 == displayed_value_2
    raise "Error displaying matchup label value.
      Expected: #{expected_value_2}. Got: #{displayed_value_2}"
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
  text = App.index_page.get_middle_select_text
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

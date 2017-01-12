Given /^the index page is in a default state$/ do
  # no action needs to be taken as previous step already reloads page
end

When /^no data has been inputted$/ do
  # nothing
end

Then /^there should be no matchup information displayed for any character$/ do
  pending
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
  pending
end

Then /^the character should appear$/ do
  pending
end

When /^I click another character$/ do
  pending
end

Then /^both characters should appear$/ do
  pending
end

Then /^informative text should be displayed$/ do
  pending
end

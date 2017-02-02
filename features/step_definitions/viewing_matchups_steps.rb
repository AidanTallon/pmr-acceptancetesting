Given /^matchups have been recorded$/ do
  pending
end

Then /^I should see the recorded matchups on the main page$/ do
  pending
end

When /^I decide to hide matchups$/ do
  App.index_page.toggle_matchups_button.click unless App.index_page.matchups_hidden?
end

Then /^I should not see the recorded matchups on the main page$/ do
  raise 'Matchups still displayed' unless App.index_page.all_matchup_labels_blank?
end

When /^I decide to show matchups again$/ do
  App.index_page.toggle_matchups_button.click if App.index_page.matchups_hidden?
end

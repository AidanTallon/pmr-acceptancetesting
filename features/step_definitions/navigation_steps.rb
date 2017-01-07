Given /^I am on the index page$/ do
  App.index_page.visit
end

When /^I click the help button$/ do
  App.index_page.click_help
end

Then /^I should see the help overlay$/ do
  raise unless App.index_page.overlay_visible? :help
end

Then /^I should see the main screen$/ do
  raise unless App.index_page.overlay_visible? :none
end

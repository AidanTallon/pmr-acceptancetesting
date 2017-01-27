# frozen_string_literal: true

Given /^I am on the index page$/ do
  App.index_page.visit
end

When /^I click the (.+) button(?: again)?$/ do |button|
  App.index_page.click_overlay_button button.to_sym
end

Then /^I should see the (.+) overlay$/ do |overlay|
  raise unless App.index_page.overlay_visible? overlay.to_sym
end

Then /^I should see the main screen$/ do
  raise unless App.index_page.overlays_closed?
end

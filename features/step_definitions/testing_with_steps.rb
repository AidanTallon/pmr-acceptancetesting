Given /^I am on the facebook login page$/ do
  App.browser.goto 'www.facebook.com'
end

When /^I log in to facebook$/ do
  yield_to_with
  App.browser.element(xpath: '//*[@data-test-id="royal-login-button"]').click
end

When /^I log in to facebook$/, with: /^the username "(.*)"$/ do |username|
  App.browser.element(xpath: '//*[@data-test-id="royal-email"]').send_keys username
end

When /^I log in to facebook$/, with: /^the password "(.*)"$/ do |password|
  App.browser.element(xpath: '//*[@data-test-id="royal_pass"]').send_keys password
end

Then /^I should still be on the facebook login page$/ do
  sleep 5
  raise unless App.browser.element(xpath: '//*[@data-test-id="royal-login-button"]').exists?
end

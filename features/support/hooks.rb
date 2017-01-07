# Setup browser
begin
  retries ||= 0
  App.browser = Watir::Browser.new (ENV['BROWSER'] || 'chrome').to_sym
rescue Net::ReadTimeout
  retry if (retries += 1) < 10
end

Before do
  App.browser.window.maximize
  App.browser.cookies.clear
end

# All
After do |scenario|
  App.browser.driver.manage.delete_all_cookies

  # Output a screenshot (and video if HEADLESS) if the scenario failed
  if scenario.failed?
    output_path = File.expand_path(File.join(File.dirname(__FILE__), '/../../results/screenshots/'))
      scenario_name = "#{Time.now.strftime('%Y%m%d-%H_%M_%S')}-#{scenario.name}"
      output_path += '/' + scenario_name
      App.browser.screenshot.save "#{output_path}.png"

      image = App.browser.screenshot.base64
      embed "data:image/png;base64,#{image}", 'image/png'
    end

    App.logout
  end

  # After all features have executed
  at_exit do
    App.close!
    headless.destroy if ENV['HEADLESS']
  end

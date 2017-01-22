# frozen_string_literal: true

# Generic page object model. All page objects inherit from this class.
class GenericPage
  def initialize(browser)
    @browser = browser
  end

  def visit
    @browser.goto @url
    raise "Not on #{self.class.name} page" unless on_page?
  end

  def on_page?
    begin
      Watir::Wait.until(timeout: 10) { @trait.exists? }
      return true
    rescue
      return false
    end
  end
end

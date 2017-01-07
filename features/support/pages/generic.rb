class GenericPage
  def initialize(browser)
    @browser = browser
  end

  def visit
    @browser.goto @url
    raise "Not on page" unless on_page?
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

class GenericPage
  def initialize(browser)
    @browser = browser
  end

  def visit
    @browser.goto @url
  end

  def on_page?
    begin
      Watir::Wait.until { @trait.exists? }
      return true
    rescue
      return false
    end
  end
end

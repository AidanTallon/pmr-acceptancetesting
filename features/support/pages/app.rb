# frozen_string_literal: true

# Holds page object models for the app. Use like App.index_page
class App
  def self.browser=(browser)
    @browser = browser
  end

  def self.browser
    @browser
  end

  def self.method_missing(method_name, *_arguments, &_block)
    # Initializes App.page_object if it doesn't already exist
    if method_name =~ /(.+)_page/
      @pages ||= {}
      class_name = method_name.to_s.split('_').collect(&:capitalize).join
      @pages[method_name] || @pages[method_name] = Object.const_get(class_name).new(@browser)
    else
      super
    end
  end

  def self.respond_to_missing?(method_name, include_private = false)
    method_name.to_s.end_with?('_page') || super
  end

  def self.close!
    @browser.quit
  end

  private_class_method :new
end

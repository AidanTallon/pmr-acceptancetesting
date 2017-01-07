class App
  def self.browser=(browser)
    @@browser = browser
  end

  def self.browser
    @@browser
  end

  def self.method_missing(method_name, *arguments, &block)
    # Initializes App.page_object if it doesn't already exist
    @@pages ||= {}
    class_name = method_name.to_s.split('_').collect(&:capitalize).join
    @@pages[method_name] || @@pages[method_name] = Object.const_get(class_name).new(@@browser)
  end

  def self.close!
    @@browser.quit
  end

  def self.logout
    @@browser.goto "#{EnvConfig.base_url}/logout"
  end

  private_class_method :new
end

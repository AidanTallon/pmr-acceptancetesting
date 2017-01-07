class IndexPage < GenericPage

  def initialize(browser)
    super browser
    @url = EnvConfig.base_url
    @trait = @browser.div(id: 'Toolbar') # RUBBISH TRAIT. NEEDS TO CHANGE
  end

  def click_overlay_button(button)
    options = {
      help: 'clickHelpNav()',
      about: 'clickAboutNav()',
      settings: 'clickSettingsNav()',
      share: 'clickShareNav()'
    }
    @browser.div(id: 'Toolbar').button(onclick: options[button]).click
  end

  def overlay_visible?(overlay)
    options = {
      none: '',
      help: 'HelpOverlay',
      about: 'AboutOverlay',
      settings: 'SettingsOverlay',
      share: 'ShareOverlay'
    }
    if overlay == :none
      options.each do |key, screen|
        next if key == :none
        begin
          Watir::Wait.until(timeout: 2) { @browser.div(id: screen).style.include? 'height: 0%' }
        rescue
          return false
        end
      end
    elsif options.keys.include? overlay
      begin
        Watir::Wait.until(timeout: 2) { @browser.div(id: options[overlay]).style.include? 'height: 100%' }
      rescue
        return false
      end
    end
  end


end

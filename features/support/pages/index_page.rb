class IndexPage < GenericPage

  @char_div_mapper = { # Is subject to change!
    darkrai:       'CharDiv00',
    blaziken:      'CharDiv01',
    pikachu:       'CharDiv02',
    lucario:       'CharDiv03',
    gardevoir:     'CharDiv04',
    pikachu_libre: 'CharDiv05',
    sceptile:      'CharDiv11',
    gengar:        'CharDiv12',
    machamp:       'CharDiv14',
    braixen:       'CharDiv15',
    mewtwo:        'CharDiv20',
    chandelure:    'CharDiv21',
    suicune:       'CharDiv22',
    weavile:       'CharDiv23',
    charizard:     'CharDiv24',
    garchomp:      'CharDiv25',
    shadow_mewtwo: 'CharDiv26'
  }

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

  def assign_matchup_value(char1, char2, value)
    char_div_1 = @browser.div(id: @char_div_mapper[char1.to_sym])
    char_div_2 = @browser.div(id: @char_div_mapper[char2.to_sym])
    click_character char1
    click_character char2
    set_matchup_value value
    click_submit
  end

  def click_character(char)
    char_div = @browser.div(id: @char_div_mapper[char1.to_sym])
    char_div.button.click
  end

  def set_matchup_value(value)
    #TODO: HOW!!!
  end

  def click_submit
    @browser.div(class: 'MiddleSelectDiv').button(class: 'SubmitButton').click
  end




end

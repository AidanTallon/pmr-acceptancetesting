class IndexPage < GenericPage


  def initialize(browser)
    super browser
    @url = EnvConfig.base_url
    @trait = @browser.div(id: 'Toolbar') # RUBBISH TRAIT. NEEDS TO CHANGE
  end

  def char_div_mapper
    { # Is subject to change!
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
  end

  def track_bar
    @browser.input(id: 'MatchupTrackBar')
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
    char_div_1 = @browser.div(id: char_div_mapper[char1.to_sym])
    char_div_2 = @browser.div(id: char_div_mapper[char2.to_sym])
    click_character char1
    click_character char2
    set_matchup_value value
    click_submit
  end

  def click_character(char)
    char_div = @browser.div(id: char_div_mapper[char.to_sym])
    char_div.button.click
  end

  def set_matchup_value(value)
    #TODO: HOW!!!
  end

  def click_submit
    @browser.div(class: 'MiddleSelectDiv').button(class: 'SubmitButton').click
  end

  def get_middle_select_text
    @browser.div(class: 'MiddleSelectDiv').text
  end

  def selected_characters_are?(params)
    if params[:primary]
      return false unless primary_character_is? params[:primary]
    end
    if params[:secondary]
      return false unless secondary_character_is? params[:secondary]
    end
  end

  def primary_character_is?(char)
    begin
      Watir::Wait.until(timeout: 3) { @browser.img(id: 'CharOnePortrait').src.include? "img/portraits/#{char.to_s.gsub('_', '')}.png" }
      return true
    rescue
      return false
    end
  end

  def secondary_character_is?(char)
    begin
      Watir::Wait.until(timeout: 3) { @browser.img(id: 'CharTwoPortrait').src.include? "img/portraits/#{char.to_s.gsub('_', '')}.png" }
      return true
    rescue
      return false
    end
  end

  def track_bar_enabled?
    track_bar.enabled?
  end

  def matchup_label_for(character)
    @browser.div(id: char_div_mapper[character.to_sym]).label(class: 'MatchupLabel')
  end

  def all_matchup_labels_blank?
    char_div_mapper.each do |key, value|
      return false if matchup_label_for(key).text != ''
    end
  end
end

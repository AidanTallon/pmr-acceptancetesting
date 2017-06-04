#frozen_string_literal: true

## Experimental index page using fluent interface stuff

# Index page. Use like App.index_page
class IndexPage < GenericPage
  def initialize(browser)
    super browser
    @url = EnvConfig.base_url
    @trait = @browser.div(tid: 'toolbar') # RUBBISH TRAIT
  end

  def char_index_mapper
    [
      'darkrai',
      'blaziken',
      'pikachu',
      'lucario',
      'gardevoir',
      'pikachu_libre',
      'sceptile',
      'gengar',
      'machamp',
      'braixen',
      'mewtwo',
      'chandelure',
      'suicune',
      'weavile',
      'charizard',
      'garchomp',
      'shadow_mewtwo'
    ]
  end

  def char_div_mapper
    {
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

  # Action Methods

  def click_overlay_button(button)
    overlay_button(button).click
    return self
  end

  def assign_matchup_value(char1, char2, value)
    set_characters(char1, char2)
    set_range_input value
    submit_matchup_button.click
    return self
  end

  def click_character(char)
    character_div(char).click
    return self
  end

  def set_characters(primary, secondary = :none)
    deselect_primary_character
    if primary != :none
      click_character primary.to_sym
      if secondary != :none
        click_character secondary.to_sym
      end
    end
    return self
  end

  def deselect_primary_character
    button = @browser.button(id: 'CharOneRemoveButton')
    button.click if button.visible?
    return self
  end

  def deselect_secondary_character
    button = @browser.button(id: 'CharTwoRemoveButton')
    button.click if button.visible?
  end

  def set_range_input(value)
    range = @browser.input(tid: 'track-bar')
    range.click # Click to reset to 0
    if value.positive?
      value.times do
        range.send_keys :arrow_right
      end
    elsif value.negative?
      (-value).times do
        range.send_keys :arrow_left
      end
    end
  end

  # Page Properties and Verification

  def overlays_closed?
    overlays = @browser.divs(tid: /.+-overlay/)
    closed = true
    overlays.each do |o|
      begin
        Watir::Wait.until(timeout: 2) do
          o.style.include? 'height: 0%'
        end
      rescue
        closed = false
      end
    end
    return closed
  end

  def overlay_visible?(name)
    begin
      Watir::Wait.until(timeout: 2) do
        overlay(name).style.include? 'height: 100%'
      end
    rescue
      return false
    end
  end

  # why does this take params instead of two arguments?
  def selected_characters_are?(params)
    if params[:primary]
      return false unless primary_character_is? params[:primary]
    end
    if params[:secondary]
      return false unless secondary_character_is? params[:secondary]
    end
  end

  # why do we need to wait for 3 seconds?
  def primary_character_is?(char)
    begin
      Watir::Wait.until(timeout: 3) do
        image = @browser.img(id: 'CharOnePortrait')
        image.visible? and image.src.include? "img/portraits/#{char.to_s.delete('_')}.png"
      end
      return true
    rescue
      return false
    end
  end

  # why do we need to wait for 3 seconds?
  def secondary_character_is?(char)
    begin
      Watir::Wait.until(timeout: 3) do
        image = @browser.img(id: 'CharTwoPortrait')
        image.visible? and image.src.include? "img/portraits/#{char.to_s.delete('_')}.png"
      end
      return true
    rescue
      return false
    end
  end

  def get_primary_character # Looks at image src. This should be reviewed
    image = @browser.img(id: 'CharOnePortrait')
    return nil unless image.visible?
    match = image.src.match %r{img/portraits/(.+)\.png}
    return nil if match.nil?
    match.captures[0].tr(' ', '_')
  end

  def get_secondary_character
    image = @browser.img(id: 'CharTwoPortrait')
    return nil unless image.visible?
    match = image.src.match %r{img/portraits/(.+)\.png}
    return nil if match.nil?
    match.captures[0].tr(' ', '_')
  end

  def track_bar_enabled?
    track_bar.enabled?
  end

  def matchup_label_for(char)
    @browser.div(id: char_div_mapper[char.to_sym]).label(class: 'MatchupLabel')
  end

  def all_matchup_labels_blank?
    char_div_mapper.each do |key, _value|
      return false if matchup_label_for(key).text != ''
    end
  end

  def helper_text
    helper_container.text
  end

  # Page Elements

  def track_bar
    @browser.input(tid: 'track-bar')
  end

  def overlay_button(button)
    options = {
      help:     'help-button',
      about:    'about-button',
      settings: 'settings-button',
      share:    'share-button'
    }
    @browser.button(tid: options[button])
  end

  def overlay(name)
    options = {
      help:     'help-overlay',
      about:    'about-overlay',
      settings: 'settings-overlay',
      share:    'share-overlay'
    }
    @browser.div(tid: options[name])
  end

  def submit_matchup_button
    @browser.button(tid: 'submit-matchup-button')
  end

  def deselect_primary_character_button
    @browser.button(tid: 'deselect-primary-character-button')
  end

  def deselect_secondary_character_button
    @browser.button(tid: 'deselect-secondary-character-button')
  end

  def delete_matchup_button
    @browser.button(tid: 'delete-matchup-button')
  end

  def character_div(char)
    @browser.div(id: char_div_mapper[char.to_sym])
  end

  def helper_container
    @browser.span(id: 'HelperText')
  end

  def toggle_matchups_button
    @browser.button(tid: 'matchup-toggle-button')
  end

  def matchups_hidden?
    text = toggle_matchups_button.text
    if text =~ /hide/i
      return false
    elsif text =~ /show/i
      return true
    end
  end

  def input_data_from_hash(data)
    data.each do |key, value|
      pri_character = key.downcase.gsub(' ', '_').to_sym
      set_characters pri_character
      value.each_with_index do |matchup, i|
        unless matchup.nil?
          sec_character = char_index_mapper[i].to_sym
          if matchup_label_for(sec_character).text == '' # Only input value if no matchup recorded
            assign_matchup_value(key.downcase.gsub(' ', '_').to_sym, char_index_mapper[i].to_sym, matchup)
          elsif matchup_label_for(sec_character).text != matchup.to_s # If matchup already recorded, make sure it is the same value
            binding.pry
            raise "Data error. Matchup values not consistent in data. Check values for #{pri_character}, #{sec_character}"
          end
        end
      end
    end
  end

  def assert_matchups_from_hash(data)
    data.each do |key, value|
      pri_character = key.downcase.gsub(' ', '_').to_sym
      set_characters pri_character
      value.each_with_index do |matchup, i|
        sec_character = char_index_mapper[i].to_sym
        expected_value = matchup.to_s
        unless matchup_label_for(sec_character).text == expected_value
          raise "Matchup label showing wrong value for #{pri_character}, #{sec_character}. Expected: #{expected_value}. Got: #{matchup_label_for(sec_character).text}."
        end
      end
    end
  end
end

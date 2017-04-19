#frozen_string_literal: true

# Share tab accessed from index page.
# Use like App.share_page
class SharePage < GenericPage
  def initialize(browser)
    super browser
    @url = EnvConfig.base_url
    @trait = @browser.div(tid: 'toolbar') # placeholder trait
  end

  # Action methods

  def click_overlay_button(button)
    overlay_button(button).click
    case button
      when :share
        return App.index_page
      else
        return App.index_page
    end
  end

  def click_character(character)
    character_button(character).click
  end

  # Page Information and Verification

  def matchups_image_visible?
    begin
     Watir::Wait.until(timeout: 1) do
      matchups_image.visible?
      end
     return true
    rescue
      return false
    end
  end

  # Page elements

  def character_button(character)
    @browser.button(title: character.to_s.gsub('_', ' ').capitalize)
  end

  def overlay_button(button)
    options = {
      help:     'help-overlay',
      about:    'about-overlay',
      settings: 'settings-overlay',
      share:    'share-overlay'
    }
    @browser.div(tid: options[button])
  end

  def matchups_image
    @browser.canvas(id: 'ShareCanvas')
  end
end

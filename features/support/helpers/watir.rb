# Patch watir to support attribute tid (test id) for testing purposes

module Watir
  class Element
    def tid
      attribute_value('tid')
    end

  end
end

module Watir
  module Locators
    class Element
      class SelectorBuilder
        alias :old_assert_valid_as_attribute :assert_valid_as_attribute
        def assert_valid_as_attribute(attribute)
          if attribute == :tid
            return
          else
            old_assert_valid_as_attribute(attribute)
          end
        end
      end
    end
  end
end

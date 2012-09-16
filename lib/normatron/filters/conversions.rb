module Normatron
  module Filters
    module Conversions
      class << self

        ##
        # Convert a blank string on a nil object.
        # 
        # @example
        #   StringInflections.blank("")   #=> nil
        #   StringInflections.blank("  ") #=> nil
        #   StringInflections.blank("\n") #=> nil
        #   StringInflections.blank("1")  #=> "1"
        #   StringInflections.blank(0)    #=> 0
        # @param [String] value Any character sequence
        # @return [String, nil] The object itself or nil
        # 
        # @see http://api.rubyonrails.org/classes/String.html#method-i-blank-3F ActiveSupport::CoreExt::Object#blank?
        def blank(value)
          if Filters.is_a_string?(value)
            value.to_s.blank? ? nil : value
          else
            value
          end
        end
      end
    end
  end
end
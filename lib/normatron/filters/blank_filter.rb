module Normatron
  module Filters
    
    ##
    # Returns nil for a blank string or the string itself otherwise.
    # 
    # @example Out of box
    #   BlankFilter.evaluate("")            #=> nil
    #   BlankFilter.evaluate("     ")       #=> nil
    #   BlankFilter.evaluate("  \n ")       #=> nil
    #   BlankFilter.evaluate("1")           #=> "1"
    #   BlankFilter.evaluate("It's blank?") #=> "It's blank?"
    #
    # @example Using as model normalizer
    #   normalize :attribute_a, :with => :blank
    #   normalize :attribute_b, :with => [:custom_filter, :blank]
    #
    # @see http://api.rubyonrails.org/classes/String.html#method-i-blank-3F String#blank?
    module BlankFilter

      ##
      # Performs input conversion according to filter requirements.
      #
      # This method returns the object itself when the first argument is not a String.
      #
      # @param  input [String] The String to be filtered
      # @return [String, nil] The object itself or nil
      def self.evaluate(input)
        input.kind_of?(String) && input.blank? ? nil : input
      end
    end
  end
end
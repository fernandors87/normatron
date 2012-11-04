require 'normatron/filters/helpers'

module Normatron
  module Filters
    
    ##
    # Replaces all underscores with dashes.
    # 
    # @example Out of box
    #   DasherizeFilter.call("monty_python") #=> "monty-python"
    #
    # @example Using as model normalizer
    #   normalize :attribute_a, :with => :dasherize
    #   normalize :attribute_b, :with => [:custom_filter, :dasherize]
    #
    # @see http://api.rubyonrails.org/classes/String.html#method-i-dasherize String#dasherize
    module DasherizeFilter

      ##
      # Performs input conversion according to filter requirements.
      #
      # This method returns the object itself when the first argument is not a String.
      #
      # @param  input [String] The String to be filtered
      # @return [String] A new dasherized String
      def self.call(input)
        input.kind_of?(String) ? input.dasherize : input
      end
    end
  end
end
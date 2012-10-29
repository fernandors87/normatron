require 'normatron/filters/helpers'

module Normatron
  module Filters
    
    ##
    # Makes the first character uppercase and all remaining characters lowercase.
    # 
    # @example Out of box
    #   CapitalizeFilter.evaluate("KEEP IT SIMPLE")  #=> "Keep it simple"
    #   CapitalizeFilter.evaluate("keep it simple")  #=> "Keep it simple"
    #   CapitalizeFilter.evaluate(" KEEP IT SIMPLE") #=> " keep it simple"
    #
    # @example Using as model normalizer
    #   normalize :attribute_a, :with => :capitalize
    #   normalize :attribute_b, :with => [:custom_filter, :capitalize]
    #
    # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-capitalize String#capitalize
    # @see TitleizeFilter Normatron::Filters::TitleizeFilter
    module CapitalizeFilter
      extend Helpers

      ##
      # Performs input conversion according to filter requirements.
      #
      # This method returns the object itself when the first argument is not a String.
      #
      # @param  input [String] The String to be filtered
      # @return [String] A new capitalized String
      def self.evaluate(input)
        input.kind_of?(String) ? mb_send(:capitalize, input) : input
      end
    end
  end
end
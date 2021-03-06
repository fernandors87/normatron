require 'normatron/filters/helpers'

module Normatron
  module Filters
    
    ##
    # Strip input, remove line-breaks and multiple spaces.
    # 
    # @example Out of box
    #   SquishFilter.call("   the simpsons   ") #=> "the simpsons"
    #   SquishFilter.call("family      guy")    #=> "family guy"
    #   SquishFilter.call("the \n simpsons")    #=> "the simpsons"
    #   SquishFilter.call("the\nsimpsons")      #=> "the simpsons"
    #
    # @example Using as ActiveRecord::Base normalizer
    #   normalize :attribute, :with => [:custom_filter, :squish]
    #
    # @see http://api.rubyonrails.org/classes/String.html#method-i-squish String#squish
    # @see SqueezeFilter Normatron::Filters::SqueezeFilter
    # @see StripFilter  Normatron::Filters::StripFilter
    module SquishFilter

      ##
      # Performs input conversion according to filter requirements.
      #
      # This method returns the object itself when the first argument is not a String.
      #
      # @param input [String] The String to be filtered
      # @return [String] A new squished String
      def self.call(input)
        input.kind_of?(String) ? input.squish : input
      end
    end
  end
end
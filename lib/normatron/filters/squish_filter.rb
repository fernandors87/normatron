require 'normatron/filters/helpers'

module Normatron
  module Filters
    module SquishFilter

      ##
      # Strip input, remove line-breaks and multiple spaces.
      # 
      # @example
      #   SquishFilter.evaluate("   the simpsons   ") #=> "the simpsons"
      #   SquishFilter.evaluate("family      guy")    #=> "family guy"
      #   SquishFilter.evaluate("the \n simpsons")    #=> "the simpsons"
      #   SquishFilter.evaluate("the\nsimpsons")      #=> "the simpsons"
      #
      # @example Using as ActiveRecord::Base normalizer
      #   normalize :attribute, :with => [:custom_filter, :squish]
      #
      # @param [String] input A character sequence
      # @return [String] The clean character sequence or the object itself
      # @see http://api.rubyonrails.org/classes/String.html#method-i-squish String#squish
      # @see SqueezeFilter Normatron::Filters::SqueezeFilter
      def self.evaluate(input)
        input.kind_of?(String) ? input.squish : input
      end
    end
  end
end
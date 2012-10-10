require 'normatron/filters/helpers'

module Normatron
  module Filters
    module CapitalizeFilter
      extend Helpers

      ##
      # Makes the first character uppercase after lowercase all other characters.
      # 
      # @example
      #   CapitalizeFilter.evaluate("KEEP IT SIMPLE")  #=> "Keep it simple"
      #   CapitalizeFilter.evaluate("keep it simple")  #=> "Keep it simple"
      #   CapitalizeFilter.evaluate(" KEEP IT SIMPLE") #=> " keep it simple"
      #
      # @example Using as ActiveRecord::Base normalizer
      #   normalize :attribute_a, :with => :capitalize
      #   normalize :attribute_b, :with => [:custom_filter, :capitalize]
      #
      # @param [String] input A character sequence
      # @return [String] The capitalized character sequence or the object itself
      # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-capitalize String#capitalize
      # @see TitleizeFilter Normatron::Filters::TitleizeFilter
      def self.evaluate(input)
        input.kind_of?(String) ? mb_send(:capitalize, input) : input
      end
    end
  end
end
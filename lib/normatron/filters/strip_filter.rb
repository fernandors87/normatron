require 'normatron/filters/helpers'

module Normatron
  module Filters
    module StripFilter
      extend Helpers

      ##
      # Remove traling and/or leading spaces from the string.
      # 
      # @example
      #   StripFilter.evaluate("   copy   ")      #=> "copy"
      #   StripFilter.evaluate("   copy   ", :L)  #=> "copy   "
      #   StripFilter.evaluate("   copy   ", :R)  #=> "   copy"
      #   StripFilter.evaluate("   copy   ", :LR) #=> "copy"
      #
      # @example Using as ActiveRecord::Base normalizer
      #   normalize :attribute_a, :with => :strip
      #   normalize :attribute_b, :with => { :strip => :L }
      #   normalize :attribute_c, :with => [:custom_filter, :strip]
      #   normalize :attribute_d, :with => [:custom_filter, [:strip, :L]]
      #   normalize :attribute_e, :with => [:custom_filter, {:strip => :R}]
      #
      # @param [String] input A character sequence
      # @param [Symbol] option :L to strip trailing spaces, :R for leading spaces and :LR for both
      # @return [String] The character sequence without trailing and leading spaces or the object itself
      # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-strip String#strip
      def self.evaluate(input, option=:LR)
        input.kind_of?(String) ? evaluate_strip(input, option) : input
      end
    end
  end
end
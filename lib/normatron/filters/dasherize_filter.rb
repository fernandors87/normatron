require 'normatron/filters/helpers'

module Normatron
  module Filters
    module DasherizeFilter

      ##
      # Replaces all underscores with dashes.
      # 
      # @example
      #   DasherizeFilter.evaluate("monty_python") #=> "monty-python"
      #
      # @example Using as ActiveRecord::Base normalizer
      #   normalize :attribute_a, :with => :dasherize
      #   normalize :attribute_b, :with => [:custom_filter, :dasherize]
      #
      # @param [String] input A character sequence
      # @return [String] The dasherized character sequence or the object itself
      # @see http://api.rubyonrails.org/classes/String.html#method-i-dasherize String#dasherize
      def self.evaluate(input)
        input.kind_of?(String) ? input.dasherize : input
      end
    end
  end
end
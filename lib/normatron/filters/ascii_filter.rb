require 'stringex/unidecoder'

module Normatron
  module Filters
    module AsciiFilter

      ##
      # Converts Unicode(and accented ASCII) characters to their plain-text ASCII equivalents.
      # 
      # @example
      #   AsciiFilter.evaluate("EVOLUÇÃO")       #=> "EVOLUCAO"
      #   AsciiFilter.evaluate("⠋⠗⠁⠝⠉⠑")      #=> "france"
      #
      # @example Using as ActiveRecord::Base normalizer
      #   normalize :attribute_a, :with => :ascii
      #   normalize :attribute_b, :with => [:custom_filter, :ascii]
      #
      # @param [String] input A character sequence
      # @return [String] The transliterated character sequence or the object itself
      # @see http://rubydoc.info/gems/stringex/Stringex/Unidecoder Stringex::Unidecoder
      def self.evaluate(input, *args)
        input.kind_of?(String) ? Stringex::Unidecoder.decode(input) : input
      end
    end
  end
end
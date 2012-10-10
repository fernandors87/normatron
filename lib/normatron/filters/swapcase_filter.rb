require 'normatron/filters/helpers'

module Normatron
  module Filters
    module SwapcaseFilter
      extend Helpers

      ##
      # Replaces uppercased characters by lowercased and vice versa.
      # 
      # @example
      #   SwapcaseFilter.evaluate("As you Wish!") #=> "aS YOU wISH!"
      #
      # @example Using as ActiveRecord::Base normalizer
      #   normalize :attribute_a, :with => :swapcase
      #   normalize :attribute_b, :with => [:custom_filter, :swapcase]
      #
      # @param [String] input A character sequence
      # @return [String] The swapped case character sequence or the object itself
      # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-swapcase String#swapcase
      # @see DownFilter Normatron::Filters::DownFilter
      # @see TitleizeFilter Normatron::Filters::TitleizeFilter
      # @see UpcaseFilter Normatron::Filters::UpcaseFilter
      def self.evaluate(input)
        return input unless input.kind_of?(String)
        input.gsub(/([\p{Ll}])|(\p{Lu})|([^\p{Ll}\p{Lu}])/u) { $3 || ($2 ? mb_send(:downcase, $2) : mb_send(:upcase, $1)) }
      end
    end
  end
end
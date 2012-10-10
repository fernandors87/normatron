require 'normatron/filters/helpers'

module Normatron
  module Filters
    module DowncaseFilter
      extend Helpers

      ##
      # Lowercase all characters.
      # 
      # @example
      #   DowncaseFilter.evaluate("NOTHING ELSE MATTERS") #=> "nothing else matters"
      #
      # @example Using as ActiveRecord::Base normalizer
      #   normalize :attribute_a, :with => :downcase
      #   normalize :attribute_b, :with => [:custom_filter, :downcase]
      #
      # @param [String] input A character sequence
      # @return [String] The lowercased character sequence or the object itself
      # @see http://api.rubyonrails.org/classes/ActiveSupport/Multibyte/Chars.html#method-i-downcase ActiveSupport::Multibyte::Chars#downcase
      # @see SwapcaseFilter Normatron::Filters::SwapcaseFilter
      # @see TitleizeFilter Normatron::Filters::TitleizeFilter
      # @see UpcaseFilter Normatron::Filters::UpcaseFilter
      def self.evaluate(input)
        input.kind_of?(String) ? mb_send(:downcase, input) : input
      end
    end
  end
end
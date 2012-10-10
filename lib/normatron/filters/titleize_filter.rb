require 'normatron/filters/helpers'

module Normatron
  module Filters
    module TitleizeFilter
      extend Helpers

      ##
      # Capitalizes the first character of each word.
      # 
      # @example
      #   TitleizeFilter.evaluate("at your will!") #=> "At Your Will!"
      #
      # @example Using as ActiveRecord::Base normalizer
      #   normalize :attribute_a, :with => :titleize
      #   normalize :attribute_b, :with => [:custom_filter, :titleize]
      #
      # @param [String] input A character sequence
      # @return [String] The titleized character sequence or the object itself
      # @see http://api.rubyonrails.org/classes/ActiveSupport/Multibyte/Chars.html#method-i-titleize ActiveSupport::Multibyte::Chars#titleize
      # @see DownFilter Normatron::Filters::DownFilter
      # @see SwapcaseFilter Normatron::Filters::SwapcaseFilter
      # @see UpcaseFilter Normatron::Filters::UpcaseFilter
      def self.evaluate(input)
        input.kind_of?(String) ? mb_send(:titleize, input) : input
      end
    end
  end
end
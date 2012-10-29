require 'normatron/filters/helpers'

module Normatron
  module Filters
    
    ##
    # Lowercase all characters.
    # 
    # @example Out of box
    #   DowncaseFilter.evaluate("NOTHING ELSE MATTERS") #=> "nothing else matters"
    #
    # @example Using as ActiveRecord::Base normalizer
    #   normalize :attribute_a, :with => :downcase
    #   normalize :attribute_b, :with => [:custom_filter, :downcase]
    #
    # @see http://api.rubyonrails.org/classes/ActiveSupport/Multibyte/Chars.html#method-i-downcase ActiveSupport::Multibyte::Chars#downcase
    # @see SwapcaseFilter Normatron::Filters::SwapcaseFilter
    # @see TitleizeFilter Normatron::Filters::TitleizeFilter
    # @see UpcaseFilter   Normatron::Filters::UpcaseFilter
    module DowncaseFilter
      extend Helpers

      ##
      # Performs input conversion according to filter requirements.
      #
      # This method returns the object itself when the first argument is not a String.
      #
      # @param input [String] The String to be filtered
      # @return [String] A new lowercased String
      def self.evaluate(input)
        input.kind_of?(String) ? mb_send(:downcase, input) : input
      end
    end
  end
end
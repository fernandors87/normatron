require 'normatron/filters/helpers'

module Normatron
  module Filters
    
    ##
    # Replaces uppercased characters by lowercased and vice versa.
    # 
    # @example Out of box
    #   SwapcaseFilter.evaluate("As you Wish!") #=> "aS YOU wISH!"
    #
    # @example Using as ActiveRecord::Base normalizer
    #   normalize :attribute_a, :with => :swapcase
    #   normalize :attribute_b, :with => [:custom_filter, :swapcase]
    #
    # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-swapcase String#swapcase
    # @see DownFilter     Normatron::Filters::DownFilter
    # @see TitleizeFilter Normatron::Filters::TitleizeFilter
    # @see UpcaseFilter   Normatron::Filters::UpcaseFilter
    module SwapcaseFilter
      extend Helpers

      ##
      # Performs input conversion according to filter requirements.
      #
      # This method returns the object itself when the first argument is not a String.
      #
      # @param input [String] The String to be filtered
      # @return [String] A new swapcased String
      def self.evaluate(input)
        return input unless input.kind_of?(String)
        input.gsub(/([\p{Ll}])|(\p{Lu})|([^\p{Ll}\p{Lu}])/u) { $3 || ($2 ? mb_send(:downcase, $2) : mb_send(:upcase, $1)) }
      end
    end
  end
end
require 'normatron/filters/helpers'

module Normatron
  module Filters
    module BlankFilter

      ##
      # Returns nil for a blank string or the string itself otherwise.
      # 
      # @example
      #   BlankFilter.evaluate("")            #=> nil
      #   BlankFilter.evaluate("     ")       #=> nil
      #   BlankFilter.evaluate("  \n ")       #=> nil
      #   BlankFilter.evaluate("1")           #=> "1"
      #   BlankFilter.evaluate("It's blank?") #=> "It's blank?"
      #
      # @example Using as ActiveRecord::Base normalizer
      #   normalize :attribute_a, :with => :blank
      #   normalize :attribute_b, :with => [:custom_filter, :blank]
      #
      # @param input [String] A character sequence
      # @return [String, nil] The object itself or nil
      # @see http://api.rubyonrails.org/classes/String.html#method-i-blank-3F String#blank?
      def self.evaluate(input)
        input.kind_of?(String) && input.blank? ? nil : input
      end
    end
  end
end
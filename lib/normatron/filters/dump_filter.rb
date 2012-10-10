module Normatron
  module Filters
    module DumpFilter

      ##
      # Creates a literal string representation with all nonprinting characters
      # replaced by <tt>\\n</tt> notation and all special characters escaped.
      # 
      # @example
      #   DumpFilter.evaluate("I'm not\na \"clubber\"...") #=> "\"I'm not\\na \\\"clubber\\\"...\""
      #   DumpFilter.evaluate("I'm not\na \"clubber\"...") #== '"I\'m not\na \"clubber\"..."'
      #   DumpFilter.evaluate('I\'m not\na "clubber"...')  #=> "\"I'm not\\\\na \\\"clubber\\\"...\""
      #   DumpFilter.evaluate('I\'m not\na "clubber"...')  #== '"I\'m not\\\na \"clubber\"..."'
      #
      # @example Using as ActiveRecord::Base normalizer
      #   normalize :attribute_a, :with => :dump
      #   normalize :attribute_b, :with => [:custom_filter, :dump]
      #
      # @param [String] input A character sequence
      # @return [String] The dumpped character sequence or the object itself
      # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-dump String#dump
      def self.evaluate(input)
        input.kind_of?(String) ? input.dump : input
      end
    end
  end
end
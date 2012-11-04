module Normatron
  module Filters
    
    ##
    # Creates a literal string representation with all nonprinting characters replaced by @\\n@ notation and all
    # special characters escaped.
    # 
    # @example Out of box
    #   DumpFilter.call("I'm not\na \"clubber\"...") #=> "\"I'm not\\na \\\"clubber\\\"...\""
    #   DumpFilter.call("I'm not\na \"clubber\"...") #== '"I\'m not\na \"clubber\"..."'
    #   DumpFilter.call('I\'m not\na "clubber"...')  #=> "\"I'm not\\\\na \\\"clubber\\\"...\""
    #   DumpFilter.call('I\'m not\na "clubber"...')  #== '"I\'m not\\\na \"clubber\"..."'
    #
    # @example Using as ActiveRecord::Base normalizer
    #   normalize :attribute_a, :with => :dump
    #   normalize :attribute_b, :with => [:custom_filter, :dump]
    #
    # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-dump String#dump
    module DumpFilter

      ##
      # Performs input conversion according to filter requirements.
      #
      # This method returns the object itself when the first argument is not a String.
      #
      # @param input [String] The String to be filtered
      # @return [String] A new dumpped String
      def self.call(input)
        input.kind_of?(String) ? input.dump : input
      end
    end
  end
end
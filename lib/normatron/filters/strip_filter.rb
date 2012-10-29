require 'normatron/filters/helpers'

module Normatron
  module Filters
    
    ##
    # Removes traling and leading spaces.
    # 
    # @example Out of box
    #   StripFilter.evaluate("   copy   ")      #=> "copy"
    #   StripFilter.evaluate("   copy   ", :L)  #=> "copy   "
    #   StripFilter.evaluate("   copy   ", :R)  #=> "   copy"
    #   StripFilter.evaluate("   copy   ", :LR) #=> "copy"
    #
    # @example Using as ActiveRecord::Base normalizer
    #   normalize :attribute_a, :with => :strip
    #   normalize :attribute_b, :with => { :strip => :L }
    #   normalize :attribute_c, :with => [:custom_filter, :strip]
    #   normalize :attribute_d, :with => [:custom_filter, [:strip, :L]]
    #   normalize :attribute_e, :with => [:custom_filter, {:strip => :R}]
    #
    # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-strip String#strip
    # @see SqueezeFilter Normatron::Filters::SqueezeFilter
    # @see SquishFilter Normatron::Filters::SquishFilter
    module StripFilter
      extend Helpers

      ##
      # Performs input conversion according to filter requirements.
      #
      # This method returns the object itself when the first argument is not a String.
      #
      # @param input [String] The String to be filtered
      # @param edges [Symbol] @:L@ to strip trailing spaces, @:R@ for leading spaces or @:LR@ for both
      # @return [String] A new stripped String
      def self.evaluate(input, edges=:LR)
        return input unless input.kind_of?(String)
        
        regex_string = 
          case edges
            when :L
              '\A\s*'
            when :R
              '\s*\z'
            when :LR
              '\A\s*|\s*\z'
          end
        regex = Regexp.new(/#{regex_string}/)
        input.gsub(regex, '')
      end
    end
  end
end
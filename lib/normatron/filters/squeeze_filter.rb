module Normatron
  module Filters
    
    ##
    # Remove multiple occurences of the same character.
    #
    # If no option are given, all runs of identical characters are replaced by a single character.
    # 
    # @example Out of box
    #   SqueezeFilter.evaluate("yellow    moon")             #=> "yelow mon"
    #   SqueezeFilter.evaluate("  now   is  the", " ")       #=> " now is the"
    #   SqueezeFilter.evaluate("putters shoot balls", "m-z") #=> "puters shot balls"
    #
    # @example Using as ActiveRecord::Base normalizer
    #   normalize :attribute_a, :with => [:custom_filter, :squeeze]
    #   normalize :attribute_b, :with => [:custom_filter, [:squeeze, "a-f"]]
    #   normalize :attribute_c, :with => [:custom_filter, {:squeeze => ["a-f"]}]
    #
    # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-squeeze String#squeeze
    # @see SquishFilter Normatron::Filters::SquishFilter
    # @see StripFilter  Normatron::Filters::StripFilter
    module SqueezeFilter

      ##
      # Performs input conversion according to filter requirements.
      #
      # This method returns the object itself when the first argument is not a String.
      #
      # @param input   [String]    The String to be filtered
      # @param targets [[String]*] Characters to be affected
      # @return [String] A new squeezed String
      def self.evaluate(input, *targets)
        return input unless input.kind_of?(String)
        targets.any? ? input.squeeze(targets.last) : input.squeeze
      end
    end
  end
end
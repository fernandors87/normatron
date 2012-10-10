module Normatron
  module Filters
    module SqueezeFilter

      ##
      # Remove multiple occurences of the same character.
      # If no option are given, all runs of identical characters are replaced by a single character.
      # 
      # @example
      #   SqueezeFilter.evaluate("yellow    moon")               #=> "yelow mon"
      #   SqueezeFilter.evaluate("  now   is  the", " ")         #=> " now is the"
      #   SqueezeFilter.evaluate("putters shoot balls", "m-z")   #=> "puters shot balls"
      #
      # @example Using as ActiveRecord::Base normalizer
      #   normalize :attribute_a, :with => [:custom_filter, :squeeze]
      #   normalize :attribute_b, :with => [:custom_filter, [:squeeze, "a-f"]]
      #   normalize :attribute_c, :with => [:custom_filter, {:squeeze => ["a-f"]}]
      #
      # @param [String] input A character sequence
      # @param [[String]*] targets Characters to be affected
      # @return [String] The clean character sequence or the object itself
      # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-squeeze String#squeeze
      # @see SquishFilter Normatron::Filters::SquishFilter
      def self.evaluate(input, *targets)
        return input unless input.kind_of?(String)
        targets.any? ? input.squeeze(targets.last) : input.squeeze
      end
    end
  end
end
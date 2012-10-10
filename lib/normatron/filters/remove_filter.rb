require 'normatron/filters/helpers'

module Normatron
  module Filters
    module RemoveFilter
      extend Helpers

      ##
      # Remove the characters that match the given properties.
      #
      # For additional informations see Normatron::Filter::ClassMethods#keep documentation.
      # 
      # @example
      #   RemoveFilter.evaluate("Quake 3", :L)      #=> " 3"        remove only letters
      #   RemoveFilter.evaluate("Quake 3", :N)      #=> "Quake "    remove only numbers
      #   RemoveFilter.evaluate("Quake 3", :L, :N)  #=> " "         remove only letters or numbers
      #   RemoveFilter.evaluate("Quake 3", :Lu, :N) #=> "uake "     remove only uppercased letters or numbers
      #   RemoveFilter.evaluate("Quake ˩", :Latin)  #=> " ˩"        remove only latin characters
      #
      # @example Using as ActiveRecord::Base normalizer
      #   normalize :attribute_a, :with => [[:remove, :Lu]]
      #   normalize :attribute_b, :with => [{:remove =>[:Lu]}]
      #   normalize :attribute_c, :with => [:custom_filter, [:remove, :Ll, :Space]]
      #   normalize :attribute_d, :with => [:custom_filter, {:remove => [:Ll, :Space]}]
      #
      # @param [String] input A character sequence
      # @param [[Symbol]*] properties Array of Symbols equivalent to Regexp property for \\p{} construct.
      # @return [String] The clean character sequence or the object itself
      # @see http://www.ruby-doc.org/core-1.9.3/Regexp.html Regexp
      # @see KeepFilter Normatron::Filters::KeepFilter
      # @todo Raise exception for empty properties
      def self.evaluate(input, *properties)
        input.kind_of?(String) ? evaluate_regexp(input, :remove, properties) : input
      end
    end
  end
end
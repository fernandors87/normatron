require 'normatron/filters/helpers'

module Normatron
  module Filters
    
    ##
    # Remove the characters that match the given properties.
    #
    # For additional informations see Normatron::Filter::ClassMethods#keep documentation.
    # 
    # @example Out of box
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
    # @see http://www.ruby-doc.org/core-1.9.3/Regexp.html Regexp
    # @see KeepFilter Normatron::Filters::KeepFilter
    module RemoveFilter
      extend Helpers

      ##
      # Performs input conversion according to filter requirements.
      #
      # This method returns the object itself when the first argument is not a String.
      #
      # @param input      [String]    The String to be filtered
      # @param properties [[Symbol]*] Symbols equivalent to Regexp property for @\\p{}@ construct
      # @return [String] A new clean String
      def self.evaluate(input, *properties)
        input.kind_of?(String) ? evaluate_regexp(input, :remove, properties) : input
      end
    end
  end
end
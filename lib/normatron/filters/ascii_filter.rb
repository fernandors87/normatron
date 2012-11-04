require 'stringex/unidecoder'

module Normatron
  module Filters
    
    ##
    # Converts Unicode(and accented ASCII) characters to their plain-text ASCII equivalents.
    # 
    # @example Out of box
    #   AsciiFilter.call("EVOLUÇÃO")  #=> "EVOLUCAO"
    #   AsciiFilter.call("⠋⠗⠁⠝⠉⠑")  #=> "france"
    #
    # @example Using as model normalizer
    #   normalize :attribute_a, :with => :ascii
    #   normalize :attribute_b, :with => [:custom_filter, :ascii]
    #
    # @see http://rubydoc.info/gems/stringex/Stringex/Unidecoder Stringex::Unidecoder
    module AsciiFilter

      ##
      # Performs input conversion according to filter requirements.
      #
      # This method returns the object itself when the first argument is not a String.
      #
      # @param  input [String] The String to be filtered
      # @return [String] A new transliterated String
      def self.call(input)
        input.kind_of?(String) ? Stringex::Unidecoder.decode(input) : input
      end
    end
  end
end
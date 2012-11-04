require 'normatron/filters/helpers'

module Normatron
  module Filters
    
    ##
    # Uppercase all characters.
    # 
    # @example Out of box
    #   UpcaseFilter.call("borderlands") #=> "BORDERLANDS"
    #
    # @example Using as ActiveRecord::Base normalizer
    #   normalize :attribute_a, :with => :upcase
    #   normalize :attribute_b, :with => [:custom_filter, :upcase]
    #
    # @see http://api.rubyonrails.org/classes/ActiveSupport/Multibyte/Chars.html#method-i-upcase ActiveSupport::Multibyte::Chars#upcase
    # @see DownFilter     Normatron::Filters::DownFilter
    # @see TitleizeFilter Normatron::Filters::TitleizeFilter
    # @see SwapcaseFilter Normatron::Filters::SwapcaseFilter
    module UpcaseFilter
      extend Helpers

      ##
      # Performs input conversion according to filter requirements.
      #
      # This method returns the object itself when the first argument is not a String.
      #
      # @param input [String] The String to be filtered
      # @return [String] A new uppercased String
      def self.call(input)
        input.kind_of?(String) ? mb_send(:upcase, input) : input
      end
    end
  end
end
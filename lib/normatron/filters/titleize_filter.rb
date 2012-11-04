require 'normatron/filters/helpers'

module Normatron
  module Filters
    
    ##
    # Capitalizes the first character of each word.
    # 
    # @example Out of box
    #   TitleizeFilter.call("at your will!") #=> "At Your Will!"
    #
    # @example Using as ActiveRecord::Base normalizer
    #   normalize :attribute_a, :with => :titleize
    #   normalize :attribute_b, :with => [:custom_filter, :titleize]
    #
    # @see http://api.rubyonrails.org/classes/ActiveSupport/Multibyte/Chars.html#method-i-titleize ActiveSupport::Multibyte::Chars#titleize
    # @see DownFilter     Normatron::Filters::DownFilter
    # @see SwapcaseFilter Normatron::Filters::SwapcaseFilter
    # @see UpcaseFilter   Normatron::Filters::UpcaseFilter
    module TitleizeFilter
      extend Helpers

      ##
      # Performs input conversion according to filter requirements.
      #
      # This method returns the object itself when the first argument is not a String.
      #
      # @param input [String] The String to be filtered
      # @return [String] A new titleized String
      def self.call(input)
        input.kind_of?(String) ? mb_send(:titleize, input) : input
      end
    end
  end
end
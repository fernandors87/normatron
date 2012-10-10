require 'normatron/filters/helpers'

module Normatron
  module Filters
    module UpcaseFilter
      extend Helpers

      ##
      # Uppercase all characters.
      # 
      # @example
      #   upcase("borderlands") #=> "BORDERLANDS"
      #
      # @example Using as ActiveRecord::Base normalizer
      #   normalize :attribute_a, :with => :upcase
      #   normalize :attribute_b, :with => [:custom_filter, :upcase]
      #
      # @return [String, Chars] The uppercased character sequence or the object itself
      # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-upcase String#upcase
      # @see http://api.rubyonrails.org/classes/ActiveSupport/Multibyte/Chars.html#method-i-upcase ActiveSupport::Multibyte::Chars#upcase
      # @see DownFilter Normatron::Filters::DownFilter
      # @see TitleizeFilter Normatron::Filters::TitleizeFilter
      # @see SwapcaseFilter Normatron::Filters::SwapcaseFilter
      def self.evaluate(input)
        input.kind_of?(String) ? mb_send(:upcase, input) : input
      end
    end
  end
end
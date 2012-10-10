require 'normatron/filters/helpers'

module Normatron
  module Filters
    module CamelizeFilter
      extend Helpers

      ##
      # Converts strings to UpperCamelCase by default and to lowerCamelCase if the <tt>:lower</tt> argument is given.
      # <tt>camelize</tt> will also convert '/' to '::' which is useful for converting paths to namespaces.
      # As a rule of thumb you can think of camelize as the inverse of underscore, though there are cases where that does not hold:
      #   "SSLError".underscore.camelize # => "SslError"
      # This filter has a similar behavior to
      # ActiveSupport::Inflector#camelize[http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-camelize], but with following differences:
      # * Uses UTF-8 charset
      # * Affects accented characters
      # 
      # @example
      #   CamelizeFilter.evaluate("active_record/errors")         #=> "ActiveRecord::Errors"
      #   CamelizeFilter.evaluate("active_record/errors", :upper) #=> "ActiveRecord::Errors"
      #   CamelizeFilter.evaluate("active_record/errors", :lower) #=> "activeRecord::Errors"
      #
      # @example Using as ActiveRecord::Base normalizer
      #   normalize :attribute_a, :with => :camelize
      #   normalize :attribute_b, :with => [:custom_filter, :camelize]
      #   normalize :attribute_c, :with => [[:camelize, :lower]]
      #   normalize :attribute_d, :with => [{:camelize => :lower}]
      #   normalize :attribute_e, :with => [:custom_filter, [:camelize, :lower]]
      #   normalize :attribute_f, :with => [:custom_filter, {:camelize => :lower}]
      #
      # @param [String] input A character sequence
      # @param [Symbol] first_letter_case <tt>:lower</tt> for lowerCamelCase or <tt>:upper</tt> for UpperCamelCase
      # @return [String] The camelized character sequence or the object itself
      # @see http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-camelize ActiveSupport::Inflector#camelize
      # @see UnderscoreFilter Normatron::Filters::UnderscoreFilter
      # @todo Performance tests
      # @todo Exception class
      def self.evaluate(input, first_letter_case = :upper)
        return input unless input.kind_of?(String)

        if first_letter_case == :upper
          string = input.sub(/^[\p{L}\d]*/u) { acronyms[$&] || mb_send(:capitalize, $&) }
        else first_letter_case == :lower
          string = input.sub(/^(?:#{acronym_regex}(?=\b|[\p{L}_])|\p{Word}*_)/u) { mb_send(:downcase, $&) }
        end
        string.gsub!(/(?:_|(\/))([\p{L}\d]*)/iu) { "#{$1}#{acronyms[$2] || mb_send(:capitalize, $2)}" }.gsub!('/', '::')
      end
    end
  end
end
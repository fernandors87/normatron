require 'normatron/filters/helpers'

module Normatron
  module Filters
    
    ##
    # Converts strings to UpperCamelCase by default and to lowerCamelCase if the @:lower@ argument is given.
    #
    # It will also convert '/' to '::' which is useful for converting paths to namespaces.
    #
    # As a rule of thumb you can think of camelize as the inverse of underscore, though there are cases where that does
    # not hold:
    #
    # pre. "SSLError".underscore.camelize # => "SslError"
    #
    # This filter has a similar behavior to
    # "ActiveSupport::Inflector#camelize (ActiveSupport camelize)":http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-camelize,
    # but it affects UTF-8 characters too.
    # 
    # @example Out of box
    #   CamelizeFilter.call("active_record/errors")         #=> "ActiveRecord::Errors"
    #   CamelizeFilter.call("active_record/errors", :upper) #=> "ActiveRecord::Errors"
    #   CamelizeFilter.call("active_record/errors", :lower) #=> "activeRecord::Errors"
    #
    # @example Using as model normalizer
    #   normalize :attribute_a, :with => :camelize
    #   normalize :attribute_b, :with => [:custom_filter, :camelize]
    #   normalize :attribute_c, :with => [[:camelize, :lower]]
    #   normalize :attribute_d, :with => [{:camelize => :lower}]
    #   normalize :attribute_e, :with => [:custom_filter, [:camelize, :lower]]
    #   normalize :attribute_f, :with => [:custom_filter, {:camelize => :lower}]
    #
    # @see http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-camelize ActiveSupport::Inflector#camelize
    # @see UnderscoreFilter Normatron::Filters::UnderscoreFilter
    module CamelizeFilter
      extend Helpers

      ##
      # Performs input conversion according to filter requirements.
      #
      # This method returns the object itself when the first argument is not a String.
      #
      # @param  input [String] The String to be filtered
      # @param  camel [Symbol] @:lower@ for lowerCamelCase or @:upper@ for UpperCamelCase
      # @return [String] A new camelized String
      def self.call(input, camel = :upper)
        return input unless input.kind_of?(String)

        string = mb_send(:downcase, input)
        string.sub!(/^[^_|\/]+/) { camel == :upper ? acronyms[$&] || mb_send(:capitalize, $&) : $& }
        string.gsub!(/(?:(\/)|_)([^\/|_]+)/) { "#{$1}#{acronyms[$2] || mb_send(:capitalize, $2)}" }
        string.gsub("/", "::")
      end
    end
  end
end
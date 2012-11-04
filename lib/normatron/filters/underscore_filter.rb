require 'normatron/filters/helpers'

module Normatron
  module Filters
    
    ##
    # Makes an underscored lowercase form from the expression in the string.
    #
    # Changes ‘::’ to ‘/’ to convert namespaces to paths.
    #
    # As a rule of thumb you can think of underscore as the inverse of camelize, though there are cases where that does
    # not hold:
    #
    #   "SSLError".underscore.camelize # => "SslError"
    # 
    # @example Out of box
    #   UnderscoreFilter.call("ActiveRecord::Errors") #=> "active_record/errors"
    #
    # @example Using as ActiveRecord::Base normalizer
    #   normalize :attribute_a, :with => :underscore
    #   normalize :attribute_b, :with => [:custom_filter, :underscore]
    #   normalize :attribute_c, :with => [[:underscore, :lower]]
    #   normalize :attribute_d, :with => [{:underscore => :lower}]
    #   normalize :attribute_e, :with => [:custom_filter, [:underscore, :lower]]
    #   normalize :attribute_f, :with => [:custom_filter, {:underscore => :lower}]
    #
    # @see http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-underscore ActiveSupport::Inflector#underscore
    # @see CamelizeFilter Normatron::Filters::CamelizeFilter
    module UnderscoreFilter
      extend Helpers

      ##
      # Performs input conversion according to filter requirements.
      #
      # This method returns the object itself when the first argument is not a String.
      #
      # @param input [String] The String to be filtered
      # @return [String] A new underscored String
      def self.call(input)
        return input unless input.kind_of?(String)

        string = input.gsub(/::/, '/')
        string.gsub!(/#{acronym_regex}/) { "_#{$&}_".downcase }
        string.gsub!(/\b_|_\b/, "")
        string.gsub!(/([^\/\b_])(?=[\p{Lu}])/u) { "#{$&}_" }
        string.tr!("-", "_")
        mb_send(:downcase, string)
      end
    end
  end
end
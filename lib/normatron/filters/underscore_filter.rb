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
    #   UnderscoreFilter.evaluate("ActiveRecord::Errors") #=> "active_record/errors"
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
      def self.evaluate(input)
        return input unless input.kind_of?(String)

        input.gsub!(/::/, '/')
        input.gsub!(/(?:([\p{Ll}\p{Lu}\d])|^)(#{acronym_regex})(?=\b|[^\p{Ll}])/u) { "#{$1}#{$1 && '_'}#{mb_send(:downcase, $2)}" }
        input.gsub!(/([\p{Lu}\d]+)([\p{Lu}][\p{Ll}])/u,'\1_\2')
        input.gsub!(/([\p{Ll}\d])([\p{Lu}])/u,'\1_\2')
        input.tr!("-", "_")
        mb_send(:downcase, input)
      end
    end
  end
end
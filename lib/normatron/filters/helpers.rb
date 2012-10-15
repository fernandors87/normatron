# encoding: UTF-8

require 'active_support/core_ext/string'
require 'active_support/inflector/inflections'
require 'active_support/multibyte/chars'

module Normatron
  module Filters
    module Helpers
      def evaluate_regexp(value, action, *properties)
        options = properties.flatten.compact.uniq
        constructs = options.map{ |s| "\\p{#{s.to_s}}" } * ""
        regex = /[#{'^' if action == :keep}#{constructs}]/u
        value.gsub(regex, "")
      end

      def acronyms
        inflections.acronyms
      end

      def acronym_regex
        inflections.acronym_regex
      end

      def inflections
        ActiveSupport::Inflector::Inflections.instance
      end

      def mb_send(method, value)
        value.mb_chars.send(method).to_s
      end
    end
  end
end
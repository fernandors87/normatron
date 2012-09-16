require "normatron/filters/conversions"
require "normatron/filters/string_inflections"

module Normatron
  module Filters
    class << self
      def is_a_string?(value)
        value.is_a?(ActiveSupport::Multibyte::Chars) || value.is_a?(String)
      end
    end
  end
end
require "active_support/all"

module Normatron
  module Filters
    module Native
      class << self
        def apply(filter, value)
          return value unless value.is_a? String

          case filter
          when :upcase, :downcase, :capitalize, :titlecase, :titleize
            value.mb_chars.send(filter).to_s
          when :squish, :lstrip, :rstrip, :strip
            value.send(filter)
          when :blank
            send("to_#{filter}", value)
          end
        end

        def filter_names
          [:upcase, :downcase, :capitalize, :titlecase, :titleize, :squish, :lstrip, :rstrip, :strip, :blank]
        end

        private

        def to_blank(value)
          value.blank? ? nil : value
        end
      end
    end
  end
end
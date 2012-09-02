require "active_support/all"

module Normatron
  module Filters
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

=begin
    def self.filter_currency(value)
      filter_number value, :currency
    end

    def self.filter_float(value)
      filter_number value, :float
    end

    def self.filter_integer(value)
      filter_number value
    end

    def self.filter_number(value, type = :integer)
      return value unless value.is_a?(String) && value.present?

      # Find the first number in the sequence
      first_number_position = value.index(/\d/)
      return unless first_number_position # Do nothing if it's don't have any number

      # Is a negative number?
      negative = value[0..first_number_position].include?("-")

      # Decimal separator on the current locale
      separator = I18n.t "number#{ '.currency' if type == :currency }.format.separator"

      # Amount of decimal places
      separator_position = value.rindex(separator)
      chars_until_separator = separator_position + 1 rescue value.size
      decimal_places = value.size - chars_until_separator

      # Build number
      res = filter_digits(value).to_f
      res *= -1 if negative
      res /= 10 ** decimal_places
      res = res.to_i if type == :integer

      res
    end
=end
  end
end
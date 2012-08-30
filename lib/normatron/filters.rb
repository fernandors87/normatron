require "i18n"
require "active_support/all"

module Normatron
  module Filters

    private

    MB_CHARS_METHODS = [:upcase, :downcase, :capitalize, :lstrip, :rstrip, :strip, :titlecase, :titleize]
    SELF_METHODS = [:nillify, :nullify, :nil, :squish, :currency, :integer, :float]

    public

    NAMES = MB_CHARS_METHODS + SELF_METHODS

    def self.do_filter(method, value)
      if MB_CHARS_METHODS.include? method
        value.mb_chars.send(method).to_s
      elsif SELF_METHODS.include? method
        send("filter_#{method}", value)
      else
        :no_method
      end
    end

    # Return nil if value is blank or else value itself.
    def self.filter_nillify(value)
      value.blank? ? nil : value
    end
    class << self
      alias :filter_nil      :filter_nillify
      alias :filter_nullify  :filter_nillify
    end

    # Remove repeated spaces from the string.
    def self.filter_squish(value)
      value.squish
    end

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
  end
end
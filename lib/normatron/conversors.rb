require "i18n"
require "active_support/all"

module Normatron
  module Conversors

    MB_CHARS_METHODS = [:upcase, :downcase, :capitalize, :lstrip, :rstrip, :strip, :titlecase, :titleize]
    SELF_METHODS = [:nillify, :nullify, :nil, :squish, :currency, :integer, :float, :postal_code, :phone, :digits, :phrase]
    CALLBACKS = MB_CHARS_METHODS + SELF_METHODS

    def self.convert(method, value)
      if MB_CHARS_METHODS.include? method
        value.mb_chars.send(method).to_s
      elsif SELF_METHODS.include? method
        send("convert_#{method}", value)
      else
        :no_method
      end
    end

    # Return nil if value is blank or else value itself.
    def self.convert_nillify(value)
      value.blank? ? nil : value
    end
    class << self
      alias :convert_nil      :convert_nillify
      alias :convert_nullify  :convert_nillify
    end

    # Remove repeated spaces from the string.
    def self.convert_squish(value)
      value.mb_chars.to_s.gsub(/\p{Zs}+/u, ' ')
    end

    def self.convert_currency(value)
      convert_number value, :currency
    end

    def self.convert_float(value)
      convert_number value, :float
    end

    def self.convert_integer(value)
      convert_number value
    end

    def self.convert_number(value, type = :integer)
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
      res = convert_digits(value).to_f
      res *= -1 if negative
      res /= 10 ** decimal_places
      res = res.to_i if type == :integer

      res
    end

    def self.convert_postal_code(value)
      res = convert_digits value
      res.size == 8 ? "%s-%s" % [res[0..4], res[5..7]] : value
    end

    def self.convert_phone(value)
      res = convert_digits value
      res.size == 10 ? "(%s) %s-%s" % [res[0..1], res[2..5], res[6..9]] : value
    end

    def self.convert_digits(value)
      value.to_s.gsub(/[^\d]/, '')
    end

    def self.convert_phrase(value)
      convert(:squish, convert(:strip, value))
    end
  end
end
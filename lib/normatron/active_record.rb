require "active_record"

module Normatron
  module ActiveRecord
    include Conversors

    def self.included(base)
      base.instance_eval do
        extend ClassMethods

        before_validation :normalize_attributes

        class << self
          attr_accessor :standardize_options
        end
      end
    end

    module ClassMethods
      def normalize(*args)
        # Extract options
        self.standardize_options ||= {}
        options = args.extract_options!

        methods = []
        if options.empty? # Default standardization
          methods << [:trim, :strip, :nillify]
        elsif options.has_key? :with
          methods << options[:with]
        else
          raise "Wrong normalization option in #{self.name}, use :with instead."
        end

        # Make a prettier array
        methods = methods.flatten.compact
        methods.map! { |v| v = v.to_sym }

        # Add normalization methods to call
        args.each do |attribute|
          standardize_options[attribute] = methods
        end
      end
    end

    def normalize_attributes
      options = self.class.standardize_options
      return unless options

      options.each do |attribute, methods|
        value = send("#{attribute}_before_type_cast")  || send(attribute)

        methods.each do |method|
          # Skip if value is nil originally or the method 'nullify' was called before
          value = convert(method, value) unless value.nil?
          if value == :no_method
            raise ArgumentError, "Method :#{method} cannot be resolved.
             Check options for #{attribute} in #{klass}", caller
          end
        end

        write_attribute attribute, value
      end
    end
  end
end
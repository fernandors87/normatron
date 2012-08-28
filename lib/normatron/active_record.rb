require "active_record"

module Normatron
  module ActiveRecord

    def self.included(base)
      base.instance_eval do
        extend ClassMethods

        before_validation :normalize_attributes

        class << self
          attr_accessor :normalization_options
        end
      end
    end

    module ClassMethods
      # Set an attribute normalization before model validation.
      # Args uses the attribute names following by a hash with conversion options.
      #
      # Example 1:
      # normalize :attribute_name
      # 
      # Example 2:
      # normalize :attribute_name, :with => :upcase
      #
      # Example 3:
      # normalize :attribute_name, :with => [:squish, :downcase]
      def normalize(*args)
        # Extract options
        @normalization_options ||= {}
        options = args.extract_options!

        # Set conversors
        conversors = []
        if options.empty? # Default standardization
          conversors << [:squish, :strip, :nillify]
        elsif options.has_key? :with
          conversors << options[:with]
        else
          raise "Wrong normalization key in #{self.name}, use :with instead of #{options.keys.first}"
        end

        # Make a prettier array
        conversors = conversors.flatten.compact
        conversors.map! { |v| v = v.to_sym }

        # Check conversors
        conversors.each do |c|
          unless Conversors::CALLBACKS.include? c
            raise "Normalization callback '#{c}' doesn't exist"
          end
        end

        # Add normalization conversors
        args.each do |attribute|
          # Check attributes
          unless self.column_names.include? attribute.to_s
            raise "Attribute '#{attribute}' doesn't exist in #{self.name}"
          end

          @normalization_options[attribute] = conversors
        end
      end
    end

    def normalize_attributes
      options = self.class.normalization_options
      return unless options

      options.each do |attribute, methods|
        value = send("#{attribute}_before_type_cast")  || send(attribute)

        methods.each do |method|
          # Skip if value is nil originally or the method 'nullify' was called before
          value = Conversors.convert(method, value) unless value.nil?

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
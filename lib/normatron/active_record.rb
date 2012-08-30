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

      def normalize(*args)
        # Extract options
        @normalization_options ||= {}
        options = args.extract_options!

        # Set callbacks
        filters = []
        if options.empty? # Default standardization
          filters << [:squish, :nillify]
        elsif options.has_key? :with
          filters << options[:with]
        else
          raise "Wrong normalization key in #{self.name}, use :with instead of #{options.keys.first}"
        end

        # Make a prettier array
        filters = filters.flatten.compact
        filters.map! { |v| v = v.to_sym }

        # Check filters
        filters.each do |f|
          unless Filters::NAMES.include? f
            raise "Normalization filter '#{f}' doesn't exist"
          end
        end

        # Add normalization callbacks
        args.each do |attribute|
          # Check attributes
          unless self.column_names.include? attribute.to_s
            raise "Attribute '#{attribute}' doesn't exist in #{self.name}"
          end

          @normalization_options[attribute] ||= []
          @normalization_options[attribute] += filters
        end
      end
      alias :normatron :normalize
    end

    def normalize_attributes
      options = self.class.normalization_options
      return unless options

      options.each do |attribute, methods|
        value = send("#{attribute}_before_type_cast")  || send(attribute)

        methods.each do |method|
          value = Filters.do_filter(method, value) unless value.nil?

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
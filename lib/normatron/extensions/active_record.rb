require "normatron/filters"

module Normatron
  module Extensions
    module ActiveRecord
      def self.included(base)
        base.instance_eval do
          before_validation :apply_normalizations

          class << self
            attr_accessor :normalize_options

            def normalize(*args)
              options = args.extract_options!
              return nil unless args

              options[:with] = [options[:with]].flatten.compact
              options[:with] = Normatron.configuration.default_filters if options[:with].empty?

              @normalize_options ||= {}
              args.each do |attribute|
                @normalize_options[attribute] ||= []
                @normalize_options[attribute] += options[:with]
                @normalize_options[attribute] = @normalize_options[attribute].uniq
              end
              @normalize_options
            end
          end
        end
      end

      def apply_normalizations
        self.class.normalize_options.each do |attribute, filters|
          value = send("#{attribute}_before_type_cast") || send(attribute)

          filters.each do |filter|
            if self.respond_to? filter
              value = send(filter, value)
            elsif Normatron::Filters::StringInflections.respond_to? filter
              value = Normatron::Filters::StringInflections.send(filter, value)
            else
              value = Normatron::Filters::Conversions.send(filter, value)
            end
          end

          write_attribute attribute, value
        end
      end
    end
  end
end
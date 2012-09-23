require "normatron/filters"

module Normatron
  module Extensions
    module ActiveRecord
      def self.included(base)
        base.instance_eval do
          extend ClassMethods
          include InstanceMethods
          before_validation :normalize_attributes

          class << self
            attr_accessor :normalize_options
          end
        end
      end

      module ClassMethods
        def normalize(*args)
          # Check existence of all attributes
          options = args.extract_options!
          args, columns = args.map(&:to_sym), column_names.map(&:to_sym)
          raise "attribute" if (columns & args).size != args.size

          # Specify the use of default filters or not
          if options[:with].nil? || options[:with].blank?
            new_filters = Normatron.config.default_filters
          else
            new_filters = Normatron::Configuration.clean_filters(options[:with])
          end

          # Append to older filters hash
          @normalize_options ||= {}
          @normalize_options =
          args.reduce(@normalize_options) do |hash, att|
            filters = (@normalize_options[att] || {}).merge(new_filters)
            hash.merge({att => filters})
          end
        end
      end

      module InstanceMethods
        def normalize_attributes
          self.class.normalize_options.each do |attribute, filters|
            value = send("#{attribute}_before_type_cast") || send(attribute)

            filters.each do |filter, args|
              if self.respond_to? filter
                value = send(filter, value, *args)
              elsif Normatron::Filters.respond_to? filter
                value = Normatron::Filters.send(filter, value, *args)
              else
                raise "Filter '#{filter}' wasn't found."
              end
            end

            write_attribute attribute, value
          end
        end
      end
    end
  end
end
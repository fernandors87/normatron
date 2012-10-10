require 'active_record'

module Normatron
  module Extensions
    module ActiveRecord

      ORM_CLASS = ::ActiveRecord::Base

      def self.included(base)
        base.instance_eval do
          extend ClassMethods
          include InstanceMethods
          before_validation :apply_normalizations

          class << self
            attr_accessor :normalize_filters
          end
        end
      end

      module ClassMethods
        def normalize(*args)
          # Check existence of all attributes
          options = args.extract_options!
          filters, columns = args.map(&:to_s), column_names
          raise UnknownAttributeError if (columns & filters).size != filters.size

          # Specify the use of default filters or not
          if options[:with].nil? || options[:with].blank?
            new_filters = Normatron.config.default_filters
          else
            new_filters = Normatron.build_hash(options[:with])
          end

          # Append to older filters hash
          @normalize_filters ||= {}
          @normalize_filters =
          args.reduce(@normalize_filters) do |hash, att|
            filters = (@normalize_filters[att] || {}).merge(new_filters)
            hash.merge({att => filters})
          end
        end
      end

      module InstanceMethods
        def apply_normalizations
          named_filters = Normatron.configuration.filters

          self.class.normalize_filters.each do |attribute, filters|
            value = send("#{attribute}_before_type_cast") || send(attribute)

            filters.each do |filter, args|
              if self.respond_to? filter
                value = send(filter, value, *args)
              elsif !named_filters[filter].nil?
                value = named_filters[filter].evaluate(value, *args)
              else
                raise UnknownFilterError
              end
            end

            write_attribute attribute, value
          end
        end
      end
    end
  end
end
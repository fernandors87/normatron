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
            attr_accessor :normalize_rules
            alias :normalize_filters :normalize_rules
            alias :normalize_filters= :normalize_rules=
          end
        end
      end

      module ClassMethods
        def normalize(*args)
          # Check the existence of all attributes
          options = args.extract_options!
          filters, columns = args.map(&:to_s), column_names
          raise UnknownAttributeError if (columns & filters).size != filters.size

          # Need to use default filters?
          if options[:with].nil? || options[:with].blank?
            new_filters = Normatron.config.default_filters
          else
            new_filters = Normatron.build_hash(options[:with])
          end

          @normalize_rules ||= {}

          # Append new filters to rules
          @normalize_rules =
          args.reduce(@normalize_rules) do |hash, att|
            filters = (@normalize_rules[att] || {}).merge(new_filters)
            hash.merge({att => filters})
          end
        end
      end

      module InstanceMethods
        def apply_normalizations
          return unless self.class.normalize_rules
          
          listed_filters = Normatron.configuration.filters

          self.class.normalize_rules.each do |attribute, filters|
            value = send("#{attribute}_before_type_cast") || send(attribute)

            filters.each do |filter, args|
              if self.respond_to? filter
                value = send(filter, value, *args)
              elsif listed_filters[filter].kind_of? Module
                value = listed_filters[filter].call(value, *args)
              elsif listed_filters[filter].kind_of? Proc
                value = listed_filters[filter].call(value, *args)
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
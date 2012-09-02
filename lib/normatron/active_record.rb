require "normatron/filters"
require "active_record"

module Normatron
  module ActiveRecord
    def self.included(base)
      base.instance_eval do
        before_validation :apply_normalization

        class << self
          attr_accessor :normalization_filters

          def normalize(*args)
            options = args.extract_options!
            options[:with] ||= [:blank, :squish]

            filters = [options[:with]].flatten.compact
            filters.map!(&:to_sym)
            intersect = filters & (Filters.filter_names + methods(false))

            unless intersect == filters
              raise "Normalization filters #{filters - intersect} doesn't exist"
            end

            @normalization_filters ||= {}
            args.each do |raw_attribute|
              attribute = raw_attribute.to_sym

              if self.column_names.include? attribute.to_s
                @normalization_filters[attribute] ||= []
                @normalization_filters[attribute] += filters
              else
                raise "Attribute '#{attribute}' doesn't exist in #{self}"
              end
            end
          end
        end
      end
    end
    
    def apply_normalization
      return unless self.class.normalization_filters.is_a? Hash

      self.class.normalization_filters.each do |attribute, filters|
        value = send("#{attribute}_before_type_cast")  || send(attribute)

        filters.each do |filter|
          value = Filters.apply(filter, value)
        end

        write_attribute attribute, value
      end
    end
  end
end
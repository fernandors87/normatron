module Normatron
  class Configuration
    def self.clean_filters(*with)
      elements = with.flatten(1)
      raise "empty" unless elements.any?

      result = {}
      elements.each do |e|
        case e
        when Array
          result[e[0].to_sym] = e[1..-1]
        when Hash
          e.each { |key, value| result[key] = *value.flatten(1) }
        else
          result[e.to_sym] = []
        end
      end

      result
    end

    def initialize
      @default_filters = { squish: [], blank: [] }
    end

    def default_filters
      @default_filters
    end

    def default_filters=(filters)
      @default_filters = self.class.clean_filters(filters)
    end
  end
end
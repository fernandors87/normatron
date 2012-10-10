require "normatron/configuration"
require "normatron/extensions"

module Normatron
  class << self
    def configuration
      @configuration ||= Configuration.new
    end
    alias :config :configuration

    def setup
      yield(configuration)
    end

    def build_hash(*terms)
      terms.flatten!(1)

      filters_hash = {}
      terms.each do |term|
        case term
          when Array
            key, value = term.first, term.drop(1)
            filters_hash[key.to_sym] = value.kind_of?(Array) && value.empty? ? nil : value
          when Hash
            term.each { |key, value| filters_hash[key.to_sym] = *value }
          else
            filters_hash[term.to_sym] = nil
        end
      end

      filters_hash
    end
  end
end
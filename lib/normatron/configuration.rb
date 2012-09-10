module Normatron
  class Configuration
    attr_writer :default_filters

    def initialize
      @default_filters ||= [:squish, :blank]
    end

    def default_filters
      @default_filters = [@default_filters].flatten.compact.uniq
    end
  end
end
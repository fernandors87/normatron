require "normatron/configuration"
require "normatron/extensions/active_record"

module Normatron
  VERSION = "0.0.7"

  class << self
    def configuration
      @configuration ||= Configuration.new
    end   

    def configure
      yield(configuration)
    end
    alias :setup :configure
  end
end

ActiveRecord::Base.send :include, Normatron::Extensions::ActiveRecord if defined?(ActiveRecord::Base)
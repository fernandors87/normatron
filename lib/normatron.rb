require "normatron/active_record"

module Normatron
  VERSION = "0.0.6"
end

ActiveRecord::Base.send :include, Normatron::ActiveRecord
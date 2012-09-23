require "active_record"
require "normatron"

ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => ":memory:"
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each { |f| require f }
ActiveRecord::Base.send(:include, Normatron::Extensions::ActiveRecord) if defined?(ActiveRecord::Base)
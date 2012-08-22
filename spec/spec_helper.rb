require "rspec"
require "normatron"

ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => ":memory:"

load "schema.rb"

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}
ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => ":memory:"

ActiveRecord::Schema.define(:version => 0) do
  create_table :users do |t|
    t.string :login
    t.string :password
    t.string :email
    t.string :phone
  end
end

class User < ActiveRecord::Base
  attr_accessible :login, :password, :email, :phone
end
class Client < ActiveRecord::Base
  attr_accessible :name, :credit_limit, :cpf, :birth_date, :phone, :login_count
end
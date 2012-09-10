ActiveRecord::Schema.define(:version => 0) do
  create_table :clients do |t|
  	t.string 	:name
  	t.decimal :credit_limit, precision: 10, scale: 2
  	t.string 	:cpf
  	t.date 		:birth_date
  	t.string 	:phone
  	t.integer :login_count
  end
end
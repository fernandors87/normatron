ActiveRecord::Schema.define(:version => 0) do
  create_table :models do |t|
  	t.string 	:field_a
  	t.string  :field_b
    t.string  :field_c
  end
end
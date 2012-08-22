ActiveRecord::Schema.define(:version => 0) do
  create_table :test_models do |t|
    t.string :string_field
    t.integer :integer_field
  end
end
ActiveRecord::Schema.define(:version => 0) do
  create_table :test_models do |t|
    t.string :string_column
    t.integer :integer_column
  end
end
class TestModel < ActiveRecord::Base
  attr_accessible :string_column, :integer_column

  def my_custom_filter_method(value)
    value.split(//) * "-"
  end
end
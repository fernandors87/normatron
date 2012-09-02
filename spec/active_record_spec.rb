require "spec_helper"

describe Normatron::ActiveRecord do
  before :each do
    TestModel.normalization_filters = nil
  end

  it "filters should be accessible" do
    TestModel.normalize :string_column, :with => [:capitalize, :upcase]
    TestModel.normalize :integer_column, :with => :blank
    TestModel.normalization_filters.should == { :string_column => [:capitalize, :upcase],
                                                :integer_column => [:blank] }
    TestModel.normalization_filters.delete :string_column
    TestModel.normalization_filters.should == { :integer_column => [:blank] }
  end

  it "should save without normalization" do
    lambda do
      instance = TestModel.new :string_column => "Any string"
      instance.save!
    end.should_not raise_error
  end

  it "should skip normalization when filters aren't a Hash" do
    TestModel.normalization_filters = true
    lambda do
      instance = TestModel.new :string_column => "Any string"
      instance.valid?
    end.should_not raise_error

    TestModel.normalization_filters = 1
    lambda do
      instance = TestModel.new :string_column => "Any string"
      instance.valid?
    end.should_not raise_error

    TestModel.normalization_filters = false
    lambda do
      instance = TestModel.new :string_column => "Any string"
      instance.valid?
    end.should_not raise_error
  end

  it "should apply default filter to single attribute" do
    TestModel.normalize :string_column
    TestModel.normalization_filters.should == { :string_column => [:blank, :squish] }
  end

  it "should apply default filter to multiple attributes" do
    TestModel.normalize :string_column, :integer_column
    TestModel.normalization_filters.should == { :string_column => [:blank, :squish],
                                                :integer_column => [:blank, :squish] }
  end

  it "should apply single filter to single attribute" do
    TestModel.normalize :string_column, :with => :upcase
    TestModel.normalization_filters.should == { :string_column => [:upcase] }
  end

  it "should apply single filter to multiple attributes" do
    TestModel.normalize :string_column, :integer_column, :with => :blank
    TestModel.normalization_filters.should == { :string_column => [:blank],
                                                :integer_column => [:blank] }
  end

  it "should apply multiple filters to single attribute" do
    TestModel.normalize :string_column, :with => [:blank, :upcase]
    TestModel.normalization_filters.should == { :string_column => [:blank, :upcase] }
  end

  it "should apply multiple filters to multiple attributes" do
    TestModel.normalize :string_column, :integer_column, :with => [:squish, :blank]
    TestModel.normalization_filters.should == { :string_column => [:squish, :blank],
                                                :integer_column => [:squish, :blank] }
  end

  it "should stack filters for the same attribute" do
    TestModel.normalize :string_column, :with => [:upcase, :squish]
    TestModel.normalize :string_column, :integer_column, :with => :blank
    TestModel.normalize :string_column, :integer_column, :with => [:downcase, :strip]
    TestModel.normalization_filters.should == { :string_column  => [:upcase, :squish, :blank, :downcase, :strip],
                                                :integer_column => [:blank, :downcase, :strip] }
  end

  it "should apply attributes as string" do
    TestModel.normalize "string_column", :with => :upcase

    instance = TestModel.new :string_column => "Any string"
    instance.valid?
    instance.string_column.should == "ANY STRING"

    TestModel.normalization_filters.should == { :string_column  => [:upcase] }
  end

  it "should apply filters as one word string" do
    TestModel.normalize :string_column, :with => "upcase"

    TestModel.normalization_filters.should == { :string_column  => [:upcase] }

    instance = TestModel.new :string_column => "Any string"
    instance.valid?
    instance.string_column.should == "ANY STRING"
  end

  it "should raise error when a wrong filter is used" do
    lambda do
      TestModel.normalize :string_column, :with => :wrong_filter
    end.should raise_error "Normalization filters [:wrong_filter] doesn't exist"
  end

  it "should raise error when a wrong attribute is used" do
    lambda do
      TestModel.normalize :wrong_column, :with => :upcase
    end.should raise_error "Attribute 'wrong_column' doesn't exist in TestModel"
  end

  pending "should allow use an instance method as a filter" do
    lambda do
      TestModel.normalize :string_column, :with => :my_custom_filter_method
    end.should_not raise_error "Normalization filters [:my_custom_filter_method] doesn't exist"

    TestModel.normalization_filters.should == { :string_column  => [:my_custom_filter_method] }
  end

  pending "should apply an instance method used as a filter" do
    TestModel.normalize :string_column, :with => :my_custom_filter_method

    m = TestModel.new :string_column => "My life for Aiur"
    m.string_column.should == "M-y- -l-i-f-e- -f-o-r- -A-i-u-r"
  end

  pending "should allow change default callback"
  pending "should allow get value after type cast"
  pending "should allow use blocks"
  pending "should allow build custom filters"
  pending "should allow use a instance method as a filter"
end
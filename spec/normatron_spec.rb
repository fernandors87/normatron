# encoding: utf-8

require "spec_helper"

describe Normatron do
  before :each do
    TestModel.normalization_options = nil
  end

  it "should respond to aliases" do
    TestModel.should respond_to :normatron
  end

  it "should save without normalization option" do
    lambda do
      instance = TestModel.new
      instance.string_column = "Any string"
      instance.save!
    end.should_not raise_error
  end

  it "filters should be accessible" do
    TestModel.normalize :string_column, :with => [:capitalize, :upcase]
    TestModel.normalize :integer_column, :with => :integer
    TestModel.normalization_options.should == { :string_column => [:capitalize, :upcase], :integer_column => [:integer] }
    TestModel.normalization_options.delete :string_column
    TestModel.normalization_options.should == { :integer_column => [:integer] }
  end

  it "should apply single filter" do
    TestModel.normalize :string_column, :with => :upcase

    m = TestModel.create :string_column => "master of puppets"
    m.string_column.should == "MASTER OF PUPPETS"
  end

  it "should apply multiple filters" do
    TestModel.normalize :string_column, :with => [:downcase, :squish, :nil]

    m = TestModel.create :string_column => "     YOU   SHALL    NOT   PASS    "
    m.string_column.should == "you shall not pass"

    m = TestModel.create :string_column => "     "
    m.string_column.should == nil
  end

  it "should stack filters for the same attribute" do
    TestModel.normalize :string_column, :with => [:upcase, :squish]
    TestModel.normalize :string_column, :with => :nil
    TestModel.normalization_options.should == { :string_column => [:upcase, :squish, :nil] }
  end

  it "default filters should be :squish and :nillify" do
    TestModel.normalize :string_column
    TestModel.normalization_options.should == { :string_column => [:squish, :nillify] }
  end

   it "default filters should be :squish and :nillify" do
    TestModel.normalize :string_column
    TestModel.normalization_options.should == { :string_column => [:squish, :nillify] }
  end

  it "should filter multiple attributes" do
    TestModel.normalize :string_column, :integer_column, :with => :nil

    m = TestModel.create :string_column => "      ", :integer_column => "      "
    m.string_column.should == nil
    m.integer_column.should == nil
  end

  it "should raise error if a wrong option is set and the right isn't" do
    lambda do
      TestModel.normalize :string_column, :wrong_option => :upcase
    end.should raise_error "Wrong normalization key in TestModel, use :with instead of wrong_option"

    lambda do
      TestModel.normalize :string_column, :wrong_option => :upcase, :with => :downcase
    end.should_not raise_error
  end

  it "should raise error if wrong filter is called" do
    lambda do
      TestModel.normalize :string_column, :with => :wrong_filter
    end.should raise_error "Normalization filter 'wrong_filter' doesn't exist"
  end
end
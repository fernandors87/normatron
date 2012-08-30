# encoding: utf-8

require "spec_helper"

describe Normatron::Filters do

  before :each do
    TestModel.normalization_options = nil
  end

  it :capitalize do
    TestModel.normalize :string_column, :with => :capitalize

    m = TestModel.create :string_column => "   abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü   "
    m.string_column.should == "   abc   \f   def   \n   123   áèç   \t !*&   \r   4gü   "

    m.string_column = "abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü"
    m.valid?
    m.string_column.should == "Abc   \f   def   \n   123   áèç   \t !*&   \r   4gü"
  end

  it :downcase do
    TestModel.normalize :string_column, :with => :downcase

    m = TestModel.create :string_column => "   abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü   "
    m.string_column.should == "   abc   \f   def   \n   123   áèç   \t !*&   \r   4gü   "
  end

  it :squish do
    TestModel.normalize :string_column, :with => :squish

    m = TestModel.create :string_column => "   abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü   "
    m.string_column.should == "abc DEF 123 áÈç !*& 4gü"
  end

  it :strip do
    TestModel.normalize :string_column, :with => :strip

    m = TestModel.create :string_column => "   abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü   "
    m.string_column.should == "abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü"
  end

  it :titlecase do
    TestModel.normalize :string_column, :with => :titlecase

    m = TestModel.create :string_column => "   abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü   "
    m.string_column.should == "   Abc   \f   Def   \n   123   Áèç   \t !*&   \r   4gü   "
  end

  it :upcase do
    TestModel.normalize :string_column, :with => :upcase

    m = TestModel.create :string_column => "   abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü   "
    m.string_column.should == "   ABC   \f   DEF   \n   123   ÁÈÇ   \t !*&   \r   4GÜ   "
  end

  it :nillify do
    TestModel.normalize :string_column, :with => :nillify

    m = TestModel.create :string_column => "               "
    m.string_column.should == nil
  end

  it :lstrip do
    TestModel.normalize :string_column, :with => :lstrip

    m = TestModel.create :string_column => "   abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü   "
    m.string_column.should == "abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü   "
  end

  it :rstrip do
    TestModel.normalize :string_column, :with => :rstrip

    m = TestModel.create :string_column => "   abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü   "
    m.string_column.should == "   abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü"
  end
end
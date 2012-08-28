# encoding: utf-8

require "spec_helper"

describe Normatron do
  before :each do
    TestModel.normalization_options = nil
    @instance = TestModel.new
  end

  it "should allow save without any normalize option" do
    lambda do
      @instance.string_column = "Any string"
      @instance.save!
    end.should_not raise_error
  end

  it "should raise an error if attribute doesn't exist" do
    lambda do
      TestModel.normalize :ghost_attribute
    end.should raise_error "Attribute 'ghost_attribute' doesn't exist in TestModel"
  end

  it "should raise an error if a wrong option is set" do
    lambda do
      TestModel.normalize :string_column, :wrong_option => :upcase
    end.should raise_error "Wrong normalization key in TestModel, use :with instead of wrong_option"
  end

  it "should raise an error if wrong conversor is called" do
    lambda do
      TestModel.normalize :string_column, :with => :wrong_conversor
    end.should raise_error "Normalization callback 'wrong_conversor' doesn't exist"
  end

  it "options should be accessible" do
    TestModel.normalize :string_column, :with => [:capitalize, :upcase]
    TestModel.normalize :integer_column, :with => :integer
    TestModel.normalization_options.should == { :string_column => [:capitalize, :upcase], :integer_column => [:integer] }
    TestModel.normalization_options.delete :string_column
    TestModel.normalization_options.should == { :integer_column => [:integer] }
  end

  describe "Conversors" do
    it :capitalize do
      TestModel.normalize :string_column, :with => :capitalize

      m = TestModel.create :string_column => "áb c, 1 2 3 DEF GHI i oz "
      m.string_column.should == "Áb c, 1 2 3 def ghi i oz "
    end

    it :digits do
      TestModel.normalize :string_column, :with => :digits

      m = TestModel.create :string_column => " 1a 2b 3c 4d 5e 6f "
      m.string_column.should == "123456"
    end

    it :downcase do
      TestModel.normalize :string_column, :with => :downcase

      m = TestModel.create :string_column => " a b c, 1 2 3 DEF GHI i oz "
      m.string_column.should == " a b c, 1 2 3 def ghi i oz "
    end

    it :phone do
      TestModel.normalize :string_column, :with => :phone

      m = TestModel.create :string_column => "(99) 9999-9999"
      m.string_column.should == "(99) 9999-9999"

      m = TestModel.create :string_column => "9999999999"
      m.string_column.should == "(99) 9999-9999"

      m = TestModel.create :string_column => "999999999"
      m.string_column.should == "999999999"
    end

    it :phrase do
      TestModel.normalize :string_column, :with => :phrase

      m = TestModel.create :string_column => " a b c, 1 2 3 DEF GHI i oz "
      m.string_column.should == "a b c, 1 2 3 DEF GHI i oz"
    end

    it :postal_code do
      TestModel.normalize :string_column, :with => :postal_code

      m = TestModel.create :string_column => "88888-888"
      m.string_column.should == "88888-888"

      m = TestModel.create :string_column => "88888888"
      m.string_column.should == "88888-888"

      m = TestModel.create :string_column => "8888888"
      m.string_column.should == "8888888"
    end

    it :squish do
      TestModel.normalize :string_column, :with => :squish

      m = TestModel.create :string_column => " a b c, 1 2 3 DEF GHI i oz "
      m.string_column.should == " a b c, 1 2 3 DEF GHI i oz "
    end

    it :strip do
      TestModel.normalize :string_column, :with => :strip

      m = TestModel.create :string_column => " a b c, 1 2 3 DEF GHI i oz "
      m.string_column.should == "a b c, 1 2 3 DEF GHI i oz"
    end

    it :titlecase do
      TestModel.normalize :string_column, :with => :titlecase

      m = TestModel.create :string_column => " aé áb c, 1 2 3 DEF GHI i oz "
      m.string_column.should == " Aé Áb C, 1 2 3 Def Ghi I Oz "
    end

    it :upcase do
      TestModel.normalize :string_column, :with => :upcase

      m = TestModel.create :string_column => " a b c, 1 2 3 DEF GHI i oz "
      m.string_column.should == " A B C, 1 2 3 DEF GHI I OZ "
    end

    it :nillify do
      TestModel.normalize :string_column, :with => :nillify

      m = TestModel.create :string_column => " "
      m.string_column.should == nil
    end

    it :lstrip do
      TestModel.normalize :string_column, :with => :lstrip

      m = TestModel.create :string_column => " a b c, 1 2 3 DEF GHI i oz "
      m.string_column.should == "a b c, 1 2 3 DEF GHI i oz "
    end

    it :rstrip do
      TestModel.normalize :string_column, :with => :rstrip

      m = TestModel.create :string_column => " a b c, 1 2 3 DEF GHI i oz "
      m.string_column.should == " a b c, 1 2 3 DEF GHI i oz"
    end
  end
end
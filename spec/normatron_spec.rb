# encoding: utf-8

require "spec_helper"

describe Normatron do
  before :each do
    TestModel.standardize_options = {}
  end

  describe "Conversors" do
    it :capitalize do
      TestModel.normalize :string_field, :with => :capitalize

      m = TestModel.create :string_field => "áb c, 1 2 3 DEF GHI i oz    "
      m.string_field.should == "Áb c, 1 2 3 def ghi i oz    "
    end

    it :digits do
      TestModel.normalize :string_field, :with => :digits

      m = TestModel.create :string_field => " 1a 2b 3c 4d 5e 6f "
      m.string_field.should == "123456"
    end

    it :downcase do
      TestModel.normalize :string_field, :with => :downcase

      m = TestModel.create :string_field => "   a   b c, 1 2 3 DEF GHI i oz    "
      m.string_field.should == "   a   b c, 1 2 3 def ghi i oz    "
    end

    it :phone do
      TestModel.normalize :string_field, :with => :phone

      m = TestModel.create :string_field => "(99) 9999-9999"
      m.string_field.should == "(99) 9999-9999"

      m = TestModel.create :string_field => "9999999999"
      m.string_field.should == "(99) 9999-9999"

      m = TestModel.create :string_field => "999999999"
      m.string_field.should == "999999999"
    end

    it :phrase do
      TestModel.normalize :string_field, :with => :phrase

      m = TestModel.create :string_field => "   a   b c, 1 2 3 DEF GHI i oz    "
      m.string_field.should == "a b c, 1 2 3 DEF GHI i oz"
    end

    it :postal_code do
      TestModel.normalize :string_field, :with => :postal_code

      m = TestModel.create :string_field => "88888-888"
      m.string_field.should == "88888-888"

      m = TestModel.create :string_field => "88888888"
      m.string_field.should == "88888-888"

      m = TestModel.create :string_field => "8888888"
      m.string_field.should == "8888888"
    end

    it :strip do
      TestModel.normalize :string_field, :with => :strip

      m = TestModel.create :string_field => "   a   b c, 1 2 3 DEF GHI i oz    "
      m.string_field.should == "a   b c, 1 2 3 DEF GHI i oz"
    end

    it :titlecase do
      TestModel.normalize :string_field, :with => :titlecase

      m = TestModel.create :string_field => "   aé   áb c, 1 2 3 DEF GHI i oz    "
      m.string_field.should == "   Aé   Áb C, 1 2 3 Def Ghi I Oz    "
    end

    it :upcase do
      TestModel.normalize :string_field, :with => :upcase

      m = TestModel.create :string_field => "   a   b c, 1 2 3 DEF GHI i oz    "
      m.string_field.should == "   A   B C, 1 2 3 DEF GHI I OZ    "
    end



    it :nillify do
      TestModel.normalize :string_field, :with => :nillify

      m = TestModel.create :string_field => "       "
      m.string_field.should == nil
    end

    it :trim do
      TestModel.normalize :string_field, :with => :trim

      m = TestModel.create :string_field => "   a   b c, 1 2 3 DEF GHI i oz    "
      m.string_field.should == " a b c, 1 2 3 DEF GHI i oz "
    end

    it :lstrip do
      TestModel.normalize :string_field, :with => :lstrip

      m = TestModel.create :string_field => "   a   b c, 1 2 3 DEF GHI i oz    "
      m.string_field.should == "a   b c, 1 2 3 DEF GHI i oz    "
    end

    it :rstrip do
      TestModel.normalize :string_field, :with => :rstrip

      m = TestModel.create :string_field => "   a   b c, 1 2 3 DEF GHI i oz    "
      m.string_field.should == "   a   b c, 1 2 3 DEF GHI i oz"
    end
  end
end
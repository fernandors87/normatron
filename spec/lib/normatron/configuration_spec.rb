require "spec_helper"

describe Normatron::Configuration do

  let(:klass)     { Normatron::Configuration }
  let(:instance)  { @instance }

  before :each do
    @instance = klass.new
  end

  describe :default_filters do
    it "should be initializated" do
      instance.default_filters.should eq [:squish, :blank]
    end

    it "should be enclause values into an array" do
      instance.default_filters = :a
      instance.default_filters.should eq [:a]
    end

    it "should reject repeated filters" do
      instance.default_filters = :a, :a
      instance.default_filters.should eq [:a]

      instance.default_filters += [:a, :b]
      instance.default_filters.should eq [:a, :b]
    end

    it "should reject nil filters" do
      instance.default_filters = nil
      instance.default_filters.should eq []

      instance.default_filters = :a, nil
      instance.default_filters.should eq [:a]

      instance.default_filters << nil
      instance.default_filters.should eq [:a]
    end
  end

  pending "should map filter modules"
  pending "should allow create inline filters"
  pending "should"
end
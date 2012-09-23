require "spec_helper"

describe Normatron::Configuration do
  before :each do
    @instance = described_class.new
  end

  subject { @instance }

  describe "#default_filters" do
    it "should initializate" do
      subject.default_filters.should == { squish: [], blank: [] }
    end
    it "should parse and set filters properly" do
      subject.default_filters = :upcase, :blank, { keep: [:L, :N] }, [:remove, :S, :Z]
      subject.default_filters.should == { upcase: [], blank: [], keep: [:L, :N], remove: [:S, :Z] }
    end
    it "should raise error for empty filters" do
      lambda{ subject.default_filters = [] }.should raise_error
    end
  end

  describe "::clean_filters" do
    context "with wrong arguments" do
      it { expect{ described_class.clean_filters(nil)     }.to raise_error }
      it { expect{ described_class.clean_filters([])      }.to raise_error }
      it { expect{ described_class.clean_filters(1)       }.to raise_error }
      it { expect{ described_class.clean_filters([1])     }.to raise_error }
      it { expect{ described_class.clean_filters([:a, 1]) }.to raise_error }
      it { expect{ described_class.clean_filters([[1]])   }.to raise_error }
    end

    context "with single filter hash" do
      it { described_class.clean_filters(:a         ).should == { a:[] } }
      it { described_class.clean_filters([:a]       ).should == { a:[] } }
      it { described_class.clean_filters([[:a]]     ).should == { a:[] } }
      it { described_class.clean_filters([[:a, :b]] ).should == { a:[:b] } }
      it { described_class.clean_filters([a: [:b]]  ).should == { a:[:b] } }
    end

    context "with double filters hash" do
      it { described_class.clean_filters([:a, :b]           ).should == { a:[], b:[] } }
      it { described_class.clean_filters([:a, b:[:c, :d]]   ).should == { a:[], b:[:c, :d] } }
      it { described_class.clean_filters([:a, [:b, :c, :d]] ).should == { a:[], b:[:c, :d] } }
    end

    context "with trible filters hash" do
      it { described_class.clean_filters([:a, [:b, :c, :d], { e: [:f, :g] }]    ).should == { a:[], b:[:c, :d], e: [:f, :g] } }
      it { described_class.clean_filters([:a, { b: [:c, :d] }, { e: [:f, :g] }] ).should == { a:[], b:[:c, :d], e: [:f, :g] } }
      it { described_class.clean_filters([:a, { b: [:c, :d], e: [:f, :g] }]     ).should == { a:[], b:[:c, :d], e: [:f, :g] } }
    end
  end
end
require "spec_helper"

describe Normatron::Extensions::ActiveRecord do
  let(:model) { Model }
  before(:each) { model.normalize_options = nil }

  describe "::normalize" do
    subject { model.normalize_options }
    
    specify("unknown attribute") { expect { model.normalize :abcdef }.to raise_error }
    specify("nil attribute") { expect { model.normalize nil }.to raise_error }

    context "with no filters" do
      it "should use default filters" do
        model.normalize :field_a
        should == { field_a: { squish: [], blank: [] } }
      end

      it "should assoc to multiple attributes" do
        model.normalize :field_a, :field_b, :field_c
        should == { field_a: { squish: [], blank: [] },
                    field_b: { squish: [], blank: [] },
                    field_c: { squish: [], blank: [] } }
      end

      it "should stack attributes for multiple calls" do
        model.normalize :field_a, :field_b
        model.normalize :field_c
        should == { field_a: { squish: [], blank: [] },
                    field_b: { squish: [], blank: [] },
                    field_c: { squish: [], blank: [] } }
      end
    end

    context "with single filter" do
      it "should set it" do
        model.normalize :field_a, with: :upcase
        should == { field_a: { upcase: [] } }
      end

      it "should set it as an array" do
        model.normalize :field_a, with: [:upcase]
        should == { field_a: { upcase: [] } }
      end

      it "should set it as an array" do
        model.normalize :field_a, with: [[:keep, :L, :Z, :N]]
        should == { field_a: { keep: [:L, :Z, :N] } }
      end
    end

    context "with multiple filters" do
      it "should set it" do
        model.normalize :field_a, with: [:upcase, :dasherize]
        should == { field_a: { upcase: [], dasherize: [] } }
      end

      it "should stack filters for multiple calls" do
        model.normalize :field_a, with: :upcase
        model.normalize :field_a, :field_b, with: [:blank, :squish]
        should == { field_a: { upcase: [], blank: [], squish: [] },
                    field_b: { blank: [], squish: []} }
      end

      it "should use filters with arguments passed as an array" do
        model.normalize :field_a, with: [:upcase, [:keep, :L, :N], :blank]
        should == { field_a: { upcase: [], keep: [:L, :N], blank: [] } }
      end

      it "should use filters with arguments passed as a hash" do
        model.normalize :field_a, with: [:upcase, { keep: [:L, :N] }, :blank]
        should == { field_a: { upcase: [], keep: [:L, :N], blank: [] } }
      end
    end
  end

  describe "#normalize_attributes" do
    before(:each) { @instance = model.new }
    let(:instance) { @instance }

    it "should run instance method filter" do
      model.class_eval do
        define_method :test_filter do |value, glue, size|
          v = value.gsub(/\p{Z}/u, '').split(//) * glue
          v[0..size-1]
        end
      end

      model.normalize :field_a, with: [[:test_filter, ".", 5]]
      instance.field_a = " bla bla bla"
      instance.normalize_attributes
      instance.field_a.should == "b.l.a"
    end

    it "should run native filter" do
      model.normalize :field_a, with: [keep: [:N]]
      instance.field_a = "abc123"
      instance.normalize_attributes
      instance.field_a.should == "123"
    end

    it "should be called before validation" do
      model.normalize :field_a, with: :downcase
      instance.field_a = "XXXXXX"
      instance.valid?
      instance.field_a.should == "xxxxxx"
    end

    it "should raise error for wrong filters" do
      model.normalize :field_a, with: :down
      expect { instance.normalize_attributes }.to raise_error "Filter 'down' wasn't found."
    end
  end
end
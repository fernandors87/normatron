require 'spec_helper'
require 'normatron/configuration'

describe Normatron::Configuration do

  before :each do
    @instance = described_class.new
  end

  subject { @instance }

  describe :default_filters do
    it "should be initialized" do
      subject.default_filters.should == { blank: nil, squish: nil }
    end

    it "should parse and set filters properly" do
      subject.default_filters = :upcase, :blank, { keep: [:L, :N] }, [:remove, :S, :Z]
      subject.default_filters.should == { upcase: nil, blank: nil, keep: [:L, :N], remove: [:S, :Z] }
    end
  end

  describe :filters do
    it "should be initialized" do
      subject.filters[:blank]     .should eq Normatron::Filters::BlankFilter
      subject.filters[:camelize]  .should eq Normatron::Filters::CamelizeFilter
      subject.filters[:capitalize].should eq Normatron::Filters::CapitalizeFilter
      subject.filters[:chomp]     .should eq Normatron::Filters::ChompFilter
      subject.filters[:dasherize] .should eq Normatron::Filters::DasherizeFilter
      subject.filters[:downcase]  .should eq Normatron::Filters::DowncaseFilter
      subject.filters[:dump]      .should eq Normatron::Filters::DumpFilter
      subject.filters[:keep]      .should eq Normatron::Filters::KeepFilter
      subject.filters[:remove]    .should eq Normatron::Filters::RemoveFilter
      subject.filters[:squeeze]   .should eq Normatron::Filters::SqueezeFilter
      subject.filters[:squish]    .should eq Normatron::Filters::SquishFilter
      subject.filters[:strip]     .should eq Normatron::Filters::StripFilter
      subject.filters[:swapcase]  .should eq Normatron::Filters::SwapcaseFilter
      subject.filters[:titleize]  .should eq Normatron::Filters::TitleizeFilter
      subject.filters[:underscore].should eq Normatron::Filters::UnderscoreFilter
      subject.filters[:upcase]    .should eq Normatron::Filters::UpcaseFilter
    end

    it "should allow add new filters" do
      subject.filters[:smile] = MyFilters::SmileFilter
      subject.filters[:smile].should eq MyFilters::SmileFilter
    end

    it "should allow remove filters" do
      lambda { subject.filters.delete(subject.filters.keys.first) }.should_not raise_error
    end
  end

  describe :add_orm do
    it "should include ActiveRecord extension" do
      ActiveRecord::Base.include?(Normatron::Extensions::ActiveRecord).should be_false
      subject.add_orm Normatron::Extensions::ActiveRecord
      ActiveRecord::Base.include?(Normatron::Extensions::ActiveRecord).should be_true
    end
  end
end
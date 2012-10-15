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
    context "when initialized" do
      it { subject.filters[:ascii]     .should eq Normatron::Filters::AsciiFilter }
      it { subject.filters[:blank]     .should eq Normatron::Filters::BlankFilter }
      it { subject.filters[:camelize]  .should eq Normatron::Filters::CamelizeFilter }
      it { subject.filters[:capitalize].should eq Normatron::Filters::CapitalizeFilter }
      it { subject.filters[:chomp]     .should eq Normatron::Filters::ChompFilter }
      it { subject.filters[:dasherize] .should eq Normatron::Filters::DasherizeFilter }
      it { subject.filters[:downcase]  .should eq Normatron::Filters::DowncaseFilter }
      it { subject.filters[:dump]      .should eq Normatron::Filters::DumpFilter }
      it { subject.filters[:keep]      .should eq Normatron::Filters::KeepFilter }
      it { subject.filters[:remove]    .should eq Normatron::Filters::RemoveFilter }
      it { subject.filters[:squeeze]   .should eq Normatron::Filters::SqueezeFilter }
      it { subject.filters[:squish]    .should eq Normatron::Filters::SquishFilter }
      it { subject.filters[:strip]     .should eq Normatron::Filters::StripFilter }
      it { subject.filters[:swapcase]  .should eq Normatron::Filters::SwapcaseFilter }
      it { subject.filters[:titleize]  .should eq Normatron::Filters::TitleizeFilter }
      it { subject.filters[:underscore].should eq Normatron::Filters::UnderscoreFilter }
      it { subject.filters[:upcase]    .should eq Normatron::Filters::UpcaseFilter }
    end

    context "when new filter is added" do
      it "module filter should be set" do
        subject.filters[:smile] = MyFilters::SmileFilter
        subject.filters[:smile].should eq MyFilters::SmileFilter
      end

      it "lambda filter should be set" do
        lambda_filter = lambda { |input, value| input << value }
        subject.filters[:append] = lambda_filter
        subject.filters[:append].should eq lambda_filter
      end
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
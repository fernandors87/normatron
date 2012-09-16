# encoding: UTF-8
require "spec_helper"

describe Normatron::Filters::Conversions do

  let(:mod) { Normatron::Filters::Conversions }
  let(:val) { @value }

  describe :blank do
    it "should return nil for empty strings" do
      value     = ""
      mod.blank(value).should be_nil
      mod.blank(value.mb_chars).should be_nil
    end

    it "should return nil for blank spaces strings" do
      value     = "   "
      mod.blank(value).should be_nil
      mod.blank(value.mb_chars).should be_nil
    end

    it 'should return nil for \n \t \r \f strings' do
      value     = "\n \t \r \f"
      mod.blank(value).should be_nil
      mod.blank(value.mb_chars).should be_nil
    end

    it "should not affect filled string" do
      value     = "baCon"
      expected  = "baCon"
      mod.blank(value).should eq expected
      mod.blank(value.mb_chars).should eq expected.mb_chars
    end

    it "should not affect non string objects" do
      mod.blank(nil).should eq nil
      mod.blank(1).should eq 1
    end
  end
end
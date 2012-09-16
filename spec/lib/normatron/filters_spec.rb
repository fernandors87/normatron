# encoding: UTF-8
require "spec_helper"

describe Normatron::Filters do
  describe :is_a_string? do
    it "should be true Multibyte::Chars object" do
      subject.is_a_string?("".mb_chars).should be_true
    end

    it "should be true String object" do
      subject.is_a_string?("").should be_true
    end

    it "should not be true nil object" do
      subject.is_a_string?(nil).should be_false
    end

    it "should not be true Integer object" do
      subject.is_a_string?(1).should be_false
    end
  end
end
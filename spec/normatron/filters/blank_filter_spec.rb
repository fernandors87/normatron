require 'spec_helper'
require 'normatron/filters/blank_filter'

describe Normatron::Filters::BlankFilter do
  it_should_behave_like "string processor"
  it_should_behave_like "evaluable filter", ["18pm"], "18pm"

  describe :blank do
    let(:word) { "phase" }
    it { subject.send(:evaluate, "           ").should be_nil }
    it { subject.send(:evaluate, "\n \t \r \f").should be_nil }
    it { subject.send(:evaluate, "\n\t\r\f"   ).should be_nil }
    it { subject.send(:evaluate, word         ).should equal word }
  end
end

# encoding: UTF-8

require 'spec_helper'
require 'normatron/filters/squeeze_filter'

describe Normatron::Filters::SqueezeFilter do
  it_should_behave_like "string processor"
  it { should evaluate("squeezing: hells bells").to("squezing: hels bels" ) }
  it { should evaluate("squeezing: hells bells").to("squeezing: hels bels").with("l") }
end
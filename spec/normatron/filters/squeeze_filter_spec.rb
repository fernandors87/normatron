# encoding: UTF-8

require 'spec_helper'
require 'normatron/filters/squeeze_filter'

describe Normatron::Filters::SqueezeFilter do
  it_should_behave_like "string processor"
  it_should_behave_like "evaluable filter", ["1 22  333   4444    "        ], "1 2 3 4 "
  it_should_behave_like "evaluable filter", ["1 22  333   4444    ", "2-3 "], "1 2 3 4444 "
end
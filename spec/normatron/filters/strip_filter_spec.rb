# encoding: UTF-8

require 'spec_helper'
require 'normatron/filters/strip_filter'

describe Normatron::Filters::StripFilter do
  it_should_behave_like "string processor"
  it_should_behave_like "evaluable filter", ["    to anywhere    "     ], "to anywhere"
  it_should_behave_like "evaluable filter", ["    to anywhere    ", :L ], "to anywhere    "
  it_should_behave_like "evaluable filter", ["    to anywhere    ", :R ], "    to anywhere"
  it_should_behave_like "evaluable filter", ["    to anywhere    ", :LR], "to anywhere"
end
# encoding: UTF-8

require 'spec_helper'
require 'normatron/filters/dump_filter'

describe Normatron::Filters::DumpFilter do
  it_should_behave_like "string processor"
  it_should_behave_like "evaluable filter", ["First \n Time"], '"First \n Time"'
  it_should_behave_like "evaluable filter", ['First \n Time'], '"First \\\n Time"'
end
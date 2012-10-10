# encoding: UTF-8

require 'spec_helper'
require 'normatron/filters/downcase_filter'

describe Normatron::Filters::DowncaseFilter do
  it_should_behave_like "string processor"
  it_should_behave_like "evaluable filter", ["caçador"], "caçador"
  it_should_behave_like "evaluable filter", ["CAÇADOR"], "caçador"
end
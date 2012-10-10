# encoding: UTF-8

require 'spec_helper'
require 'normatron/filters/upcase_filter'

describe Normatron::Filters::UpcaseFilter do
  it_should_behave_like "string processor"
  it_should_behave_like "evaluable filter", ["caçador"], "CAÇADOR"
  it_should_behave_like "evaluable filter", ["CAÇADOR"], "CAÇADOR"
end
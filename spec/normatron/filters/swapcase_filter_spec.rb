# encoding: UTF-8

require 'spec_helper'
require 'normatron/filters/swapcase_filter'

describe Normatron::Filters::SwapcaseFilter do
  it_should_behave_like "string processor"
  it_should_behave_like "evaluable filter", ["caçador"], "CAÇADOR"
  it_should_behave_like "evaluable filter", ["CAÇADOR"], "caçador"
  it_should_behave_like "evaluable filter", ["CaÇaDoR"], "cAçAdOr"
  it_should_behave_like "evaluable filter", ["cAçAdOr"], "CaÇaDoR"
end
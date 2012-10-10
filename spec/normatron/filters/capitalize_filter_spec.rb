# encoding: UTF-8

require 'spec_helper'
require 'normatron/filters/capitalize_filter'

describe Normatron::Filters::CapitalizeFilter do
  it_should_behave_like "string processor"
  it_should_behave_like "evaluable filter", ["i love winter" ], "I love winter"
  it_should_behave_like "evaluable filter", ["I LOVE WINTER" ], "I love winter"
  it_should_behave_like "evaluable filter", ["ó, vida cruel!"], "Ó, vida cruel!"
  it_should_behave_like "evaluable filter", ["Ó, VIDA CRUEL!"], "Ó, vida cruel!"
  it_should_behave_like "evaluable filter", ["1 minute"      ], "1 minute"
  it_should_behave_like "evaluable filter", ["1 MINUTE"      ], "1 minute"
end
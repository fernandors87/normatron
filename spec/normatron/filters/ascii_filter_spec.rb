# encoding: UTF-8

require 'spec_helper'
require 'normatron/filters/ascii_filter'

describe Normatron::Filters::AsciiFilter do
  it_should_behave_like "string processor"
  it_should_behave_like "evaluable filter", ["ÉBRIO"              ], "EBRIO"
  it_should_behave_like "evaluable filter", ["até"                ], "ate"
  it_should_behave_like "evaluable filter", ["cirurgião"          ], "cirurgiao"
  it_should_behave_like "evaluable filter", ["email@domain.com"   ], "email@domain.com"
  it_should_behave_like "evaluable filter", ["éçü&! *¬¬"          ], "ecu&! *!!"
  it_should_behave_like "evaluable filter", ["⠋⠗⠁⠝⠉⠑"          ], "france"
end
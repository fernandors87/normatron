# encoding: UTF-8

require 'spec_helper'
require 'normatron/filters/chomp_filter'

describe Normatron::Filters::ChompFilter do
  it_should_behave_like "string processor"
  it_should_behave_like "evaluable filter", ["show me the money"                   ], "show me the money"
  it_should_behave_like "evaluable filter", ["show me the money\n"                 ], "show me the money"
  it_should_behave_like "evaluable filter", ["show me the money\r"                 ], "show me the money"
  it_should_behave_like "evaluable filter", ["show me the money\r\n"               ], "show me the money"
  it_should_behave_like "evaluable filter", ["show me the money\n\r"               ], "show me the money\n"
  it_should_behave_like "evaluable filter", ["show me the money", " money"         ], "show me the"
  it_should_behave_like "evaluable filter", ["show me the money", " money".mb_chars], "show me the"
end
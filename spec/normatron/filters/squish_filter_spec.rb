# encoding: UTF-8

require 'spec_helper'
require 'normatron/filters/squish_filter'

describe Normatron::Filters::SquishFilter do
  it_should_behave_like "string processor"
  it_should_behave_like "evaluable filter", ["  Friday 05 October 2012  "     ], "Friday 05 October 2012"
  it_should_behave_like "evaluable filter", ["Friday   05   October   2012"   ], "Friday 05 October 2012"
  it_should_behave_like "evaluable filter", ["Friday \n05 \nOctober \n2012"   ], "Friday 05 October 2012"
  it_should_behave_like "evaluable filter", ["  Friday  05 \nOctober  2012   "], "Friday 05 October 2012"
end
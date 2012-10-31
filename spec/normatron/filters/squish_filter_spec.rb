# encoding: UTF-8

require 'spec_helper'

module Normatron
  module Filters
    describe SquishFilter do
      it { should evaluate("  Friday 05 October 2012  "     ).to("Friday 05 October 2012") }
      it { should evaluate("Friday   05   October   2012"   ).to("Friday 05 October 2012") }
      it { should evaluate("Friday \n05 \nOctober \n2012"   ).to("Friday 05 October 2012") }
      it { should evaluate("  Friday  05 \nOctober  2012   ").to("Friday 05 October 2012") }
      it { should evaluate(100                              ).to(100                     ) }
      it { should evaluate(nil                              ).to(nil                     ) }
    end
  end
end    
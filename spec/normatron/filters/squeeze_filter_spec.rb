# encoding: UTF-8

require 'spec_helper'

module Normatron
  module Filters
    describe SqueezeFilter do
      it { should evaluate("squeezing: hells bells").to("squezing: hels bels" )           }
      it { should evaluate("squeezing: hells bells").to("squeezing: hels bels").with("l") }
      it { should evaluate(100                     ).to(100                   )           }
      it { should evaluate(nil                     ).to(nil                   )           }
    end
  end
end    
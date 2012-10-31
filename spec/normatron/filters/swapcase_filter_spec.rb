# encoding: UTF-8

require 'spec_helper'

module Normatron
  module Filters
    describe SwapcaseFilter do
      it { should evaluate("caçador").to("CAÇADOR") }
      it { should evaluate("CAÇADOR").to("caçador") }
      it { should evaluate("CaÇaDoR").to("cAçAdOr") }
      it { should evaluate("cAçAdOr").to("CaÇaDoR") }
      it { should evaluate(100      ).to(100      ) }
      it { should evaluate(nil      ).to(nil      ) }
    end
  end
end    
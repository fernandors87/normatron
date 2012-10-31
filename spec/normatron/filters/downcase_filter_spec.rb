# encoding: UTF-8

require 'spec_helper'

module Normatron
  module Filters
    describe DowncaseFilter do
      it { should evaluate("caçador").to("caçador") }
      it { should evaluate("CAÇADOR").to("caçador") }
      it { should evaluate(100      ).to(100      ) }
      it { should evaluate(nil      ).to(nil      ) }
    end
  end
end    
# encoding: UTF-8

require 'spec_helper'

module Normatron
  module Filters
    describe CapitalizeFilter do
      it { should evaluate("i love winter" ).to("I love winter" ) }
      it { should evaluate("I LOVE WINTER" ).to("I love winter" ) }
      it { should evaluate("ó, vida cruel!").to("Ó, vida cruel!") }
      it { should evaluate("Ó, VIDA CRUEL!").to("Ó, vida cruel!") }
      it { should evaluate("1 minute"      ).to("1 minute"      ) }
      it { should evaluate("1 MINUTE"      ).to("1 minute"      ) }
      it { should evaluate(100             ).to(100             ) }
      it { should evaluate(nil             ).to(nil             ) }
    end
  end
end
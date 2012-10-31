# encoding: UTF-8

require 'spec_helper'

module Normatron
  module Filters
    describe StripFilter do
      it { should evaluate("    to anywhere    ").to("to anywhere"    )           }
      it { should evaluate("    to anywhere    ").to("to anywhere    ").with(:L ) }
      it { should evaluate("    to anywhere    ").to("    to anywhere").with(:R ) }
      it { should evaluate("    to anywhere    ").to("to anywhere"    ).with(:LR) }
      it { should evaluate(100                  ).to(100              )           }
      it { should evaluate(nil                  ).to(nil              )           }
    end
  end
end    
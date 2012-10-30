# encoding: UTF-8

require 'spec_helper'

module Normatron
  module Filters
    describe AsciiFilter do
      it { should evaluate("ÉBRIO"           ).to("EBRIO"           ) }
      it { should evaluate("até"             ).to("ate"             ) }
      it { should evaluate("cirurgião"       ).to("cirurgiao"       ) }
      it { should evaluate("email@domain.com").to("email@domain.com") }
      it { should evaluate("éçü&! *¬¬"       ).to("ecu&! *!!"       ) }
      it { should evaluate("⠋⠗⠁⠝⠉⠑"       ).to("france"          ) }
      it { should evaluate(100               ).to(100               ) }
      it { should evaluate(nil               ).to(nil               ) }

      pending "Open a pull request to Stringex.\n'¬' (not sign) character is not evaluating as expected (minus sign or tilde)."
    end
  end
end
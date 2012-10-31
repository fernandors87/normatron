require 'spec_helper'

module Normatron
  module Filters
    describe BlankFilter do
      it { should evaluate("           ").to(nil    ).constraints({identity: false, type: false}) }
      it { should evaluate("\n \t \r \f").to(nil    ).constraints({identity: false, type: false}) }
      it { should evaluate("\n\t\r\f"   ).to(nil    ).constraints({identity: false, type: false}) }
      it { should evaluate("phase"      ).to("phase").constraints({identity: false, type: true }) }
      it { should evaluate(100          ).to(100    ).constraints({identity: false, type: true }) }
      it { should evaluate(nil          ).to(nil    ).constraints({identity: false, type: true }) }
    end
  end
end

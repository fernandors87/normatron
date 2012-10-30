require 'spec_helper'

module Normatron
  module Filters
    describe BlankFilter do
      it { subject.send(:evaluate, "           ").should be_nil      }
      it { subject.send(:evaluate, "\n \t \r \f").should be_nil      }
      it { subject.send(:evaluate, "\n\t\r\f"   ).should be_nil      }
      it { subject.send(:evaluate, "phase"      ).should eq("phase") }
      it { subject.send(:evaluate, 100          ).should eq(100)     }
      it { subject.send(:evaluate, nil          ).should be_nil      }
    end
  end
end

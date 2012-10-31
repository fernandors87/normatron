# encoding: UTF-8

require 'spec_helper'

module Normatron
  module Filters
    describe ChompFilter do
      it { should evaluate("show me the money"    ).to("show me the money"  )                }
      it { should evaluate("show me the money\n"  ).to("show me the money"  )                }
      it { should evaluate("show me the money\r"  ).to("show me the money"  )                }
      it { should evaluate("show me the money\r\n").to("show me the money"  )                }
      it { should evaluate("show me the money\n\r").to("show me the money\n")                }
      it { should evaluate("show me the money"    ).to("show me the"        ).with(" money") }
      it { should evaluate(100                    ).to(100                  )                }
      it { should evaluate(nil                    ).to(nil                  )                }
    end
  end
end
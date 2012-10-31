# encoding: UTF-8

require 'spec_helper'

module Normatron
  module Filters
    describe TitleizeFilter do
      it { should evaluate("04. until it sleeps"      ).to("04. Until It Sleeps"      ) }
      it { should evaluate("04. UNTIL IT SLEEPS"      ).to("04. Until It Sleeps"      ) }
      it { should evaluate("quem é o dono deste sofá?").to("Quem É O Dono Deste Sofá?") }
      it { should evaluate("QUEM É O DONO DESTE SOFÁ?").to("Quem É O Dono Deste Sofá?") }
      it { should evaluate(100                        ).to(100                        ) }
      it { should evaluate(nil                        ).to(nil                        ) }
    end
  end
end    
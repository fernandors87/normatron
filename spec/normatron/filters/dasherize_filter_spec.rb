# encoding: UTF-8

require 'spec_helper'

module Normatron
  module Filters
    describe DasherizeFilter do
      it { should evaluate("string_inflections").to("string-inflections") }
      it { should evaluate(100                 ).to(100                 ) }
      it { should evaluate(nil                 ).to(nil                 ) }
    end
  end
end
# encoding: UTF-8

require 'spec_helper'

module Normatron
  module Filters
    describe DumpFilter do
      it { should evaluate("First \n Time").to('"First \n Time"'  ) }
      it { should evaluate('First \n Time').to('"First \\\n Time"') }
      it { should evaluate(100            ).to(100                ) }
      it { should evaluate(nil            ).to(nil                ) }
    end
  end
end    
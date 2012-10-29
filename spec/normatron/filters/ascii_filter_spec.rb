# encoding: UTF-8

require 'spec_helper'
require 'normatron/filters/ascii_filter'

describe Normatron::Filters::AsciiFilter do
  it_should_behave_like "string processor"
  it { should evaluate("ÉBRIO"           ).to("EBRIO"           ) }
  it { should evaluate("até"             ).to("ate"             ) }
  it { should evaluate("cirurgião"       ).to("cirurgiao"       ) }
  it { should evaluate("email@domain.com").to("email@domain.com") }
  it { should evaluate("éçü&! *¬¬"       ).to("ecu&! *!!"       ) }
  it { should evaluate("⠋⠗⠁⠝⠉⠑"       ).to("france"          ) }
end
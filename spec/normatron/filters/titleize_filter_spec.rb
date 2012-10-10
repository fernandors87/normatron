# encoding: UTF-8

require 'spec_helper'
require 'normatron/filters/titleize_filter'

describe Normatron::Filters::TitleizeFilter do
  it_should_behave_like "string processor"
  it_should_behave_like "evaluable filter", ["04. until it sleeps"      ], "04. Until It Sleeps"
  it_should_behave_like "evaluable filter", ["04. UNTIL IT SLEEPS"      ], "04. Until It Sleeps"
  it_should_behave_like "evaluable filter", ["quem é o dono deste sofá?"], "Quem É O Dono Deste Sofá?"
  it_should_behave_like "evaluable filter", ["QUEM É O DONO DESTE SOFÁ?"], "Quem É O Dono Deste Sofá?"
end
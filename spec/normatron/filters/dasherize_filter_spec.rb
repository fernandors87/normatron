# encoding: UTF-8

require 'spec_helper'
require 'normatron/filters/dasherize_filter'

describe Normatron::Filters::DasherizeFilter do
  it_should_behave_like "string processor"
  it_should_behave_like "evaluable filter", ["string_inflections"], "string-inflections"
end
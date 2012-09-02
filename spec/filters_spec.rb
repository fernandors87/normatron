# encoding: utf-8

require "spec_helper"

describe Normatron::Filters do

  before :each do
    TestModel.normalization_filters = nil
  end

  it :blank do
    value     = nil
    expected  = nil
    Normatron::Filters.apply(:blank, value).should == expected

    value     = "   abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü   "
    expected  = "   abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü   "
    Normatron::Filters.apply(:blank, value).should == expected

    value     = "      "
    expected  = nil
    Normatron::Filters.apply(:blank, value).should == expected

    value     = ""
    expected  = nil
    Normatron::Filters.apply(:blank, value).should == expected
  end

  it :capitalize do
    value     = nil
    expected  = nil
    Normatron::Filters.apply(:capitalize, value).should == expected

    value     = "   abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü   "
    expected  = "   abc   \f   def   \n   123   áèç   \t !*&   \r   4gü   "
    Normatron::Filters.apply(:capitalize, value).should == expected

    value     = "abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü"
    expected  = "Abc   \f   def   \n   123   áèç   \t !*&   \r   4gü"
    Normatron::Filters.apply(:capitalize, value).should == expected
  end

  it :downcase do
    value     = nil
    expected  = nil
    Normatron::Filters.apply(:downcase, value).should == expected

    value     = "   abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü   "
    expected  = "   abc   \f   def   \n   123   áèç   \t !*&   \r   4gü   "
    Normatron::Filters.apply(:downcase, value).should == expected
  end

  it :lstrip do
    value     = nil
    expected  = nil
    Normatron::Filters.apply(:lstrip, value).should == expected

    value     = "   abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü   "
    expected  = "abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü   "
    Normatron::Filters.apply(:lstrip, value).should == expected
  end

  it :rstrip do
    value     = nil
    expected  = nil
    Normatron::Filters.apply(:rstrip, value).should == expected

    value     = "   abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü   "
    expected  = "   abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü"
    Normatron::Filters.apply(:rstrip, value).should == expected
  end

  it :squish do
    value     = nil
    expected  = nil
    Normatron::Filters.apply(:squish, value).should == expected

    value     = "   abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü   "
    expected  = "abc DEF 123 áÈç !*& 4gü"
    Normatron::Filters.apply(:squish, value).should == expected
  end

  it :strip do
    value     = nil
    expected  = nil
    Normatron::Filters.apply(:strip, value).should == expected

    value     = "   abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü   "
    expected  = "abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü"
    Normatron::Filters.apply(:strip, value).should == expected
  end

  it :titlecase do
    value     = nil
    expected  = nil
    Normatron::Filters.apply(:titlecase, value).should == expected
    Normatron::Filters.apply(:titleize, value).should == expected

    value     = "   abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü   "
    expected  = "   Abc   \f   Def   \n   123   Áèç   \t !*&   \r   4gü   "
    Normatron::Filters.apply(:titlecase, value).should == expected
    Normatron::Filters.apply(:titleize, value).should == expected
  end

  it :upcase do
    value     = nil
    expected  = nil
    Normatron::Filters.apply(:upcase, value).should == expected

    value     = "   abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü   "
    expected  = "   ABC   \f   DEF   \n   123   ÁÈÇ   \t !*&   \r   4GÜ   "
    Normatron::Filters.apply(:upcase, value).should == expected
  end

  pending "singularize"
  pending "pluralize"
  pending "parameterize"
  pending "humanize"
  pending "upper_camelcase"
  pending "lower_camelcase"
  pending "classify"
  pending "dasherize"
  pending "deconstantize"
  pending "demodulize"
  pending "html_safe"
  pending "constantize"
  pending "tableize"
  pending "underscore"
=begin
  it :singularize do
    value     = nil
    expected  = nil
    Normatron::Filters.apply(:singularize, value).should == expected

    value     = "products"
    expected  = "product"
    Normatron::Filters.apply(:singularize, value).should == expected
  end

  it :pluralize do
    value     = nil
    expected  = nil
    Normatron::Filters.apply(:pluralize, value).should == expected

    value     = "product"
    expected  = "products"
    Normatron::Filters.apply(:pluralize, value).should == expected
  end

  it :parameterize do
    value     = nil
    expected  = nil
    Normatron::Filters.apply(:parameterize, value).should == expected

    value     = "   abc   \f   DEF   \n   123   áÈç   \t !*&   \r   4gü   "
    expected  = "abc-def-123-aec-4gu"
    Normatron::Filters.apply(:parameterize, value).should == expected
  end

  it :humanize do
    value     = nil
    expected  = nil
    Normatron::Filters.apply(:humanize, value).should == expected

    value     = "éou_shall_not_pass"
    expected  = "Éou_shall_not_pass"
    Normatron::Filters.apply(:humanize, value).should == expected
  end

  it :upper_camelcase do
    value     = nil
    expected  = nil
    Normatron::Filters.apply(:camelize, value).should == expected
    Normatron::Filters.apply(:camelcase, value).should == expected
    Normatron::Filters.apply(:upper_camelize, value).should == expected
    Normatron::Filters.apply(:upper_camelcase, value).should == expected

    value     = "active_record/érrors"
    expected  = "ActiveRecord::Érrors"
    Normatron::Filters.apply(:camelize, value).should == expected
    Normatron::Filters.apply(:camelcase, value).should == expected
    Normatron::Filters.apply(:upper_camelize, value).should == expected
    Normatron::Filters.apply(:upper_camelcase, value).should == expected
  end

  it :lower_camelcase do
    value     = nil
    expected  = nil
    Normatron::Filters.apply(:lower_camelize, value).should == expected
    Normatron::Filters.apply(:lower_camelcase, value).should == expected

    value     = "active_record/érrors"
    expected  = "activeRecord::Érrors"
    Normatron::Filters.apply(:lower_camelize, value).should == expected
    Normatron::Filters.apply(:lower_camelcase, value).should == expected
  end

  it :classify do
    value     = nil
    expected  = nil
    Normatron::Filters.apply(:classify, value).should == expected

    value     = "áctive_record/errors"
    expected  = "ÁctiveRecord::Errors"
    Normatron::Filters.apply(:classify, value).should == expected
  end

  it :dasherize do
    value     = nil
    expected  = nil
    Normatron::Filters.apply(:dasherize, value).should == expected

    value     = "active_record/errors"
    expected  = "active-record/errors"
    Normatron::Filters.apply(:dasherize, value).should == expected
  end
=end
end
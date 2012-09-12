# encoding: UTF-8

require "spec_helper"

describe Normatron::Filters::StringInflections do

  let(:mod) { Normatron::Filters::StringInflections }
  let(:val) { @value }

  describe :blank do
    it "should return nil for empty strings" do
      value     = ""
      mod.blank(value).should be_nil
      mod.blank(value.mb_chars).should be_nil
    end

    it "should return nil for blank spaces strings" do
      value     = "   "
      mod.blank(value).should be_nil
      mod.blank(value.mb_chars).should be_nil
    end

    it 'should return nil for \n \t \r \f strings' do
      value     = "\n \t \r \f"
      mod.blank(value).should be_nil
      mod.blank(value.mb_chars).should be_nil
    end

    it "should not affect filled string" do
      value     = "baCon"
      expected  = "baCon"
      mod.blank(value).should eq expected
      mod.blank(value.mb_chars).should eq expected.mb_chars
    end

    it "should not affect non string objects" do
      mod.blank(nil).should eq nil
      mod.blank(1).should eq 1
    end
  end

  describe :capitalize do
    it "should upcase first char and downcase others" do
      value     = "mASTER OF PUPPETS"
      expected  = "Master of puppets"
      mod.capitalize(value).should eq expected
      mod.capitalize(value.mb_chars).should eq expected.mb_chars
    end

    it "should downcase all chars in string starting with spaces" do
      value     = " mASTER OF PUPPETS"
      expected  = " master of puppets"
      mod.capitalize(value).should eq expected
    end

    it "should affect accented chars" do
      value     = "ILÍADA"
      expected  = "Ilíada"
      mod.capitalize(value).should eq expected
    end

    it "should not affect non string objects" do
      mod.capitalize(nil).should eq nil
      mod.capitalize(1).should eq 1
    end
  end

  describe :dasherize do
    it "should replaces underscores with dashes" do
      value     = "__ shoot _ to _ thrill __"
      expected  = "-- shoot - to - thrill --"
      mod.dasherize(value).should eq expected
      mod.dasherize(value.mb_chars).should eq expected.mb_chars
    end

    it "should not affect non string objects" do
      mod.dasherize(nil).should eq nil
      mod.dasherize(1).should eq 1
    end
  end

  describe :downcase do
    it "should downcase all characters" do
      value     = "KILL'EM ALL"
      expected  = "kill'em all"
      mod.downcase(value).should eq expected
      mod.downcase(value.mb_chars).should eq expected.mb_chars
    end

    it "should affect accented chars" do
      value     = "ÊXITO"
      expected  = "êxito"
      mod.downcase(value).should eq expected
    end

    it "should not affect non string objects" do
      mod.downcase(nil).should eq nil
      mod.downcase(1).should eq 1
    end
  end

  describe :lstrip do
    it "should remove trailing spaces" do
      value     = "     black     "
      expected  = "black     "
      mod.lstrip(value).should eq expected
      mod.lstrip(value.mb_chars).should eq expected.mb_chars
    end

    it "should not affect non string objects" do
      mod.lstrip(nil).should eq nil
      mod.lstrip(1).should eq 1
    end
  end

  describe :rstrip do
    it "should remove leading spaces" do
      value     = "     load     "
      expected  = "     load"
      mod.rstrip(value).should eq expected
      mod.rstrip(value.mb_chars).should eq expected.mb_chars
    end

    it "should not affect non string objects" do
      mod.rstrip(nil).should eq nil
      mod.rstrip(1).should eq 1
    end
  end

  describe :squeeze do
    it "should replace multiple occurrences of a char for a single one" do
      value     = "rock'n roll \n\n ain't noise   pollution"
      expected  = "rock'n rol \n ain't noise polution"
      mod.squeeze(value).should eq expected
      mod.squeeze(value.mb_chars).should eq expected.mb_chars
    end

    it "should not affect non string objects" do
      mod.squeeze(nil).should eq nil
      mod.squeeze(1).should eq 1
    end
  end

  describe :squish do
    it "should remove trailing and leading spaces" do
      value     = "     and justice for all...     "
      expected  = "and justice for all..."
      mod.squish(value).should eq expected
      mod.squish(value.mb_chars).should eq expected.mb_chars
    end

    it "should remove multiple spaces" do
      value     = "and    justice     for      all..."
      expected  = "and justice for all..."
      mod.squish(value).should eq expected
    end

    it 'should remove \n \r \f \t' do
      value     = "\tand\njustice\rfor\fall..."
      expected  = "and justice for all..."
      mod.squish(value).should eq expected
    end

    it "should not affect non string objects" do
      mod.squish(nil).should eq nil
      mod.squish(1).should eq 1
    end
  end

  describe :strip do
    it "should remove trailing and leading spaces" do
      value     = "     reload     "
      expected  = "reload"
      mod.strip(value).should eq expected
      mod.strip(value.mb_chars).should eq expected.mb_chars
    end

    it "should not affect non string objects" do
      mod.strip(nil).should eq nil
      mod.strip(1).should eq 1
    end
  end

  describe :title do
    it "should upcase first char of each word, others downcased" do
      value     = "dirty DEEDS DONE dirt cheap"
      expected  = "Dirty Deeds Done Dirt Cheap"
      mod.title(value).should eq expected
      mod.title(value.mb_chars).should eq expected.mb_chars
    end

    it "should affect accented chars" do
      value     = "isto NÃO é verdade"
      expected  = "Isto Não É Verdade"
      mod.title(value).should eq expected
    end

    it "should not affect non string objects" do
      mod.title(nil).should eq nil
      mod.title(1).should eq 1
    end
  end

  describe :upcase do
    it "should upcase all characters" do
      value     = "Ride the lightning"
      expected  = "RIDE THE LIGHTNING"
      mod.upcase(value).should eq expected
      mod.upcase(value.mb_chars).should eq expected.mb_chars
    end

    it "should affect accented chars" do
      value     = "ébrio"
      expected  = "ÉBRIO"
      mod.upcase(value).should eq expected
    end

    it "should not affect non string objects" do
      mod.upcase(nil).should eq nil
      mod.upcase(1).should eq 1
    end
  end

  pending "chomp with args"
  pending "squeeze with args"
  pending :camelize
  pending :center
  pending :chomp
  pending :chop
  pending :classify
  pending :clear
  pending :constantize
  pending :deconstantize
  pending :demodulize
  pending :dump
  pending :excerpt
  pending :foreign_key
  pending :highlight
  pending :html
  pending :humanize
  pending :just
  pending :ljust
  pending :md
  pending :ordinalize
  pending :parameterize
  pending :permalink
  pending :pluralize
  pending :pluralize
  pending :reverse
  pending :rjust
  pending :safe_constantize
  pending :simple_format
  pending :singularize
  pending "squeeze with args"
  pending :succ
  pending :swapcase
  pending :tableize
  pending :textile
  pending :transliterate
  pending :trim
  pending :truncate
  pending :underscore
  pending :wrap
  pending "remove accents"
  pending "move :blank to another module"
end
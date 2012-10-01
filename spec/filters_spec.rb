# encoding: UTF-8

require 'spec_helper'

describe Normatron::Filters do
  
  subject { described_class }
  let(:mb_chars) { ActiveSupport::Multibyte::Chars }

  #
  # BLANK
  ###################################################################################################################
  describe "::blank" do
    it { subject.blank("    .      "         ).should eq "    .      " }
    it { subject.blank("    .      ".mb_chars).should eq "    .      ".mb_chars }
    
    it { subject.blank("    .      "         ).should be_a String }
    it { subject.blank("           "         ).should be_nil }
    it { subject.blank("\n \t \r \f"         ).should be_nil }

    it { subject.blank("    .      ".mb_chars).should be_a mb_chars }
    it { subject.blank("           ".mb_chars).should be_nil }
    it { subject.blank("\n \t \r \f".mb_chars).should be_nil }

    it { subject.blank(100                   ).should eq 100 }
    it { subject.blank(nil                   ).should be_nil }
  end
  
  #
  # CAMELIZE
  ###################################################################################################################
  describe "::camelize" do
    it { subject.camelize("active_record/errors"                 ).should eq "ActiveRecord::Errors" }
    it { subject.camelize("áctivé_record/érrórs"                 ).should eq "ÁctivéRecord::Érrórs" }
    it { subject.camelize("ActivE_record/ErrOrs"                 ).should eq "ActiveRecord::Errors" }
    it { subject.camelize("ÁctivÉ_record/ÉrrÓrs"                 ).should eq "ÁctivéRecord::Érrórs" }
    it { subject.camelize("active_record/errors", :upper         ).should eq "ActiveRecord::Errors" }
    it { subject.camelize("áctivé_record/érrórs", :upper         ).should eq "ÁctivéRecord::Érrórs" }
    it { subject.camelize("ActivE_record/ErrOrs", :upper         ).should eq "ActiveRecord::Errors" }
    it { subject.camelize("ÁctivÉ_record/ÉrrÓrs", :upper         ).should eq "ÁctivéRecord::Érrórs" }
    it { subject.camelize("active_record/errors", :lower         ).should eq "activeRecord::Errors" }
    it { subject.camelize("áctivé_record/érrórs", :lower         ).should eq "áctivéRecord::Érrórs" }
    it { subject.camelize("ActivE_record/ErrOrs", :lower         ).should eq "activeRecord::Errors" }
    it { subject.camelize("ÁctivÉ_record/ÉrrÓrs", :lower         ).should eq "áctivéRecord::Érrórs" }

    it { subject.camelize("active_record/errors".mb_chars        ).should eq "ActiveRecord::Errors".mb_chars }
    it { subject.camelize("áctivé_record/érrórs".mb_chars        ).should eq "ÁctivéRecord::Érrórs".mb_chars }
    it { subject.camelize("ActivE_record/ErrOrs".mb_chars        ).should eq "ActiveRecord::Errors".mb_chars }
    it { subject.camelize("ÁctivÉ_record/ÉrrÓrs".mb_chars        ).should eq "ÁctivéRecord::Érrórs".mb_chars }
    it { subject.camelize("active_record/errors".mb_chars, :upper).should eq "ActiveRecord::Errors".mb_chars }
    it { subject.camelize("áctivé_record/érrórs".mb_chars, :upper).should eq "ÁctivéRecord::Érrórs".mb_chars }
    it { subject.camelize("ActivE_record/ErrOrs".mb_chars, :upper).should eq "ActiveRecord::Errors".mb_chars }
    it { subject.camelize("ÁctivÉ_record/ÉrrÓrs".mb_chars, :upper).should eq "ÁctivéRecord::Érrórs".mb_chars }
    it { subject.camelize("active_record/errors".mb_chars, :lower).should eq "activeRecord::Errors".mb_chars }
    it { subject.camelize("áctivé_record/érrórs".mb_chars, :lower).should eq "áctivéRecord::Érrórs".mb_chars }
    it { subject.camelize("ActivE_record/ErrOrs".mb_chars, :lower).should eq "activeRecord::Errors".mb_chars }
    it { subject.camelize("ÁctivÉ_record/ÉrrÓrs".mb_chars, :lower).should eq "áctivéRecord::Érrórs".mb_chars }

    it { subject.camelize("active_record/errors"                 ).should be_a String }
    it { subject.camelize("áctivé_record/érrórs"                 ).should be_a String }
    it { subject.camelize("ActivE_record/ErrOrs"                 ).should be_a String }
    it { subject.camelize("ÁctivÉ_record/ÉrrÓrs"                 ).should be_a String }
    it { subject.camelize("active_record/errors", :upper         ).should be_a String }
    it { subject.camelize("áctivé_record/érrórs", :upper         ).should be_a String }
    it { subject.camelize("ActivE_record/ErrOrs", :upper         ).should be_a String }
    it { subject.camelize("ÁctivÉ_record/ÉrrÓrs", :upper         ).should be_a String }
    it { subject.camelize("active_record/errors", :lower         ).should be_a String }
    it { subject.camelize("áctivé_record/érrórs", :lower         ).should be_a String }
    it { subject.camelize("ActivE_record/ErrOrs", :lower         ).should be_a String }
    it { subject.camelize("ÁctivÉ_record/ÉrrÓrs", :lower         ).should be_a String }

    it { subject.camelize("active_record/errors".mb_chars        ).should be_a mb_chars }
    it { subject.camelize("áctivé_record/érrórs".mb_chars        ).should be_a mb_chars }
    it { subject.camelize("ActivE_record/ErrOrs".mb_chars        ).should be_a mb_chars }
    it { subject.camelize("ÁctivÉ_record/ÉrrÓrs".mb_chars        ).should be_a mb_chars }
    it { subject.camelize("active_record/errors".mb_chars, :upper).should be_a mb_chars }
    it { subject.camelize("áctivé_record/érrórs".mb_chars, :upper).should be_a mb_chars }
    it { subject.camelize("ActivE_record/ErrOrs".mb_chars, :upper).should be_a mb_chars }
    it { subject.camelize("ÁctivÉ_record/ÉrrÓrs".mb_chars, :upper).should be_a mb_chars }
    it { subject.camelize("active_record/errors".mb_chars, :lower).should be_a mb_chars }
    it { subject.camelize("áctivé_record/érrórs".mb_chars, :lower).should be_a mb_chars }
    it { subject.camelize("ActivE_record/ErrOrs".mb_chars, :lower).should be_a mb_chars }
    it { subject.camelize("ÁctivÉ_record/ÉrrÓrs".mb_chars, :lower).should be_a mb_chars }

    it { subject.camelize(100                                    ).should eq 100 }
    it { subject.camelize(100, :upper                            ).should eq 100 }
    it { subject.camelize(100, :lower                            ).should eq 100 }
    it { subject.camelize(nil                                    ).should be_nil }
    it { subject.camelize(nil, :upper                            ).should be_nil }
    it { subject.camelize(nil, :lower                            ).should be_nil }

    it { expect { subject.camelize("ÁctivÉ_record/ÉrrÓrs", :other) }.to raise_error }

    context "should affect acronyms" do
      let(:inflections) { ActiveSupport::Inflector::Inflections.instance }

      before(:all) do
        inflections.acronym 'HTTP'
        inflections.acronym 'SSL'
      end

      it { subject.camelize("http_address/ssl", :upper).should eq "HTTPAddress::SSL" }
      it { subject.camelize("http_address/ssl", :lower).should eq "httpAddress::SSL" }

      after(:all) do
        inflections.acronyms = {}
      end
    end
  end

  describe "::capitalize" do
    it { subject.capitalize("abcDEF GhI"         ).should eq "Abcdef ghi" }
    it { subject.capitalize("ébcDEF GhI"         ).should eq "Ébcdef ghi" }
    it { subject.capitalize(" bcDEF GhI"         ).should eq " bcdef ghi" }
    it { subject.capitalize("abcDEF GhI"         ).should be_a String }
    it { subject.capitalize("abcDEF GhI".mb_chars).should be_a mb_chars }
    it { subject.capitalize(100                  ).should eq 100 }
    it { subject.capitalize(nil                  ).should be_nil }
  end

  #
  # CHOMP
  ###################################################################################################################
  describe "::chomp" do
    it { subject.chomp("abcdef ghijkl"                             ).should eq "abcdef ghijkl" }
    it { subject.chomp("abcdef ghij\n"                             ).should eq "abcdef ghij"   }
    it { subject.chomp("abc\nd efghij"                             ).should eq "abc\nd efghij" }
    it { subject.chomp("abc\nd ef\n\r"                             ).should eq "abc\nd ef\n"   }
    it { subject.chomp("abc\nd ef\r\n"                             ).should eq "abc\nd ef"     }
    it { subject.chomp("abcdef ghijkl", "jkl"                      ).should eq "abcdef ghi"    }
    it { subject.chomp("abcdef ghij\n", "j\n"                      ).should eq "abcdef ghi"    }
    it { subject.chomp("abc\nd efghij", " efghij"                  ).should eq "abc\nd"        }
    it { subject.chomp("abc\nd ef\n\r", "\n\r"                     ).should eq "abc\nd ef"     }
    it { subject.chomp("abc\nd ef\r\n", "\n"                       ).should eq "abc\nd ef"     }

    it { subject.chomp("abcdef ghijkl"                             ).should eq "abcdef ghijkl" }
    it { subject.chomp("abcdef ghij\n"                             ).should eq "abcdef ghij"   }
    it { subject.chomp("abc\nd efghij"                             ).should eq "abc\nd efghij" }
    it { subject.chomp("abc\nd ef\n\r"                             ).should eq "abc\nd ef\n"   }
    it { subject.chomp("abc\nd ef\r\n"                             ).should eq "abc\nd ef"     }
    it { subject.chomp("abcdef ghijkl", "jkl"    .mb_chars         ).should eq "abcdef ghi"    }
    it { subject.chomp("abcdef ghij\n", "j\n"    .mb_chars         ).should eq "abcdef ghi"    }
    it { subject.chomp("abc\nd efghij", " efghij".mb_chars         ).should eq "abc\nd"        }
    it { subject.chomp("abc\nd ef\n\r", "\n\r"   .mb_chars         ).should eq "abc\nd ef"     }
    it { subject.chomp("abc\nd ef\r\n", "\n"     .mb_chars         ).should eq "abc\nd ef"     }

    it { subject.chomp("abcdef ghijkl".mb_chars                    ).should eq "abcdef ghijkl".mb_chars }
    it { subject.chomp("abcdef ghij\n".mb_chars                    ).should eq "abcdef ghij"  .mb_chars }
    it { subject.chomp("abc\nd efghij".mb_chars                    ).should eq "abc\nd efghij".mb_chars }
    it { subject.chomp("abc\nd ef\n\r".mb_chars                    ).should eq "abc\nd ef\n"  .mb_chars }
    it { subject.chomp("abc\nd ef\r\n".mb_chars                    ).should eq "abc\nd ef"    .mb_chars }
    it { subject.chomp("abcdef ghijkl".mb_chars, "jkl"             ).should eq "abcdef ghi"   .mb_chars }
    it { subject.chomp("abcdef ghij\n".mb_chars, "j\n"             ).should eq "abcdef ghi"   .mb_chars }
    it { subject.chomp("abc\nd efghij".mb_chars, " efghij"         ).should eq "abc\nd"       .mb_chars }
    it { subject.chomp("abc\nd ef\n\r".mb_chars, "\n\r"            ).should eq "abc\nd ef"    .mb_chars }
    it { subject.chomp("abc\nd ef\r\n".mb_chars, "\n"              ).should eq "abc\nd ef"    .mb_chars }

    it { subject.chomp("abcdef ghijkl".mb_chars                    ).should eq "abcdef ghijkl".mb_chars }
    it { subject.chomp("abcdef ghij\n".mb_chars                    ).should eq "abcdef ghij"  .mb_chars }
    it { subject.chomp("abc\nd efghij".mb_chars                    ).should eq "abc\nd efghij".mb_chars }
    it { subject.chomp("abc\nd ef\n\r".mb_chars                    ).should eq "abc\nd ef\n"  .mb_chars }
    it { subject.chomp("abc\nd ef\r\n".mb_chars                    ).should eq "abc\nd ef"    .mb_chars }
    it { subject.chomp("abcdef ghijkl".mb_chars, "jkl"    .mb_chars).should eq "abcdef ghi"   .mb_chars }
    it { subject.chomp("abcdef ghij\n".mb_chars, "j\n"    .mb_chars).should eq "abcdef ghi"   .mb_chars }
    it { subject.chomp("abc\nd efghij".mb_chars, " efghij".mb_chars).should eq "abc\nd"       .mb_chars }
    it { subject.chomp("abc\nd ef\n\r".mb_chars, "\n\r"   .mb_chars).should eq "abc\nd ef"    .mb_chars }
    it { subject.chomp("abc\nd ef\r\n".mb_chars, "\n"     .mb_chars).should eq "abc\nd ef"    .mb_chars }

    it { subject.chomp("abcdef ghijkl"                             ).should be_a String }
    it { subject.chomp("abcdef ghij\n"                             ).should be_a String }
    it { subject.chomp("abc\nd efghij"                             ).should be_a String }
    it { subject.chomp("abc\nd ef\n\r"                             ).should be_a String }
    it { subject.chomp("abc\nd ef\r\n"                             ).should be_a String }
    it { subject.chomp("abcdef ghijkl", "jkl"                      ).should be_a String }
    it { subject.chomp("abcdef ghij\n", "j\n"                      ).should be_a String }
    it { subject.chomp("abc\nd efghij", " efghij"                  ).should be_a String }
    it { subject.chomp("abc\nd ef\n\r", "\n\r"                     ).should be_a String }
    it { subject.chomp("abc\nd ef\r\n", "\n"                       ).should be_a String }

    it { subject.chomp("abcdef ghijkl"                             ).should be_a String }
    it { subject.chomp("abcdef ghij\n"                             ).should be_a String }
    it { subject.chomp("abc\nd efghij"                             ).should be_a String }
    it { subject.chomp("abc\nd ef\n\r"                             ).should be_a String }
    it { subject.chomp("abc\nd ef\r\n"                             ).should be_a String }
    it { subject.chomp("abcdef ghijkl", "jkl"    .mb_chars         ).should be_a String }
    it { subject.chomp("abcdef ghij\n", "j\n"    .mb_chars         ).should be_a String }
    it { subject.chomp("abc\nd efghij", " efghij".mb_chars         ).should be_a String }
    it { subject.chomp("abc\nd ef\n\r", "\n\r"   .mb_chars         ).should be_a String }
    it { subject.chomp("abc\nd ef\r\n", "\n"     .mb_chars         ).should be_a String }

    it { subject.chomp("abcdef ghijkl".mb_chars                    ).should be_a mb_chars }
    it { subject.chomp("abcdef ghij\n".mb_chars                    ).should be_a mb_chars }
    it { subject.chomp("abc\nd efghij".mb_chars                    ).should be_a mb_chars }
    it { subject.chomp("abc\nd ef\n\r".mb_chars                    ).should be_a mb_chars }
    it { subject.chomp("abc\nd ef\r\n".mb_chars                    ).should be_a mb_chars }
    it { subject.chomp("abcdef ghijkl".mb_chars, "jkl"             ).should be_a mb_chars }
    it { subject.chomp("abcdef ghij\n".mb_chars, "j\n"             ).should be_a mb_chars }
    it { subject.chomp("abc\nd efghij".mb_chars, " efghij"         ).should be_a mb_chars }
    it { subject.chomp("abc\nd ef\n\r".mb_chars, "\n\r"            ).should be_a mb_chars }
    it { subject.chomp("abc\nd ef\r\n".mb_chars, "\n"              ).should be_a mb_chars }

    it { subject.chomp("abcdef ghijkl".mb_chars                    ).should be_a mb_chars }
    it { subject.chomp("abcdef ghij\n".mb_chars                    ).should be_a mb_chars }
    it { subject.chomp("abc\nd efghij".mb_chars                    ).should be_a mb_chars }
    it { subject.chomp("abc\nd ef\n\r".mb_chars                    ).should be_a mb_chars }
    it { subject.chomp("abc\nd ef\r\n".mb_chars                    ).should be_a mb_chars }
    it { subject.chomp("abcdef ghijkl".mb_chars, "jkl"    .mb_chars).should be_a mb_chars }
    it { subject.chomp("abcdef ghij\n".mb_chars, "j\n"    .mb_chars).should be_a mb_chars }
    it { subject.chomp("abc\nd efghij".mb_chars, " efghij".mb_chars).should be_a mb_chars }
    it { subject.chomp("abc\nd ef\n\r".mb_chars, "\n\r"   .mb_chars).should be_a mb_chars }
    it { subject.chomp("abc\nd ef\r\n".mb_chars, "\n"     .mb_chars).should be_a mb_chars }

    it { subject.chomp(100                   ).should eq 100 }
    it { subject.chomp(nil                   ).should be_nil }
  end

  describe "::dasherize" do
    it { subject.dasherize("string_inflections"         ).should eq "string-inflections" }
    it { subject.dasherize("string_inflections"         ).should be_a String }
    it { subject.dasherize("string_inflections".mb_chars).should be_a mb_chars }
    it { subject.dasherize(100                          ).should eq 100 }
    it { subject.dasherize(nil                          ).should be_nil }
  end

  describe "::downcase" do
    it { subject.downcase("ÇSDF !@# JHAS"         ).should eq "çsdf !@# jhas" }
    it { subject.downcase("ÇSDF !@# JHAS"         ).should be_a String }
    it { subject.downcase("ÇSDF !@# JHAS".mb_chars).should be_a mb_chars }
    it { subject.downcase(100                     ).should eq 100 }
    it { subject.downcase(nil                     ).should be_nil }
  end

  #
  # DUMP
  ###################################################################################################################
  describe "::dump" do
    it { subject.dump("abc\ndef"         ).should eq '"abc\ndef"'   }
    it { subject.dump('abc\ndef'         ).should eq '"abc\\\ndef"' }

    it { subject.dump("abc\ndef".mb_chars).should eq '"abc\ndef"'  .mb_chars }
    it { subject.dump('abc\ndef'.mb_chars).should eq '"abc\\\ndef"'.mb_chars }

    it { subject.dump("abc\ndef"         ).should be_a String }
    it { subject.dump('abc\ndef'         ).should be_a String }

    it { subject.dump("abc\ndef".mb_chars).should be_a mb_chars }
    it { subject.dump('abc\ndef'.mb_chars).should be_a mb_chars }

    it { subject.dump(100                     ).should eq 100 }
    it { subject.dump(nil                     ).should be_nil }
  end

  describe "::keep" do
    it { subject.keep("1111aaaa", :L         ).should eq "aaaa" }
    it { subject.keep("1111ܑܑܑܑ", :M          ).should eq "ܑܑܑܑ" }
    it { subject.keep("1111!!!!", :P         ).should eq "!!!!" }
    it { subject.keep("1111££££", :S         ).should eq "££££" }
    it { subject.keep("11    ££", :Z         ).should eq "    " }
    it { subject.keep("11\n\n££", :C         ).should eq "\n\n" }
    it { subject.keep("1111aaaa", :L         ).should be_a String }
    it { subject.keep("1111aaaa".mb_chars, :L).should be_a mb_chars }
    it { subject.keep(1, :L                  ).should eq 1 }
    it { subject.keep(1, :M                  ).should eq 1 }
    it { subject.keep(1, :P                  ).should eq 1 }
    it { subject.keep(1, :S                  ).should eq 1 }
    it { subject.keep(1, :Z                  ).should eq 1 }
    it { subject.keep(1, :C                  ).should eq 1 }
    it { subject.keep(nil, :L                ).should be_nil }
    it { subject.keep(nil, :M                ).should be_nil }
    it { subject.keep(nil, :P                ).should be_nil }
    it { subject.keep(nil, :S                ).should be_nil }
    it { subject.keep(nil, :Z                ).should be_nil }
    it { subject.keep(nil, :C                ).should be_nil }

    context "with multiple options" do
      it { subject.keep("1111aaaa!!!!", [:L, :N]).should eq "1111aaaa" }
      it { subject.keep("1111ܑܑܑܑ!!!!", [:M, :N]).should eq "1111ܑܑܑܑ" }
      it { subject.keep("1111!!!!aaaa", [:P, :L]).should eq "!!!!aaaa" }
      it { subject.keep("1111££££aaaa", [:S, :N]).should eq "1111££££" }
      it { subject.keep("11    ££aaaa", [:Z, :S]).should eq "    ££" }
      it { subject.keep("11\n\n££aaaa", [:C, :N]).should eq "11\n\n" }
    end

    context "with wrong option" do
      it { lambda { subject.keep("1111aaaa", :J) }.should raise_error }
      it { lambda { subject.keep("1111ܑܑܑܑ", :J) }.should raise_error }
      it { lambda { subject.keep("1111!!!!", :J) }.should raise_error }
      it { lambda { subject.keep("1111££££", :J) }.should raise_error }
      it { lambda { subject.keep("11    ££", :J) }.should raise_error }
      it { lambda { subject.keep("11\n\n££", :J) }.should raise_error }
    end

    context "with wrong option inside multiple options array" do
      it { lambda { subject.keep("1111aaaa", [:J, :N]) }.should raise_error }
      it { lambda { subject.keep("1111ܑܑܑܑ", [:J, :N]) }.should raise_error }
      it { lambda { subject.keep("1111!!!!", [:J, :N]) }.should raise_error }
      it { lambda { subject.keep("1111££££", [:J, :N]) }.should raise_error }
      it { lambda { subject.keep("11    ££", [:J, :N]) }.should raise_error }
      it { lambda { subject.keep("11\n\n££", [:J, :N]) }.should raise_error }
    end
  end

  describe "::lstrip" do
    it { subject.lstrip("    1111    "         ).should eq "1111    " }
    it { subject.lstrip("    1111    "         ).should be_a String }
    it { subject.lstrip("    1111    ".mb_chars).should be_a mb_chars }
    it { subject.lstrip(1).should eq 1 }
    it { subject.lstrip(nil).should be_nil }
  end

  describe "::remove" do
    it { subject.remove("1111aaaa", :L         ).should eq "1111" }
    it { subject.remove("1111ܑܑܑܑ", :M          ).should eq "1111" }
    it { subject.remove("1111!!!!", :P         ).should eq "1111" }
    it { subject.remove("1111££££", :S         ).should eq "1111" }
    it { subject.remove("11    ££", :Z         ).should eq "11££" }
    it { subject.remove("11\n\n££", :C         ).should eq "11££" }
    it { subject.remove("1111aaaa", :L         ).should be_a String }
    it { subject.remove("1111aaaa".mb_chars, :L).should be_a mb_chars }
    it { subject.remove(1, :L                  ).should eq 1 }
    it { subject.remove(1, :M                  ).should eq 1 }
    it { subject.remove(1, :P                  ).should eq 1 }
    it { subject.remove(1, :S                  ).should eq 1 }
    it { subject.remove(1, :Z                  ).should eq 1 }
    it { subject.remove(1, :C                  ).should eq 1 }
    it { subject.remove(nil, :L                ).should be_nil }
    it { subject.remove(nil, :M                ).should be_nil }
    it { subject.remove(nil, :P                ).should be_nil }
    it { subject.remove(nil, :S                ).should be_nil }
    it { subject.remove(nil, :Z                ).should be_nil }
    it { subject.remove(nil, :C                ).should be_nil }

    context "with multiple options" do
      it { subject.remove("1111aaaa!!!!", [:L, :N]).should eq "!!!!" }
      it { subject.remove("1111ܑܑܑܑ!!!!", [:M, :N]).should eq "!!!!" }
      it { subject.remove("1111!!!!aaaa", [:P, :L]).should eq "1111" }
      it { subject.remove("1111££££aaaa", [:S, :N]).should eq "aaaa" }
      it { subject.remove("11    ££aaaa", [:Z, :S]).should eq "11aaaa" }
      it { subject.remove("11\n\n££aaaa", [:C, :N]).should eq "££aaaa" }
    end

    context "with wrong option" do
      it { lambda { subject.remove("1111aaaa", :J) }.should raise_error }
      it { lambda { subject.remove("1111ܑܑܑܑ", :J) }.should raise_error }
      it { lambda { subject.remove("1111!!!!", :J) }.should raise_error }
      it { lambda { subject.remove("1111££££", :J) }.should raise_error }
      it { lambda { subject.remove("11    ££", :J) }.should raise_error }
      it { lambda { subject.remove("11\n\n££", :J) }.should raise_error }
    end

    context "with wrong option inside multiple options array" do
      it { lambda { subject.remove("1111aaaa", [:J, :N]) }.should raise_error }
      it { lambda { subject.remove("1111ܑܑܑܑ", [:J, :N]) }.should raise_error }
      it { lambda { subject.remove("1111!!!!", [:J, :N]) }.should raise_error }
      it { lambda { subject.remove("1111££££", [:J, :N]) }.should raise_error }
      it { lambda { subject.remove("11    ££", [:J, :N]) }.should raise_error }
      it { lambda { subject.remove("11\n\n££", [:J, :N]) }.should raise_error }
    end
  end

  describe "::rstrip" do
    it { subject.rstrip("    1111    "         ).should eq "    1111" }
    it { subject.rstrip("    1111    "         ).should be_a String }
    it { subject.rstrip("    1111    ".mb_chars).should be_a mb_chars }
    it { subject.rstrip(1                      ).should eq 1 }
    it { subject.rstrip(nil                    ).should be_nil }
  end

  describe "::squeeze" do
    it { subject.squeeze(" 1  22   333   4444    "         ).should eq " 1 2 3 4 " }
    it { subject.squeeze(" 1  22   333   4444    "         ).should be_a String }
    it { subject.squeeze(" 1  22   333   4444    ".mb_chars).should be_a mb_chars }
    it { subject.squeeze(1                                 ).should eq 1 }
    it { subject.squeeze(nil                               ).should be_nil }

    context "with options" do
      it { subject.squeeze("aaabbbcccdddeeefff", "b-d"         ).should eq "aaabcdeeefff" }
      it { subject.squeeze("aaabbbcccdddeeefff".mb_chars, "b-d").should eq "aaabcdeeefff".mb_chars }
    end
  end

  describe "::squish" do
    it { subject.squish("    11    11    "         ).should eq "11 11" }
    it { subject.squish("    11\n\n11    "         ).should eq "11 11" }
    it { subject.squish("    11    11    "         ).should be_a String }
    it { subject.squish("    11    11    ".mb_chars).should be_a mb_chars }
    it { subject.squish(1                          ).should eq 1 }
    it { subject.squish(nil                        ).should be_nil }
  end

  describe "::strip" do
    it { subject.strip("    1111    "         ).should eq "1111" }
    it { subject.strip("    1111    "         ).should be_a String }
    it { subject.strip("    1111    ".mb_chars).should be_a mb_chars }
    it { subject.strip(1                      ).should eq 1 }
    it { subject.strip(nil                    ).should be_nil }
  end

  #
  # SWAPCASE
  ###################################################################################################################
  describe "::swapcase" do
    it { subject.swapcase("aeiouáéíóú"         ).should eq "AEIOUÁÉÍÓÚ" }
    it { subject.swapcase("AEIOUÁÉÍÓÚ"         ).should eq "aeiouáéíóú" }
    it { subject.swapcase("aEiOuÁéÍóÚ"         ).should eq "AeIoUáÉíÓú" }
    it { subject.swapcase("AeIoUáÉíÓú"         ).should eq "aEiOuÁéÍóÚ" }

    it { subject.swapcase("aeiouáéíóú".mb_chars).should eq "AEIOUÁÉÍÓÚ".mb_chars }
    it { subject.swapcase("AEIOUÁÉÍÓÚ".mb_chars).should eq "aeiouáéíóú".mb_chars }
    it { subject.swapcase("aEiOuÁéÍóÚ".mb_chars).should eq "AeIoUáÉíÓú".mb_chars }
    it { subject.swapcase("AeIoUáÉíÓú".mb_chars).should eq "aEiOuÁéÍóÚ".mb_chars }

    it { subject.swapcase("aeiouáéíóú"         ).should be_a String }
    it { subject.swapcase("AEIOUÁÉÍÓÚ"         ).should be_a String }
    it { subject.swapcase("aEiOuÁéÍóÚ"         ).should be_a String }
    it { subject.swapcase("AeIoUáÉíÓú"         ).should be_a String }
    
    it { subject.swapcase("aeiouáéíóú".mb_chars).should be_a mb_chars }
    it { subject.swapcase("AEIOUÁÉÍÓÚ".mb_chars).should be_a mb_chars }
    it { subject.swapcase("aEiOuÁéÍóÚ".mb_chars).should be_a mb_chars }
    it { subject.swapcase("AeIoUáÉíÓú".mb_chars).should be_a mb_chars }

    it { subject.swapcase(100                  ).should eq 100 }
    it { subject.swapcase(nil                  ).should be_nil }
  end

  describe "::titleize" do
    pending
  end

  describe "::underscore" do
    pending
  end

  describe "::upcase" do
    it { subject.upcase("Çsdf !@# éhas"         ).should eq "ÇSDF !@# ÉHAS" }
    it { subject.upcase("Çsdf !@# éhas"         ).should be_a String }
    it { subject.upcase("Çsdf !@# éhas".mb_chars).should be_a mb_chars }
    it { subject.upcase(100                     ).should eq 100 }
    it { subject.upcase(nil                     ).should be_nil }
  end
end
# encoding: UTF-8

require 'spec_helper'
require 'normatron/filters/underscore_filter'

describe Normatron::Filters::UnderscoreFilter do
  it_should_behave_like "string processor"
  it_should_behave_like "evaluable filter", ["ActiveRecord::Errors"             ], "active_record/errors"
  it_should_behave_like "evaluable filter", ["DadosHistóricos::Período::Empresa"], "dados_históricos/período/empresa"
  it_should_behave_like "evaluable filter", ["ÍmparPar::NorteSul"               ], "ímpar_par/norte_sul"
  
  context "should affect acronyms" do
    let(:inflections) { ActiveSupport::Inflector::Inflections.instance }

    before(:all) do
      inflections.acronym 'docType'
    end

    after(:all) do
      inflections.acronyms.delete("doctype")
    end

    it_should_behave_like "evaluable filter", ["docTypeStop::RunSSL::Xml::MixHTTP" ], "doctype_stop/run_ssl/xml/mix_http"
    it_should_behave_like "evaluable filter", ["DocTypeStop::RunSSL::Xml::MixHTTP" ], "doc_type_stop/run_ssl/xml/mix_http"
  end
end
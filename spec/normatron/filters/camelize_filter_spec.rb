# encoding: UTF-8

require 'spec_helper'
require 'normatron/filters/camelize_filter'

describe Normatron::Filters::CamelizeFilter do
  it_should_behave_like "string processor"
  it_should_behave_like "evaluable filter", ["active_record/errors"                    ], "ActiveRecord::Errors"
  it_should_behave_like "evaluable filter", ["active_record/errors", :upper            ], "ActiveRecord::Errors"
  it_should_behave_like "evaluable filter", ["active_record/errors", :lower            ], "activeRecord::Errors"
  it_should_behave_like "evaluable filter", ["dados_históricos/período/empresa"        ], "DadosHistóricos::Período::Empresa"
  it_should_behave_like "evaluable filter", ["dados_históricos/período/empresa", :upper], "DadosHistóricos::Período::Empresa"
  it_should_behave_like "evaluable filter", ["dados_históricos/período/empresa", :lower], "dadosHistóricos::Período::Empresa"
  it_should_behave_like "evaluable filter", ["ímpar_par/norte_sul"                     ], "ÍmparPar::NorteSul"
  it_should_behave_like "evaluable filter", ["ímpar_par/norte_sul", :upper             ], "ÍmparPar::NorteSul"
  it_should_behave_like "evaluable filter", ["ímpar_par/norte_sul", :lower             ], "ímparPar::NorteSul"
  
  context "should affect acronyms" do
    let(:inflections) { ActiveSupport::Inflector::Inflections.instance }

    before(:all) do
      inflections.acronym 'HTTP'
      inflections.acronym 'SSL'
      inflections.acronym 'Xml'
      inflections.acronym 'docType'
    end

    after(:all) do
      inflections.acronyms.delete("http")
      inflections.acronyms.delete("ssl")
      inflections.acronyms.delete("xml")
      inflections.acronyms.delete("doctype")
    end

    it_should_behave_like "evaluable filter", ["http_address/ssl/xml_file/doctype"        ], "HTTPAddress::SSL::XmlFile::docType"
    it_should_behave_like "evaluable filter", ["http_address/ssl/xml_file/doctype", :upper], "HTTPAddress::SSL::XmlFile::docType"
    it_should_behave_like "evaluable filter", ["http_address/ssl/xml_file/doctype", :lower], "httpAddress::SSL::XmlFile::docType"
    it_should_behave_like "evaluable filter", ["doctype_stop/run_ssl/xml/mix_http"        ], "docTypeStop::RunSSL::Xml::MixHTTP"
    it_should_behave_like "evaluable filter", ["doctype_stop/run_ssl/xml/mix_http", :upper], "docTypeStop::RunSSL::Xml::MixHTTP"
    it_should_behave_like "evaluable filter", ["doctype_stop/run_ssl/xml/mix_http", :lower], "doctypeStop::RunSSL::Xml::MixHTTP"
  end
end
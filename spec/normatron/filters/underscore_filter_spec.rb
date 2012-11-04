# encoding: UTF-8

require 'spec_helper'

module Normatron
  module Filters
    describe UnderscoreFilter do
      it { should evaluate("AintNo::RestFor::TheWicked"  ).to("aint_no/rest_for/the_wicked") }
      it { should evaluate("Assets::Stocks::Companies"   ).to("assets/stocks/companies"    ) }
      it { should evaluate("Bank::Account"               ).to("bank/account"               ) }
      it { should evaluate("ForSale"                     ).to("for_sale"                   ) }
      it { should evaluate("HighVoltage::Musics"         ).to("high_voltage/musics"        ) }
      it { should evaluate("NoteBook::BlackPiano"        ).to("note_book/black_piano"      ) }
      it { should evaluate("Product"                     ).to("product"                    ) }
      it { should evaluate("SouthAmerica::Brazil::Paraná").to("south_america/brazil/paraná") }
      it { should evaluate("YouCannot::StealMy::Wallet"  ).to("you_cannot/steal_my/wallet" ) }
      
      context "with acronyms setted" do
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

        it { should evaluate("HTTPAddress::SSLLib::XmlFile::docType").to("http_address/ssl_lib/xml_file/doctype") }
        it { should evaluate("docTypeStop::RunSSL::Xml::MixHTTP"    ).to("doctype_stop/run_ssl/xml/mix_http"    ) }
      end
    end
  end
end  
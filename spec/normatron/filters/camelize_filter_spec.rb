# encoding: UTF-8

require 'spec_helper'

module Normatron
  module Filters
    describe CamelizeFilter do
      it { should evaluate("aint_no/rest_for/the_wicked").to("AintNo::RestFor::TheWicked"  ) }
      it { should evaluate("AINT_NO/REST_FOR/THE_WICKED").to("AintNo::RestFor::TheWicked"  ) }
      it { should evaluate("Aint_no/Rest_for/The_wicked").to("AintNo::RestFor::TheWicked"  ) }
      it { should evaluate("Aint_No/Rest_For/The_Wicked").to("AintNo::RestFor::TheWicked"  ) }
      it { should evaluate("aInT_No/rEsT_FoR/ThE_WiCkEd").to("AintNo::RestFor::TheWicked"  ) }
      it { should evaluate("AiNt_nO/ReSt_fOr/tHe_wIcKeD").to("AintNo::RestFor::TheWicked"  ) }

      it { should evaluate("assets/stocks/companies"    ).to("Assets::Stocks::Companies"   ) }
      it { should evaluate("ASSETS/STOCKS/COMPANIES"    ).to("Assets::Stocks::Companies"   ) }
      it { should evaluate("Assets/Stocks/Companies"    ).to("Assets::Stocks::Companies"   ) }
      it { should evaluate("aSsEtS/StOcKs/cOmPaNiEs"    ).to("Assets::Stocks::Companies"   ) }
      it { should evaluate("AsSeTs/sToCkS/CoMpAnIeS"    ).to("Assets::Stocks::Companies"   ) }

      it { should evaluate("bank/account"               ).to("Bank::Account"               ) }
      it { should evaluate("BANK/ACCOUNT"               ).to("Bank::Account"               ) }
      it { should evaluate("Bank/Account"               ).to("Bank::Account"               ) }
      it { should evaluate("bAnK/AcCoUnT"               ).to("Bank::Account"               ) }
      it { should evaluate("BaNk/aCcOuNt"               ).to("Bank::Account"               ) }

      it { should evaluate("for_sale"                   ).to("ForSale"                     ) }
      it { should evaluate("FOR_SALE"                   ).to("ForSale"                     ) }
      it { should evaluate("For_sale"                   ).to("ForSale"                     ) }
      it { should evaluate("For_Sale"                   ).to("ForSale"                     ) }
      it { should evaluate("fOr_sAlE"                   ).to("ForSale"                     ) }
      it { should evaluate("FoR_SaLe"                   ).to("ForSale"                     ) }

      it { should evaluate("high_voltage/musics"        ).to("HighVoltage::Musics"         ) }
      it { should evaluate("HIGH_VOLTAGE/MUSICS"        ).to("HighVoltage::Musics"         ) }
      it { should evaluate("High_voltage/Musics"        ).to("HighVoltage::Musics"         ) }
      it { should evaluate("High_Voltage/Musics"        ).to("HighVoltage::Musics"         ) }
      it { should evaluate("hIgH_VoLtAgE/MuSiCs"        ).to("HighVoltage::Musics"         ) }
      it { should evaluate("HiGh_vOlTaGe/mUsIcS"        ).to("HighVoltage::Musics"         ) }

      it { should evaluate("note_book/black_piano"      ).to("NoteBook::BlackPiano"        ) }
      it { should evaluate("NOTE_BOOK/BLACK_PIANO"      ).to("NoteBook::BlackPiano"        ) }
      it { should evaluate("Note_book/Black_piano"      ).to("NoteBook::BlackPiano"        ) }
      it { should evaluate("Note_Book/Black_Piano"      ).to("NoteBook::BlackPiano"        ) }
      it { should evaluate("nOtE_BoOk/bLaCk_pIaNo"      ).to("NoteBook::BlackPiano"        ) }
      it { should evaluate("NoTe_bOoK/BlAcK_PiAnO"      ).to("NoteBook::BlackPiano"        ) }

      it { should evaluate("product"                    ).to("Product"                     ) }
      it { should evaluate("PRODUCT"                    ).to("Product"                     ) }
      it { should evaluate("Product"                    ).to("Product"                     ) }
      it { should evaluate("pRoDuCt"                    ).to("Product"                     ) }
      it { should evaluate("PrOdUcT"                    ).to("Product"                     ) }

      it { should evaluate("south_america/brazil/paraná").to("SouthAmerica::Brazil::Paraná") }
      it { should evaluate("SOUTH_AMERICA/BRAZIL/PARANÁ").to("SouthAmerica::Brazil::Paraná") }
      it { should evaluate("South_america/Brazil/Paraná").to("SouthAmerica::Brazil::Paraná") }
      it { should evaluate("South_America/Brazil/Paraná").to("SouthAmerica::Brazil::Paraná") }
      it { should evaluate("sOuTh_aMeRiCa/bRaZiL/PaRaNá").to("SouthAmerica::Brazil::Paraná") }
      it { should evaluate("SoUtH_AmErIcA/BrAzIl/pArAnÁ").to("SouthAmerica::Brazil::Paraná") }

      it { should evaluate("you_cannot/steal_my/wallet" ).to("YouCannot::StealMy::Wallet"  ) }
      it { should evaluate("YOU_CANNOT/STEAL_MY/WALLET" ).to("YouCannot::StealMy::Wallet"  ) }
      it { should evaluate("You_cannot/Steal_my/Wallet" ).to("YouCannot::StealMy::Wallet"  ) }
      it { should evaluate("You_Cannot/Steal_My/Wallet" ).to("YouCannot::StealMy::Wallet"  ) }
      it { should evaluate("yOu_cAnNoT/StEaL_My/wAlLeT" ).to("YouCannot::StealMy::Wallet"  ) }
      it { should evaluate("YoU_CaNnOt/sTeAl_mY/WaLlEt" ).to("YouCannot::StealMy::Wallet"  ) }

      it { should evaluate("aint_no/rest_for/the_wicked").to("aintNo::RestFor::TheWicked"  ).with(:lower) }
      it { should evaluate("AINT_NO/REST_FOR/THE_WICKED").to("aintNo::RestFor::TheWicked"  ).with(:lower) }
      it { should evaluate("Aint_no/Rest_for/The_wicked").to("aintNo::RestFor::TheWicked"  ).with(:lower) }
      it { should evaluate("Aint_No/Rest_For/The_Wicked").to("aintNo::RestFor::TheWicked"  ).with(:lower) }
      it { should evaluate("aInT_No/rEsT_FoR/ThE_WiCkEd").to("aintNo::RestFor::TheWicked"  ).with(:lower) }
      it { should evaluate("AiNt_nO/ReSt_fOr/tHe_wIcKeD").to("aintNo::RestFor::TheWicked"  ).with(:lower) }

      it { should evaluate(100).to(100) }
      it { should evaluate(nil).to(nil) }
      
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

        it { should evaluate("http_address/ssl_lib/xml_file/doctype").to("HTTPAddress::SSLLib::XmlFile::docType") }
        it { should evaluate("http_address/ssl_lib/xml_file/doctype").to("httpAddress::SSLLib::XmlFile::docType").with(:lower) }
        it { should evaluate("doctype_stop/run_ssl/xml/mix_http"    ).to("docTypeStop::RunSSL::Xml::MixHTTP"    ) }
        it { should evaluate("doctype_stop/run_ssl/xml/mix_http"    ).to("doctypeStop::RunSSL::Xml::MixHTTP"    ).with(:lower) }
      end
    end
  end
end
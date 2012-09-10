require "spec_helper"

describe Normatron::Extensions::ActiveRecord do
	let(:model_class) 		{ Client }

	before :each do
		model_class.normalize_options = {}
	end

	it "should allow get and set normalization options" do
		model_class.normalize(:name, :cpf, with: [:a, :b]).should include(name: [:a, :b], cpf: [:a, :b])
		model_class.normalize_options.should include(name: [:a, :b], cpf: [:a, :b])
	end

	it "should allow set multiple attributes" do
		model_class.normalize(:name, :cpf, :phone)
		model_class.normalize_options.should include(:name, :cpf, :phone)
	end

	it "should allow include single filter" do
		model_class.normalize(:name, with: :a)
		model_class.normalize_options.should include(name: [:a])
	end

	it "should allow include multiple filters" do
		model_class.normalize(:name, with: [:a, :b])
		model_class.normalize_options.should include(name: [:a, :b])
	end

  it "should include default filters" do
    model_class.normalize(:name)
    model_class.normalize_options.should include(name: [:squish, :blank])
  end

  it "should apply normalizations" do
  	model_class.normalize(:name)
  	instance = model_class.new
  	instance.name = "   xxx   "
  	instance.apply_normalizations
  	instance.name.should eq "xxx"

  	class Client < ActiveRecord::Base
  		def my_filter(value)
  			value.split(//) * "-"
  		end
  	end

  	model_class.normalize(:name, with: :my_filter)
  	instance = model_class.new
  	instance.name = "xxx"
  	instance.apply_normalizations
  	instance.name.should eq "x-x-x"
  end

  pending "should apply default normalizations when :with is ommited"
  pending "should apply instance methods normalizations"
  pending "should apply blocks normalizations"
  pending "should apply modules normalizations"
  pending "should apply configuration blocks normalizations"

  pending "should set default normalization filters" do
  	pending "to single attribute"
  	pending "to multiple attributes"
  end
  pending "should set single normalization filter" do
  	pending "to single attribute"
  	pending "to multiple attributes"
  end
  pending "should set multiple normalization filters" do
  	pending "to single attribute"
  	pending "to multiple attributes"
  end
  pending "should remove repeated normalization" do
  	pending "attributes"
  	pending "filters"
  end
  pending "should remove nil normalization" do
  	pending "attributes"
  	pending "filters"
  end
  pending "should ignore nil normalization" do
  	pending "attribute"
  	pending "filter"
  end
  pending "should apply normalizations" do
  	pending "using a single filter" do
  		pending "for a single attribute"
  		pending "for all attributes"
  	end
  	pending "using multiple filters" do
  		pending "for a single attribute"
  		pending "for all attributes"
  	end
  	pending "specified into" do
  		pending "native filters module"
  		pending "custom filters module"
  		pending "instance model"
  		pending "instance block"
  		pending "instance lambda"
  		pending "configuration lambda"
  	end
  end
  pending "should allow specify" do
  	pending "when the normalizations will be done"
  	pending "conditions to normalizations be done"
  	pending "sequence of normalization chain"
  end
  pending "should raise exception" do
  	pending "when given attribute doesn't exist"
  	pending "when given filter doesn't exist"
  end
end
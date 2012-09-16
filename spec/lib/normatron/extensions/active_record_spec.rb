require "spec_helper"

describe Normatron::Extensions::ActiveRecord do
	let(:model_class) 		{ Client }

	before :each do
		model_class.normalize_options = {}
	end

  describe :normalize do
    pending "should remove nil normalization" do
    pending "attributes"
    pending "filters"
  end
    it "should remove nil normalization filters" do
      model_class.normalize(:name, :with => [:a, :a, :b, :c, :c, nil])
      model_class.normalize_options.should == {:name => [:a, :b, :c]}

      model_class.normalize_options = {}
      model_class.normalize(:name, :with => [nil])
      model_class.normalize_options.should == {:name => [:squish, :blank]}
    end

    it "should remove repeated normalization filters" do
      model_class.normalize(:name, :with => [:a, :a, :b, :c, :c])
      model_class.normalize_options.should == {:name => [:a, :b, :c]}

      model_class.normalize(:name, :with => [:a, :d, :e])
      model_class.normalize_options.should == {:name => [:a, :b, :c, :d, :e]}
    end

    it "should stack repeated normalization attributes" do
      model_class.normalize(:name, :name, :with => [:a, :b, :c])
      model_class.normalize_options.should == {:name => [:a, :b, :c]}

      model_class.normalize(:name, :with => [:d, :e])
      model_class.normalize_options.should == {:name => [:a, :b, :c, :d, :e]}
    end

    context "with single normalization attribute" do
      it "should bind to a single attribute" do
        model_class.normalize(:name, with: :a)
        model_class.normalize_options.should == {:name => [:a]}
      end

      it "should bind to multiple attributes" do
        model_class.normalize(:name, :cpf, with: [:a])
        model_class.normalize_options.should == {:name => [:a], cpf: [:a]}
      end
    end

    context "with multiple normalization attributes" do
      it "should bind to a single attribute" do
        model_class.normalize(:name, with: [:a, :b])
        model_class.normalize_options.should == {:name => [:a, :b]}
      end

      it "should bind to multiple attributes" do
        model_class.normalize(:name, :cpf, with: [:a, :b])
        model_class.normalize_options.should == {:name => [:a, :b], cpf: [:a, :b]}
      end
    end

    context "when :with isn't present" do
      describe "default filters" do
        it "should bind to a single attribute" do
          model_class.normalize(:name)
          model_class.normalize_options.should == {:name => [:squish, :blank]}
        end

        it "should bind to multiple attributes" do
          model_class.normalize(:name, :phone)
          model_class.normalize_options.should == {:name => [:squish, :blank], phone: [:squish, :blank]}
        end
      end
    end

  end

  describe :apply_normalizations do
    it "should apply Conversion normalizations" do
      model_class.normalize(:name, :with => :blank)
      instance = model_class.new name: "     "
      instance.apply_normalizations
      instance.name.should be_nil
    end

    it "should apply StringInflections normalizations" do
      model_class.normalize(:name, :with => :upcase)
      instance = model_class.new name: "a"
      instance.apply_normalizations
      instance.name.should eq "A"
    end

    it "should apply instance methods normalizations" do
      class Client < ActiveRecord::Base
        def my_filter(value)
          value.split(//) * "-"
        end
      end

      model_class.normalize(:name, :with => :my_filter)
      instance = model_class.new name: "aaa"
      instance.apply_normalizations
      instance.name.should eq "a-a-a"
    end
  end

  pending "should apply blocks normalizations"
  pending "should apply modules normalizations"
  pending "should apply configuration blocks normalizations"
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
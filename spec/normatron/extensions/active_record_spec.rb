require 'normatron'
require 'spec_helper'

describe Normatron::Extensions::ActiveRecord do
  
  it { subject.constants.should include(:ORM_CLASS) }

  let(:ext) { Normatron::Extensions }
  let(:configuration) { Normatron.configuration }
  let(:model) { User }

  before(:all) { ActiveRecord::Base.send(:include, Normatron::Extensions::ActiveRecord) }
  before(:each) { model.normalize_filters = nil }
  after(:all) do
    ActiveRecord.send(:remove_const, :Base)
    load 'active_record/base.rb'
  end


  describe :normalize do
    subject { model }

    it "should raise UnknownAttributeError" do
      lambda { subject.normalize :unknown         }.should raise_error(ext::UnknownAttributeError)
      lambda { subject.normalize nil              }.should raise_error(ext::UnknownAttributeError)
      lambda { subject.normalize :phone, :unknown }.should raise_error(ext::UnknownAttributeError)
    end

    it "should append default filters" do
      subject.normalize :login, :email
      subject.normalize_filters.should == { :login => configuration.default_filters,
                                            :email => configuration.default_filters }
    end

    it "should stack filters for multiple calls" do
      subject.normalize :login
      subject.normalize :login, :with => :upcase
      subject.normalize_filters.should == { :login => configuration.default_filters.merge({ :upcase => nil }) }
    end

    it "should append multiple attributes" do
      subject.normalize :login, :email, :phone
      subject.normalize_filters.should == { login: { squish: nil, blank: nil },
                                            email: { squish: nil, blank: nil },
                                            phone: { squish: nil, blank: nil } }
    end

    it "should allow multiple filters" do
      subject.normalize :login, :with => [:upcase, :blank]
      subject.normalize_filters.should == { login: { upcase: nil, blank: nil } }
    end

    it "should allow multiple filters" do
      subject.normalize :login, :with => [[:keep, :L], { :remove => [:N] }]
      subject.normalize_filters.should == { login: { keep: [:L], remove: [:N] } }
    end
  end

  describe :apply_normalizations do
    before(:each) { @instance = model.new }
    subject { @instance }

    it "should run instance method filter" do
      model.class_eval do
        define_method :sad_face do |value|
          value + " =("
        end
      end

      model.normalize :login, :with => :sad_face
      subject.login = "..."
      subject.apply_normalizations
      subject.login.should eq "... =("
    end

    it "should run native filter" do
      model.normalize :login, :with => :squish
      subject.login = "  word  "
      subject.apply_normalizations
      subject.login.should eq "word"
    end

    it "should be called before validation" do
      model.normalize :login, :with => :blank
      subject.login = "    "
      subject.valid?
      subject.login.should == nil
    end

    it "should raise UnknownFilterError" do
      model.normalize :login, :with => :unknown
      subject.login = "    "
      lambda { subject.apply_normalizations }.should raise_error(ext::UnknownFilterError)
    end
  end
end
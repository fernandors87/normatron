require 'spec_helper'
require 'normatron'

describe Normatron do

  specify do
    described_class.should respond_to :configuration
    described_class.should respond_to :setup
    described_class.should respond_to :config
  end

  let(:config)  { Normatron.configuration }

  describe :configuration do
    it { config.should be_an_instance_of Normatron::Configuration }
    it { expect { |b| Normatron.setup(&b) }.to yield_control }
  end

  describe :build_hash do
    context "with single filter hash" do
      it { described_class.build_hash( :a               ).should == { a: nil } }
      it { described_class.build_hash( [:a]             ).should == { a: nil } }
      it { described_class.build_hash( [[:a]]           ).should == { a: nil } }
      it { described_class.build_hash( [[:a, :b]]       ).should == { a: [:b] } }
      it { described_class.build_hash( {:a => :b}       ).should == { a: [:b] } }
      it { described_class.build_hash( {:a => [:b]}     ).should == { a: [:b] } }
      it { described_class.build_hash( {:a => [[:b]]}   ).should == { a: [[:b]] } }
      it { described_class.build_hash( [{:a => [[:b]]}] ).should == { a: [[:b]] } }
    end

    context "with double filters hash" do
      it { described_class.build_hash( :a, :b               ).should == { a: nil, b: nil } }
      it { described_class.build_hash( [:a, :b]             ).should == { a: nil, b: nil } }
      it { described_class.build_hash( [:a, :b => [:c, :d]] ).should == { a: nil, b: [:c, :d] } }
      it { described_class.build_hash( [:a, [:b, :c, :d]]   ).should == { a: nil, b: [:c, :d] } }
    end

    context "with trible filters hash" do
      it { described_class.build_hash( [:a, [:b, :c, :d], { e: [:f, :g] }]    ).should == { a: nil, b: [:c, :d], e: [:f, :g] } }
      it { described_class.build_hash( [:a, { b: [:c, :d] }, { e: [:f, :g] }] ).should == { a: nil, b: [:c, :d], e: [:f, :g] } }
      it { described_class.build_hash( [:a, { b: [:c, :d], e: [:f, :g] }]     ).should == { a: nil, b: [:c, :d], e: [:f, :g] } }
    end
  end
end
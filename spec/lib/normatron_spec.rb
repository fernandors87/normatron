require "spec_helper"

describe Normatron do
  let(:mod)     { Normatron }
  let(:config)  { Normatron.configuration }

  describe "configuration" do
    it "should respond to aliases" do
      mod.should respond_to :configuration
      mod.should respond_to :configure
      mod.should respond_to :setup
    end

    it "should return configuration object" do
      config.should be_an_instance_of Normatron::Configuration
    end

    it "should process given blocks" do
      expect { |b| Normatron.setup(&b) }.to yield_control
    end
  end
end
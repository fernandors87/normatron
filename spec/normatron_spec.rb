require "spec_helper"

describe Normatron do

  specify do
    described_class.should respond_to :configuration
    described_class.should respond_to :configure
    described_class.should respond_to :setup
    described_class.should respond_to :config
  end

  let(:config)  { Normatron.configuration }

  describe :configuration do
    it { config.should be_an_instance_of Normatron::Configuration }
    it { expect { |b| Normatron.setup(&b) }.to yield_control }
  end
end
# encoding: UTF-8

require "active_record"
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include(FilterMatcher)
end

shared_examples "evaluable filter" do |args, expected|
  if args.size == 1
    it { subject.send(:evaluate, args[0]).should_not equal expected }
    it { subject.send(:evaluate, args[0]).should eq expected }
    it { subject.send(:evaluate, args[0]).should be_a String }
  else
    it { subject.send(:evaluate, args[0], *args[1..-1]).should_not equal expected }
    it { subject.send(:evaluate, args[0], *args[1..-1]).should eq expected }
    it { subject.send(:evaluate, args[0], *args[1..-1]).should be_a String }
  end
end

shared_examples "string processor" do |*args|
  let(:number) { rand(1000) }

  if args.any?
    it { subject.send(:evaluate, number, args).should eq number }
    it { subject.send(:evaluate, nil, args).should be_nil }
  else
    it { subject.send(:evaluate, number).should eq number }
    it { subject.send(:evaluate, nil).should be_nil }
  end
end

shared_examples "character cleaner" do |action, properties|
  let(:word) {"ᰄ긚 ᧔瑤л꽥๏ ѨDꨥ\aՇ謬ꗀᶆᵆ쳻ῼἬ鿃ႍꥈᤫ꙲⅟౮ⅰ⅘༌_゠⟦〉⸠›⸓⌟⅂₧௹¨⣭  \u2028\u2029\u008C\u0011⁠\uA7E5" }
  let(:regex) do
    construct = properties.map { |p| "\\p{#{p.to_s}}" } * ""
    construct = "[#{'^' if action == :keep}#{construct}]"
    Regexp.new(construct.force_encoding "UTF-8")
  end

  it { subject.evaluate(word, properties).should eq word.gsub(regex, '') }
end
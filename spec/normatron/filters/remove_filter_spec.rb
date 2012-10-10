# encoding: UTF-8

require 'spec_helper'
require 'normatron/filters/remove_filter'

describe Normatron::Filters::RemoveFilter do
  it_should_behave_like "string processor"
  it_should_behave_like "character cleaner", :remove, [:Graph]
  it_should_behave_like "character cleaner", :remove, [:Punct]
  it_should_behave_like "character cleaner", :remove, [:Upper]
  it_should_behave_like "character cleaner", :remove, [:Word]
  it_should_behave_like "character cleaner", :remove, [:Latin]
  it_should_behave_like "character cleaner", :remove, [:L]
  it_should_behave_like "character cleaner", :remove, [:M]
  it_should_behave_like "character cleaner", :remove, [:N]
  it_should_behave_like "character cleaner", :remove, [:P]
  it_should_behave_like "character cleaner", :remove, [:S]
  it_should_behave_like "character cleaner", :remove, [:Z]
  it_should_behave_like "character cleaner", :remove, [:C]
  it_should_behave_like "character cleaner", :remove, [:Graph, :Punct]
  it_should_behave_like "character cleaner", :remove, [:Graph, :Upper]
  it_should_behave_like "character cleaner", :remove, [:Graph, :Word]
  it_should_behave_like "character cleaner", :remove, [:Graph, :Latin]
  it_should_behave_like "character cleaner", :remove, [:Graph, :L]
  it_should_behave_like "character cleaner", :remove, [:Graph, :M]
  it_should_behave_like "character cleaner", :remove, [:Graph, :N]
  it_should_behave_like "character cleaner", :remove, [:Graph, :P]
  it_should_behave_like "character cleaner", :remove, [:Graph, :S]
  it_should_behave_like "character cleaner", :remove, [:Graph, :Z]
  it_should_behave_like "character cleaner", :remove, [:Graph, :C]
  it_should_behave_like "character cleaner", :remove, [:Punct, :Upper]
  it_should_behave_like "character cleaner", :remove, [:Punct, :Word]
  it_should_behave_like "character cleaner", :remove, [:Punct, :Latin]
  it_should_behave_like "character cleaner", :remove, [:Punct, :L]
  it_should_behave_like "character cleaner", :remove, [:Punct, :M]
  it_should_behave_like "character cleaner", :remove, [:Punct, :N]
  it_should_behave_like "character cleaner", :remove, [:Punct, :P]
  it_should_behave_like "character cleaner", :remove, [:Punct, :S]
  it_should_behave_like "character cleaner", :remove, [:Punct, :Z]
  it_should_behave_like "character cleaner", :remove, [:Punct, :C]
  it_should_behave_like "character cleaner", :remove, [:Upper, :Word]
  it_should_behave_like "character cleaner", :remove, [:Upper, :Latin]
  it_should_behave_like "character cleaner", :remove, [:Upper, :L]
  it_should_behave_like "character cleaner", :remove, [:Upper, :M]
  it_should_behave_like "character cleaner", :remove, [:Upper, :N]
  it_should_behave_like "character cleaner", :remove, [:Upper, :P]
  it_should_behave_like "character cleaner", :remove, [:Upper, :S]
  it_should_behave_like "character cleaner", :remove, [:Upper, :Z]
  it_should_behave_like "character cleaner", :remove, [:Upper, :C]
  it_should_behave_like "character cleaner", :remove, [:Word, :Latin]
  it_should_behave_like "character cleaner", :remove, [:Word, :L]
  it_should_behave_like "character cleaner", :remove, [:Word, :M]
  it_should_behave_like "character cleaner", :remove, [:Word, :N]
  it_should_behave_like "character cleaner", :remove, [:Word, :P]
  it_should_behave_like "character cleaner", :remove, [:Word, :S]
  it_should_behave_like "character cleaner", :remove, [:Word, :Z]
  it_should_behave_like "character cleaner", :remove, [:Word, :C]
  it_should_behave_like "character cleaner", :remove, [:Latin, :L]
  it_should_behave_like "character cleaner", :remove, [:Latin, :M]
  it_should_behave_like "character cleaner", :remove, [:Latin, :N]
  it_should_behave_like "character cleaner", :remove, [:Latin, :P]
  it_should_behave_like "character cleaner", :remove, [:Latin, :S]
  it_should_behave_like "character cleaner", :remove, [:Latin, :Z]
  it_should_behave_like "character cleaner", :remove, [:Latin, :C]
  it_should_behave_like "character cleaner", :remove, [:L, :M]
  it_should_behave_like "character cleaner", :remove, [:L, :N]
  it_should_behave_like "character cleaner", :remove, [:L, :P]
  it_should_behave_like "character cleaner", :remove, [:L, :S]
  it_should_behave_like "character cleaner", :remove, [:L, :Z]
  it_should_behave_like "character cleaner", :remove, [:L, :C]
  it_should_behave_like "character cleaner", :remove, [:M, :N]
  it_should_behave_like "character cleaner", :remove, [:M, :P]
  it_should_behave_like "character cleaner", :remove, [:M, :S]
  it_should_behave_like "character cleaner", :remove, [:M, :Z]
  it_should_behave_like "character cleaner", :remove, [:M, :C]
  it_should_behave_like "character cleaner", :remove, [:N, :P]
  it_should_behave_like "character cleaner", :remove, [:N, :S]
  it_should_behave_like "character cleaner", :remove, [:N, :Z]
  it_should_behave_like "character cleaner", :remove, [:N, :C]
  it_should_behave_like "character cleaner", :remove, [:P, :S]
  it_should_behave_like "character cleaner", :remove, [:P, :Z]
  it_should_behave_like "character cleaner", :remove, [:P, :C]
  it_should_behave_like "character cleaner", :remove, [:S, :Z]
  it_should_behave_like "character cleaner", :remove, [:S, :C]
  it_should_behave_like "character cleaner", :remove, [:Z, :C]
end
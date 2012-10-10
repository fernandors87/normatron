require 'normatron/extensions/active_record'

module Normatron
  module Extensions
    class UnknownAttributeError < RuntimeError ; end
    class UnknownFilterError < RuntimeError ; end
  end
end
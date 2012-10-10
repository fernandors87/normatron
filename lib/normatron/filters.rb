require 'normatron/filters/blank_filter'
require 'normatron/filters/camelize_filter'
require 'normatron/filters/capitalize_filter'
require 'normatron/filters/chomp_filter'
require 'normatron/filters/dasherize_filter'
require 'normatron/filters/downcase_filter'
require 'normatron/filters/dump_filter'
require 'normatron/filters/keep_filter'
require 'normatron/filters/remove_filter'
require 'normatron/filters/squeeze_filter'
require 'normatron/filters/squish_filter'
require 'normatron/filters/strip_filter'
require 'normatron/filters/swapcase_filter'
require 'normatron/filters/titleize_filter'
require 'normatron/filters/underscore_filter'
require 'normatron/filters/upcase_filter'

module Normatron
  # Top-Level namespace of all native Normatron filters.
  #
  # All filters share some characteristics:
  # * They have the <code>Filter</code> suffix in the name.
  # * Has a class method called <code>evaluate</code>, which runs what the filter claims to do.
  # * The first argument of the method <code>evaluate</code> always will be the variable to be filtered.
  # * They returns a different object from the input variable, ie, even if the value remains unchanged, the <code>object_id</code> of both variables will be different.
  # * They treat accented characters and not just <code>/[a-zA-Z]/</code> interval.
  module Filters
  end
end



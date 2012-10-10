require 'normatron/filters'

module Normatron
  class Configuration
    attr_reader   :default_filters
    attr_accessor :filters

    def initialize
      @default_filters = { blank: nil, squish: nil }

      @filters = {}
      @filters[:blank]      = Normatron::Filters::BlankFilter
      @filters[:camelize]   = Normatron::Filters::CamelizeFilter
      @filters[:capitalize] = Normatron::Filters::CapitalizeFilter
      @filters[:chomp]      = Normatron::Filters::ChompFilter
      @filters[:dasherize]  = Normatron::Filters::DasherizeFilter
      @filters[:downcase]   = Normatron::Filters::DowncaseFilter
      @filters[:dump]       = Normatron::Filters::DumpFilter
      @filters[:keep]       = Normatron::Filters::KeepFilter
      @filters[:remove]     = Normatron::Filters::RemoveFilter
      @filters[:squeeze]    = Normatron::Filters::SqueezeFilter
      @filters[:squish]     = Normatron::Filters::SquishFilter
      @filters[:strip]      = Normatron::Filters::StripFilter
      @filters[:swapcase]   = Normatron::Filters::SwapcaseFilter
      @filters[:titleize]   = Normatron::Filters::TitleizeFilter
      @filters[:underscore] = Normatron::Filters::UnderscoreFilter
      @filters[:upcase]     = Normatron::Filters::UpcaseFilter
    end

    def add_orm(extension)
      extension::ORM_CLASS.send(:include, extension)
    end

    def default_filters=(filters)
      @default_filters = Normatron.build_hash(filters)
    end
  end
end
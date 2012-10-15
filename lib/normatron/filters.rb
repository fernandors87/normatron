Dir[File.dirname(__FILE__) + "/filters/*_filter.rb"].each do |file|
  require file
end

module Normatron

  # Top-Level namespace of all built-in Normatron filters.
  # 
  # All filters share some characteristics:
  # * They have the <code>Filter</code> suffix in the name.
  # * Has a class method called <code>evaluate</code>, which runs what the filter claims to do.
  # * The first argument of the method <code>evaluate</code> always will be the variable to be filtered.
  # * They returns a different object from the input variable, i.e., even if object value remains unchanged, the <code>object_id</code> will be different.
  # * They treat unicode characters(<code>/\p{Ll}\p{Lu}/u</code>) instead of only ASCII characters(<code>/[a-zA-Z]/</code>).
  # 
  # table{font-family: monospace; font-size: 90%}.
  # |_. CLASS                                     |_. SYMBOL  |_. SHORT DESCRIPTION                                                                  |
  # |"AsciiFilter":./Filters/AsciiFilter          |:ascii     |Converts Unicode(and accented ASCII) characters to their plain-text ASCII equivalents.|
  # |"BlankFilter":./Filters/BlankFilter          |:blank     |Returns nil for a blank string or the string itself otherwise.                        |
  # |"CamelizeFilter":./Filters/CamelizeFilter    |:camelize  |Convert string to UpperCamelCase or lowerCamelCase.                                   |
  # |"CapitalizeFilter":./Filters/CapitalizeFilter|:capitalize|Makes only the first character as capital letter.                                     |
  # |"ChompFilter":./Filters/ChompFilter          |:chomp     |Remove the given record separator from the end of the string.                         |
  # |"DasherizeFilter":./Filters/DasherizeFilter  |:dasherize |Replaces all underscores with dashes.                                                 |
  # |"DowncaseFilter":./Filters/DowncaseFilter    |:downcase  |Lowercase all characters.                                                             |
  # |"DumpFilter":./Filters/DumpFilter            |:dump      |Creates a literal string representation.                                              |
  # |"KeepFilter":./Filters/KeepFilter            |:keep      |Remove the characters that doesn't match the given properties.                        |
  # |"RemoveFilter":./Filters/RemoveFilter        |:remove    |Remove the characters that match the given properties.                                |
  # |"SqueezeFilter":./Filters/SqueezeFilter      |:squeeze   |Remove multiple occurences of the same character.                                     |
  # |"SquishFilter":./Filters/SquishFilter        |:squish    |Strips the input, remove line-breaks and multiple spaces.                             |
  # |"SwapcaseFilter":./Filters/SwapcaseFilter    |:swapcase  |Replaces uppercased characters by lowercased and vice versa.                          |
  # |"TitleizeFilter":./Filters/TitleizeFilter    |:titleize  |Capitalizes the first character of each word.                                         |
  # |"UnderscoreFilter":./Filters/UnderscoreFilter|:underscore|Makes an underscored lowercase form from the expression in the string.                |
  # |"UpcaseFilter":./Filters/UpcaseFilter        |:upcase    |Uppercase all characters.                                                             |
  module Filters
  end
end


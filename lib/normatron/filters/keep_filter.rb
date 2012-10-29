require 'normatron/filters/helpers'

module Normatron
  module Filters
    
    ##
    # Remove the characters that doesn't match the given properties.
    #
    # The character properties follow the rule of @\p{}@ construct described in Regexp class.
    # The @\p{}@ construct matches characters with the named property, much like POSIX bracket classes.
    #
    # To pass named properties to this filter, use them as Symbols:
    #
    # |_<.Property  |_<.Description                                                                                         |
    # | @:Alnum@    | Alphabetic and numeric character                                                                      |
    # | @:Alpha@    | Alphabetic character                                                                                  |
    # | @:Blank@    | Space or tab                                                                                          |
    # | @:Cntrl@    | Control character                                                                                     |
    # | @:Digit@    | Digit                                                                                                 |
    # | @:Graph@    | Non-blank character (excludes spaces, control characters, and similar)                                |
    # | @:Lower@    | Lowercase alphabetical character                                                                      |
    # | @:Print@    | Like :Graph, but includes the space character                                                         |
    # | @:Punct@    | Punctuation character                                                                                 |
    # | @:Space@    | Whitespace character (@[:blank:]@, newline, carriage return, etc.)                                    |
    # | @:Upper@    | Uppercase alphabetical                                                                                |
    # | @:XDigit@   | Digit allowed in a hexadecimal number (i.e., 0-9a-fA-F)                                               |
    # | @:Word@     | A member of one of the following Unicode general category Letter, Mark, Number, Connector_Punctuation |
    # | @:ASCII@    | A character in the ASCII character set                                                                |
    # | @:Any@      | Any Unicode character (including unassigned characters)                                               |
    # | @:Assigned@ | An assigned character                                                                                 |
    # 
    # A Unicode character's General Category value can also be matched with @:Ab@ where @Ab@ is the category's
    # abbreviation as described below:
    #
    # |_<.Property |_<.Description              |
    # | @:L@       | Letter                     |
    # | @:Ll@      | Letter: Lowercase          |
    # | @:Lm@      | Letter: Mark               |
    # | @:Lo@      | Letter: Other              |
    # | @:Lt@      | Letter: Titlecase          |
    # | @:Lu@      | Letter: Uppercas           |
    # | @:Lo@      | Letter: Other              |
    # | @:M@       | Mark                       |
    # | @:Mn@      | Mark: Nonspacing           |
    # | @:Mc@      | Mark: Spacing Combining    |
    # | @:Me@      | Mark: Enclosing            |
    # | @:N@       | Number                     |
    # | @:Nd@      | Number: Decimal Digit      |
    # | @:Nl@      | Number: Letter             |
    # | @:No@      | Number: Other              |
    # | @:P@       | Punctuation                |
    # | @:Pc@      | Punctuation: Connector     |
    # | @:Pd@      | Punctuation: Dash          |
    # | @:Ps@      | Punctuation: Open          |
    # | @:Pe@      | Punctuation: Close         |
    # | @:Pi@      | Punctuation: Initial Quote |
    # | @:Pf@      | Punctuation: Final Quote   |
    # | @:Po@      | Punctuation: Other         |
    # | @:S@       | Symbol                     |
    # | @:Sm@      | Symbol: Math               |
    # | @:Sc@      | Symbol: Currency           |
    # | @:Sc@      | Symbol: Currency           |
    # | @:Sk@      | Symbol: Modifier           |
    # | @:So@      | Symbol: Other              |
    # | @:Z@       | Separator                  |
    # | @:Zs@      | Separator: Space           |
    # | @:Zl@      | Separator: Line            |
    # | @:Zp@      | Separator: Paragraph       |
    # | @:C@       | Other                      |
    # | @:Cc@      | Other: Control             |
    # | @:Cf@      | Other: Format              |
    # | @:Cn@      | Other: Not Assigned        |
    # | @:Co@      | Other: Private Use         |
    # | @:Cs@      | Other: Surrogate           |
    #
    # Lastly, this method matches a character's Unicode script. The following scripts are supported:
    #
    # Arabic, Armenian, Balinese, Bengali, Bopomofo, Braille, Buginese, Buhid, Canadian_Aboriginal, Carian, Cham,
    # Cherokee, Common, Coptic, Cuneiform, Cypriot, Cyrillic, Deseret, Devanagari, Ethiopic, Georgian, Glagolitic,
    # Gothic, Greek, Gujarati, Gurmukhi, Han, Hangul, Hanunoo, Hebrew, Hiragana, Inherited, Kannada, Katakana, Kayah_Li,
    # Kharoshthi, Khmer, Lao, Latin, Lepcha, Limbu, Linear_B, Lycian, Lydian, Malayalam, Mongolian, Myanmar,
    # New_Tai_Lue, Nko, Ogham, Ol_Chiki, Old_Italic, Old_Persian, Oriya, Osmanya, Phags_Pa, Phoenician, Rejang, Runic,
    # Saurashtra, Shavian, Sinhala, Sundanese, Syloti_Nagri, Syriac, Tagalog, Tagbanwa, Tai_Le, Tamil, Telugu, Thaana,
    # Thai, Tibetan, Tifinagh, Ugaritic, Vai, and Yi.
    # 
    # @example Out of box
    #   KeepFilter.evaluate("Doom 3", :L)      #=> "Doom"    keep only letters
    #   KeepFilter.evaluate("Doom 3", :N)      #=> "3"       keep only numbers
    #   KeepFilter.evaluate("Doom 3", :L, :N)  #=> "Doom3"   keep only letters and numbers
    #   KeepFilter.evaluate("Doom 3", :Lu, :N) #=> "D3"      keep only uppercased letters or numbers
    #   KeepFilter.evaluate("Doom ˩", :Latin)  #=> "Doom"    keep only latin characters
    #
    # @example Using as ActiveRecord::Base normalizer
    #   normalize :attribute_a, :with => [[:keep, :Lu]]
    #   normalize :attribute_b, :with => [{:keep =>[:Lu]}]
    #   normalize :attribute_c, :with => [:custom_filter, [:keep, :Ll, :Space]]
    #   normalize :attribute_d, :with => [:custom_filter, {:keep => [:Ll, :Space]}]
    #
    # @see http://www.ruby-doc.org/core-1.9.3/Regexp.html Regexp
    # @see RemoveFilter Normatron::Filters::RemoveFilter
    module KeepFilter
      extend Helpers

      ##
      # Performs input conversion according to filter requirements.
      #
      # This method returns the object itself when the first argument is not a String.
      #
      # @param input      [String]    The String to be filtered
      # @param properties [[Symbol]*] Symbols equivalent to Regexp property for @\\p{}@ construct
      # @return [String] A new clean String
      def self.evaluate(input, *properties)
        input.kind_of?(String) ? evaluate_regexp(input, :keep, properties) : input
      end
    end
  end
end
require 'normatron/filters/helpers'

module Normatron
  module Filters
    module KeepFilter
      extend Helpers

      ##
      # Remove the characters that doesn't match the given properties.
      # The character properties follow the rule of \\p{} construct described in Regexp class.
      # The \\p{} construct matches characters with the named property, much like POSIX bracket classes.
      #
      # To pass named properties to this filter, use them as Symbols:
      # * <tt>:Alnum</tt> - Alphabetic and numeric character
      # * <tt>:Alpha</tt> - Alphabetic character
      # * <tt>:Blank</tt> - Space or tab
      # * <tt>:Cntrl</tt> - Control character
      # * <tt>:Digit</tt> - Digit
      # * <tt>:Graph</tt> - Non-blank character (excludes spaces, control characters, and similar)
      # * <tt>:Lower</tt> - Lowercase alphabetical character
      # * <tt>:Print</tt> - Like :Graph, but includes the space character
      # * <tt>:Punct</tt> - Punctuation character
      # * <tt>:Space</tt> - Whitespace character ([:blank:], newline, carriage return, etc.)
      # * <tt>:Upper</tt> - Uppercase alphabetical
      # * <tt>:XDigit</tt> - Digit allowed in a hexadecimal number (i.e., 0-9a-fA-F)
      # * <tt>:Word</tt> - A member of one of the following Unicode general category Letter, Mark, Number, Connector_Punctuation
      # * <tt>:ASCII</tt> - A character in the ASCII character set
      # * <tt>:Any</tt> - Any Unicode character (including unassigned characters)
      # * <tt>:Assigned</tt> - An assigned character
      # 
      # A Unicode character's General Category value can also be matched with :Ab where Ab is the category’s abbreviation as described below:
      # * <tt>:L</tt> - 'Letter'
      # * <tt>:Ll</tt> - 'Letter: Lowercase'
      # * <tt>:Lm</tt> - 'Letter: Mark'
      # * <tt>:Lo</tt> - 'Letter: Other'
      # * <tt>:Lt</tt> - 'Letter: Titlecase'
      # * <tt>:Lu</tt> - 'Letter: Uppercase
      # * <tt>:Lo</tt> - 'Letter: Other'
      # * <tt>:M</tt> - 'Mark'
      # * <tt>:Mn</tt> - 'Mark: Nonspacing'
      # * <tt>:Mc</tt> - 'Mark: Spacing Combining'
      # * <tt>:Me</tt> - 'Mark: Enclosing'
      # * <tt>:N</tt> - 'Number'
      # * <tt>:Nd</tt> - 'Number: Decimal Digit'
      # * <tt>:Nl</tt> - 'Number: Letter'
      # * <tt>:No</tt> - 'Number: Other'
      # * <tt>:P</tt> - 'Punctuation'
      # * <tt>:Pc</tt> - 'Punctuation: Connector'
      # * <tt>:Pd</tt> - 'Punctuation: Dash'
      # * <tt>:Ps</tt> - 'Punctuation: Open'
      # * <tt>:Pe</tt> - 'Punctuation: Close'
      # * <tt>:Pi</tt> - 'Punctuation: Initial Quote'
      # * <tt>:Pf</tt> - 'Punctuation: Final Quote'
      # * <tt>:Po</tt> - 'Punctuation: Other'
      # * <tt>:S</tt> - 'Symbol'
      # * <tt>:Sm</tt> - 'Symbol: Math'
      # * <tt>:Sc</tt> - 'Symbol: Currency'
      # * <tt>:Sc</tt> - 'Symbol: Currency'
      # * <tt>:Sk</tt> - 'Symbol: Modifier'
      # * <tt>:So</tt> - 'Symbol: Other'
      # * <tt>:Z</tt> - 'Separator'
      # * <tt>:Zs</tt> - 'Separator: Space'
      # * <tt>:Zl</tt> - 'Separator: Line'
      # * <tt>:Zp</tt> - 'Separator: Paragraph'
      # * <tt>:C</tt> - 'Other'
      # * <tt>:Cc</tt> - 'Other: Control'
      # * <tt>:Cf</tt> - 'Other: Format'
      # * <tt>:Cn</tt> - 'Other: Not Assigned'
      # * <tt>:Co</tt> - 'Other: Private Use'
      # * <tt>:Cs</tt> - 'Other: Surrogate'
      #
      # Lastly, this method matches a character's Unicode script. The following scripts are supported:
      #
      # Arabic, Armenian, Balinese, Bengali, Bopomofo, Braille, Buginese, Buhid, Canadian_Aboriginal, Carian, Cham, Cherokee, Common, Coptic, Cuneiform, Cypriot, Cyrillic, Deseret, Devanagari, Ethiopic, Georgian, Glagolitic, Gothic, Greek, Gujarati, Gurmukhi, Han, Hangul, Hanunoo, Hebrew, Hiragana, Inherited, Kannada, Katakana, Kayah_Li, Kharoshthi, Khmer, Lao, Latin, Lepcha, Limbu, Linear_B, Lycian, Lydian, Malayalam, Mongolian, Myanmar, New_Tai_Lue, Nko, Ogham, Ol_Chiki, Old_Italic, Old_Persian, Oriya, Osmanya, Phags_Pa, Phoenician, Rejang, Runic, Saurashtra, Shavian, Sinhala, Sundanese, Syloti_Nagri, Syriac, Tagalog, Tagbanwa, Tai_Le, Tamil, Telugu, Thaana, Thai, Tibetan, Tifinagh, Ugaritic, Vai, and Yi.
      # 
      # @example
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
      # @param [String] input A character sequence
      # @param [[Symbol]*] properties Array of Symbols equivalent to Regexp property for \\p{} construct.
      # @return [String] The clean character sequence or the object itself
      # @see http://www.ruby-doc.org/core-1.9.3/Regexp.html Regexp
      # @see RemoveFilter Normatron::Filters::RemoveFilter
      # @todo Raise exception for empty properties
      def self.evaluate(input, *properties)
        input.kind_of?(String) ? evaluate_regexp(input, :keep, properties) : input
      end
    end
  end
end
# encoding: UTF-8

require 'active_support/multibyte/chars'
require 'active_support/core_ext/string'
require 'active_support/inflector/inflections'

module Normatron
  module Filters
    extend self

    ##
    # Returns a <tt>Nil</tt> object for a blank string or the string itself otherwise.
    # 
    # @example
    #   blank("")            #=> nil
    #   blank("     ")       #=> nil
    #   blank("   \n   ")    #=> nil
    #   blank("1")           #=> "1"
    #   blank("It's blank?") #=> "It's blank?"
    #   blank(123)           #=> 123
    #
    #   # ActiveRecord normalizer usage
    #   normalize :attribute_a, :with => :blank
    #   normalize :attribute_b, :with => [:custom_filter, :blank]
    # @param [String] value A character sequence
    # @return [String, Nil] The object itself or nil
    # @see http://api.rubyonrails.org/classes/String.html#method-i-blank-3F String#blank?
    def blank(value)
      return value unless string?(value) && value.to_s.blank?
      nil
    end

    ##
    # Converts strings to UpperCamelCase.
    # If the argument to camelize is set to <tt>:lower</tt> then camelize produces lowerCamelCase.
    # camelize will also convert <tt>'/'</tt> to <tt>'::'</tt> which is useful for converting paths to namespaces.
    # 
    # @example
    #   camelize("active_record/errors")         #=> "ActiveRecord::Errors"
    #   camelize("active_record/errors", :upper) #=> "ActiveRecord::Errors"
    #   camelize("active_record/errors", :lower) #=> "activeRecord::Errors"
    #   camelize(123)                            #=> 123
    #
    #   # ActiveRecord normalizer usage
    #   normalize :attribute_a, :with => :camelize
    #   normalize :attribute_b, :with => [:custom_filter, :camelize]
    #   normalize :attribute_c, :with => [[:camelize, :lower]]
    #   normalize :attribute_d, :with => [{:camelize => :lower}]
    #   normalize :attribute_e, :with => [:custom_filter, [:camelize, :lower]]
    #   normalize :attribute_f, :with => [:custom_filter, {:camelize => :lower}]
    # @param [String] value A character sequence
    # @param [Symbol] first_letter_case <tt>:lower</tt> for lowerCamelCase or <tt>:upper</tt> for UpperCamelCase
    # @return [String, Object] The camelized String or the object itself
    def camelize(value, first_letter_case = :upper)
      case value
      when String
        string = value
      when ActiveSupport::Multibyte::Chars
        string = value.to_s
      else
        return value
      end

      inflections = ActiveSupport::Inflector::Inflections.instance
      if first_letter_case == :upper
        string = string.sub(/^[\p{L}\d]*/u) { inflections.acronyms[$&] || capitalize($&) }
      elsif first_letter_case == :lower
        string = string.sub(/^(?:#{inflections.acronym_regex}(?=\b|[\p{L}_])|\p{Word}*_)/u) { downcase($&) }
      else
        raise "Use options :upper or :lower for Normatron::Filters#camelize"
      end
      string.gsub!(/(?:_|(\/))([\p{L}\d]*)/iu) { "#{$1}#{inflections.acronyms[$2] || capitalize($2)}" }.gsub!('/', '::')

      (value.is_a?(String) && string) || string.mb_chars
    end

    ##
    # Makes the first character uppercase and lowercase others.
    # 
    # @example
    #   capitalize("jESSE PINK")   #=> "Jesse pink"
    #   capitalize("wALTER WHITE") #=> "Walter white"
    #   capitalize(" mr. Fring")   #=> " mr. fring"
    #   capitalize(123)            #=> 123
    #
    #   # ActiveRecord normalizer usage
    #   normalize :attribute_a, :with => :capitalize
    #   normalize :attribute_b, :with => [:custom_filter, :capitalize]
    # @param [String] value A character sequence
    # @return [String, Object] The capitalized String or the object itself
    # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-capitalize String#capitalize
    # @see http://api.rubyonrails.org/classes/ActiveSupport/Multibyte/Chars.html#method-i-capitalize ActiveSupport::Multibyte::Chars#capitalize
    def capitalize(value)
      (string?(value) && eval_send(:capitalize, value)) || value
    end

    ##
    # Remove the given record separator from the end of the string (If present).
    # If <tt>$/</tt> has not been changed from the default Ruby record separator,
    # then chomp also removes carriage return characters (that is it will remove <tt>\n</tt>, <tt>\r</tt>, and <tt>\r\n</tt>).
    # 
    # @example
    #   chomp("Bon \n Scott\n")            #=> "Bon \n Scott"
    #   chomp("Bon \n Scott\r")            #=> "Bon \n Scott"
    #   chomp("Bon \n Scott\r\n")          #=> "Bon \n Scott"
    #   chomp("Bon \n Scott\n\r")          #=> "Bon \n Scott\n"
    #   chomp("Bon \n Scott", "t")         #=> "Bon \n Scot"
    #   chomp("Bon \n Scott", "Scott")     #=> "Bon \n "
    #   chomp("Bon \n Scott", " \n Scott") #=> "Bon"
    #   chomp(100)                         #=> 100
    #
    #   # ActiveRecord normalizer usage
    #   normalize :attribute_a, :with => :chomp
    #   normalize :attribute_b, :with => [:custom_filter, :chomp]
    #   normalize :attribute_c, :with => [[:chomp, "x"]]
    #   normalize :attribute_d, :with => [{:chomp => "y"}]
    #   normalize :attribute_e, :with => [:custom_filter, [:chomp, "z"]]
    #   normalize :attribute_f, :with => [:custom_filter, {:chomp => "\t"}]
    # @param [String] value A character sequence
    # @param [String] separator A character sequence
    # @return [String, Object] The chopped String or the object itself
    # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-chomp String#chomp
    def chomp(value, separator=$/)
      (string?(value) && eval_send(:chomp, value, separator)) || value
    end

    ##
    # Replaces all underscores with dashes.
    # 
    # @example
    #   dasherize("monty_python") #=> "monty-python"
    #   dasherize("_.·-'*'-·._")  #=> "-.·-'*'-·.-"
    #   dasherize(123)            #=> 123
    #
    #   # ActiveRecord normalizer usage
    #   normalize :attribute_a, :with => :dasherize
    #   normalize :attribute_b, :with => [:custom_filter, :dasherize]
    # @param [String] value A character sequence
    # @return [String, Object] The dasherized String or the object itself
    # @see http://api.rubyonrails.org/classes/String.html#method-i-dasherize String#dasherize
    def dasherize(value)
      (string?(value) && eval_send(:dasherize, value)) || value
    end

    ##
    # Lowercase all characters.
    # 
    # @example
    #   downcase("VEGETA!!!") #=> "vegeta!!!"
    #   downcase(123)         #=> 123
    #
    #   # ActiveRecord normalizer usage
    #   normalize :attribute_a, :with => :downcase
    #   normalize :attribute_b, :with => [:custom_filter, :downcase]
    # @param [String] value A character sequence
    # @return [String, Object] The lowercased String or the object itself
    # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-downcase String#downcase
    # @see http://api.rubyonrails.org/classes/ActiveSupport/Multibyte/Chars.html#method-i-downcase ActiveSupport::Multibyte::Chars#downcase
    def downcase(value)
      (string?(value) && eval_send(:downcase, value)) || value
    end

    ##
    # Creates a literal string representation with all nonprinting characters
    # replaced by <tt>\\n</tt> notation and all special characters escaped.
    # 
    # @example
    #   dump("I'm not\na \"clubber\"...") #=> "\"I'm not\\na \\\"clubber\\\"...\""
    #   dump("I'm not\na \"clubber\"...") #== '"I\'m not\na \"clubber\"..."'
    #   dump('I\'m not\na "clubber"...')  #=> "\"I'm not\\\\na \\\"clubber\\\"...\""
    #   dump('I\'m not\na "clubber"...')  #== '"I\'m not\\\na \"clubber\"..."'
    #   dump(100)                         #=> 100
    #
    #   # ActiveRecord normalizer usage
    #   normalize :attribute_a, :with => :dump
    #   normalize :attribute_b, :with => [:custom_filter, :dump]
    # @param [String] value A character sequence
    # @return [String, Object] The dumpped String or the object itself
    # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-dump String#dump
    def dump(value)
      (string?(value) && eval_send(:dump, value)) || value
    end

    ##
    # Keep only the specified characters.
    # Details about the options can be found in the Regexp class documentation.
    # 
    # @example
    #   keep("Doom 3", :L)      #=> "Doom"    equivalent to /\p{L}/u
    #   keep("Doom 3", :N)      #=> "3"       equivalent to /\p{N}/u
    #   keep("Doom 3", :L, :N)  #=> "Doom3"   equivalent to /\p{L}\p{N}/u
    #   keep("Doom 3", :Lu, :N) #=> "D3"      equivalent to /\p{Lu}\p{N}/u
    #   keep("Doom ˩", :Latin)  #=> "Doom"    equivalent to /\p{Latin}/u
    #
    #   # For normalizations
    #   normalize :attribute_a, :with => [[:keep, :Lu, :N]]
    #   normalize :attribute_b, :with => [:custom_filter, [:keep, :L, :Nd]]
    #   normalize :attribute_c, :with => [:custom_filter, {:keep => [:Latin, :Z]}]
    # @param [String] value A character sequence
    # @param [[Symbol]*] args Array of Symbols equivalent to Regexp for \\p{} construct.
    # @return [String, Object] The clean character sequence or the object itself
    # @see http://www.ruby-doc.org/core-1.9.3/Regexp.html Regexp
    def keep(value, *args)
      eval_regexp(value, true, args)
    end

    ##
    # Remove trailing spaces.
    # 
    # @example
    #   lstrip("   copyleft   ") #=> "copyleft   "
    #
    #   # For normalizations
    #   normalize :attribute, :with => [:custom_filter, :lstrip]
    # @param [String] value A character sequence
    # @return [String, Object] The character sequence without trailing spaces or the object itself
    # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-lstrip String#lstrip
    def lstrip(value)
      (string?(value) && eval_strip(value, true, false)) || value
    end

    ##
    # Remove only the specified characters.
    # Details about the options can be found in the Regexp class documentation.
    # 
    # @example
    #   remove("Quake 3", :L)      #=> "3"            equivalent to /\p{L}/u
    #   remove("Quake 3", :N)      #=> "Quake "       equivalent to /\p{N}/u
    #   remove("Quake 3", :L, :N)  #=> " "            equivalent to /\p{L}\p{N}/u
    #   remove("Quake 3", :Lu, :N) #=> "uake "        equivalent to /\p{Lu}\p{N}/u
    #   remove("Quake ˩", :Latin)  #=> "Quake"        equivalent to /\p{Latin}/u
    #
    #   # For normalizations
    #   normalize :attribute_a, :with => [[:remove, :Lu, :N]]
    #   normalize :attribute_b, :with => [:custom_filter, [:remove, :L, :Nd]]
    #   normalize :attribute_c, :with => [:custom_filter, {:remove => [:Latin, :Z]}]
    # @param [String] value A character sequence
    # @param [[Symbol]*] args Array of Symbols equivalent to Regexp for \\p{} construct.
    # @return [String, Object] The clean character sequence or the object itself
    # @see http://www.ruby-doc.org/core-1.9.3/Regexp.html Regexp
    def remove(value, *args)
      eval_regexp(value, false, args)
    end

    ##
    # Remove leading spaces.
    # 
    # @example
    #   rstrip("   copyright   ") #=> "   copyright"
    #
    #   # For normalizations
    #   normalize :attribute, :with => [:custom_filter, :rstrip]
    # @param [String] value A character sequence
    # @return [String, Object] The character sequence without leading spaces or the object itself
    # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-rstrip String#rstrip
    def rstrip(value)
      (string?(value) && eval_strip(value, false, true)) || value
    end

    ##
    # Remove multiple occurences of the same character.
    # If no option are given, all runs of identical characters are replaced by a single character.
    # 
    # @example
    #   squeeze("yellow moon")                  #=> "yelow mon"
    #   squeeze("  now   is  the", " ")         #=> " now is the"
    #   squeeze("putters shoot balls", "m-z")   #=> "puters shot balls"
    #
    #   # For normalizations
    #   normalize :attribute_a, :with => [:custom_filter, :squeeze]
    #   normalize :attribute_b, :with => [:custom_filter, [:squeeze, "a-f"]]
    #   normalize :attribute_c, :with => [:custom_filter, {:squeeze => ["a-f"]}]
    # @param [String] value A character sequence
    # @param [[String]*] args Chars to be affected
    # @return [String, Object] The clean character sequence or the object itself
    # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-squeeze String#squeeze
    def squeeze(value, *args)
      return value unless string?(value)
      (args.any? && value.squeeze(args.first)) || value.squeeze
    end

    ##
    # Strip and remove multiple spaces.
    # 
    # @example
    #   squish("  the \n simpsons ") #=> "the simpsons"
    #
    #   # For normalizations
    #   normalize :attribute, :with => [:custom_filter, :squish]
    # @param [String] value A character sequence
    # @return [String, Object] The clean character sequence or the object itself
    #
    # @see http://api.rubyonrails.org/classes/String.html#method-i-squish String#squish
    def squish(value)
      (string?(value) && value.squish) || value
    end

    ##
    # Remove traling and leading spaces from the string.
    # 
    # @example
    #   strip("   copy   ") #=> "copy"
    #
    #   # For normalizations
    #   normalize :attribute, :with => [:custom_filter, :strip]
    # @param [String] value A character sequence
    # @return [String, Object] The stripped character sequence or the object itself
    def strip(value)
      (string?(value) && eval_strip(value, true, true)) || value
    end

    ##
    # Replaces uppercased characters by lowercased and vice versa.
    # 
    # @example
    #   swapcase("AiNn Kmo éH BOM ser v1d4 l0k4") #=> "aInN kMO Éh bom SER V1D4 L0K4"
    #   swapcase(100)                             #=> 100
    #
    #   # ActiveRecord normalizer usage
    #   normalize :attribute_a, :with => :swapcase
    #   normalize :attribute_b, :with => [:custom_filter, :swapcase]
    # @param [String] value A character sequence
    # @return [String, Object] The String with case swapped or the object itself
    def swapcase(value)
      return value unless string?(value)
      value.gsub(/./) { |c| (/\p{Lu}/.match(c) && downcase(c) || (/\p{Ll}/.match(c) && upcase(c))) || c }
    end

    ##
    # Converts all characters to uppercase.
    # 
    # @example
    #   downcase("kakarotto!!!") #=> "KAKAROTTO!!!"
    #   downcase(123)            #=> 123
    #
    #   # For normalizations
    #   normalize :attribute, :with => [:custom_filter, :upcase]
    # @param [String] value A character sequence
    # @return [String, Object] The lowercased String or the object itself
    # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-upcase String#upcase
    # @see http://api.rubyonrails.org/classes/ActiveSupport/Multibyte/Chars.html#method-i-upcase ActiveSupport::Multibyte::Chars#upcase
    def upcase(value)
      (string?(value) && eval_send(:upcase, value)) || value
    end

    protected

    def eval_regexp(value, keep, *args)
      return value unless string?(value)
      
      options = args.flatten.compact.uniq

      regex = options.map{ |s| "\\p{#{s.to_s}}" } * ""
      regex.prepend('^') if keep
      regex = eval "/[#{regex}]/u"

      value.gsub(regex, "")
    end

    def eval_send(method, value, option=nil)
      type = value.class
      value = value.mb_chars if type == String
      if option
        value = value.send(method, option)
      else
        value = value.send(method)
      end
      (type == String && value.to_s) || value
    end

    def eval_strip(value, start, ending)
      regex = []
      regex << '\A\p{Zs}*' if start
      regex << '\p{Zs}*\z' if ending
      regex = eval "/#{regex * '|'}/u"

      value.gsub(regex, '')
    end

    def string?(value)
      value.is_a?(ActiveSupport::Multibyte::Chars) || value.is_a?(String)
    end
  end
end
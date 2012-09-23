# encoding: UTF-8

require 'active_support/multibyte/chars'
require 'active_support/core_ext/string'

module Normatron
  module Filters
    ##
    # Converts a blank string on a nil object.
    # 
    # @example
    #   blank("")            #=> nil
    #   blank("     ")       #=> nil
    #   blank("   \n   ")    #=> nil
    #   blank("1")           #=> "1"
    #   blank("It's blank?") #=> "It's blank?"
    #   blank(123)           #=> 123
    #
    #   # For normalizations
    #   normalize :attribute, :with => [:custom_filter, :blank]
    # @param [String] value A character sequence
    # @return [String, Nil] The object itself or nil
    # @see http://api.rubyonrails.org/classes/String.html#method-i-blank-3F String#blank?
    def self.blank(value)
      return value unless string?(value) && value.to_s.blank?
      nil
    end

    ##
    # Converts the first character to uppercase and others to lowercase.
    # 
    # @example
    #   capitalize("walter white") #=> "Walter white"
    #   capitalize("wALTER WHITE") #=> "Walter white"
    #   capitalize(123)            #=> 123
    #
    #   # For normalizations
    #   normalize :attribute, :with => [:custom_filter, :capitalize]
    # @param [String] value A character sequence
    # @return [String, Object] The capitalized String or the object itself
    # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-capitalize String#capitalize
    # @see http://api.rubyonrails.org/classes/ActiveSupport/Multibyte/Chars.html#method-i-capitalize ActiveSupport::Multibyte::Chars#capitalize
    def self.capitalize(value)
      (string?(value) && eval_send(:capitalize, value)) || value
    end

    ##
    # Replaces all underscores with dashes.
    # 
    # @example
    #   dasherize("monty_python") #=> "monty-python"
    #   dasherize("_.·-'*'-·._")  #=> "-.·-'*'-·.-"
    #   dasherize(123)            #=> 123
    #
    #   # For normalizations
    #   normalize :attribute, :with => [:custom_filter, :dasherize]
    # @param [String] value A character sequence
    # @return [String, Object] The dasherized String or the object itself
    # @see http://api.rubyonrails.org/classes/String.html#method-i-dasherize String#dasherize
    def self.dasherize(value)
      (string?(value) && eval_send(:dasherize, value)) || value
    end

    ##
    # Converts all characters to lowercase.
    # 
    # @example
    #   downcase("VEGETA!!!") #=> "vegeta!!!"
    #   downcase(123)         #=> 123
    #
    #   # For normalizations
    #   normalize :attribute, :with => [:custom_filter, :downcase]
    # @param [String] value A character sequence
    # @return [String, Object] The lowercased String or the object itself
    # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-downcase String#downcase
    # @see http://api.rubyonrails.org/classes/ActiveSupport/Multibyte/Chars.html#method-i-downcase ActiveSupport::Multibyte::Chars#downcase
    def self.downcase(value)
      (string?(value) && eval_send(:downcase, value)) || value
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
    def self.keep(value, *args)
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
    def self.lstrip(value)
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
    def self.remove(value, *args)
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
    def self.rstrip(value)
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
    def self.squeeze(value, *args)
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
    def self.squish(value)
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
    def self.strip(value)
      (string?(value) && eval_strip(value, true, true)) || value
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
    def self.upcase(value)
      (string?(value) && eval_send(:upcase, value)) || value
    end

    protected

    def self.eval_regexp(value, keep, *args)
      return value unless string?(value)
      
      options = args.flatten.compact.uniq

      regex = options.map{|s| "\\p{#{s.to_s}}"} * ""
      regex.prepend('^') if keep
      regex = eval "/[#{regex}]/u"

      value.gsub(regex, "")
    end

    def self.eval_send(method, value)
      type = value.class
      value = value.mb_chars if type == String
      value = value.send(method)
      (type == String && value.to_s) || value
    end

    def self.eval_strip(value, start, ending)
      regex = []
      regex << '\A\p{Zs}*' if start
      regex << '\p{Zs}*\z' if ending
      regex = eval "/#{regex * '|'}/u"

      value.gsub(regex, '')
    end

    def self.string?(value)
      value.is_a?(ActiveSupport::Multibyte::Chars) || value.is_a?(String)
    end
  end
end
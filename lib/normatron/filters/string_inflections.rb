module Normatron
  module Filters
    ##
    # Contains methods that perform modifications on Strings.
    # In general, modifications are only for removal and/or character replacement.
    # All methods take String or ActiveSupport::Multibyte::Chars variables as main argument.
    # Where character case need to be changed, all accented characters will also be affected.
    # There is no type coersion, ie all filters return the same object type passed by the argument.
    #
    # @author Fernando Rodrigues da Silva
    module StringInflections
      class << self

        ##
        # Remove all non letter characters.
        # 
        # @example
        #   StringInflections.alphas("Doom 3")  #=> "Doom"
        #   StringInflections.alphas("\n")      #=> ""
        #   StringInflections.alphas("1")       #=> ""
        #   StringInflections.alphas(0)         #=> 0
        # @param [String] value Any character sequence
        # @return [String, nil] The object itself or a alpha characters sequence
        # 
        # @see http://www.ruby-doc.org/core-1.9.3/Regexp.html Regexp
        # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-gsub String#gsub
        def alphas(value)
          if Filters.is_a_string?(value)
            value.gsub(/[^\p{L}]/u, '')
          else
            value
          end
        end

        ##
        # The first character will be uppercased, all others will be lowercased.
        # 
        # @example
        #   StringInflections.capitalize("mASTER OF PUPPETS")  #=> "Master of puppets"
        #   StringInflections.capitalize(" mASTER OF PUPPETS") #=> " master of puppets"
        #   StringInflections.capitalize(1)                    #=> 1
        # @param [String] value Any character sequence
        # @return [String] The object itself or a capitalized string
        # 
        # @see http://api.rubyonrails.org/classes/ActiveSupport/Multibyte/Chars.html#method-i-capitalize ActiveSupport::Multibyte::Chars#capitalize
        def capitalize(value)
          evaluate(:capitalize, value)
        end

        ##
        # Replace all underscores with dashes.
        # 
        # @example
        #   StringInflections.dasherize("__ shoot _ to _ thrill __") #=> "-- shoot - to - thrill --"
        #   StringInflections.dasherize(1)                           #=> 1
        # @param [String] value Any character sequence
        # @return [String] The object itself or a capitalized string
        # 
        # @see http://api.rubyonrails.org/classes/String.html#method-i-dasherize ActiveSupport::CoreExt::Object#dasherize
        def dasherize(value)
          evaluate(:dasherize, value)
        end

        ##
        # Remove all non digit characters.
        # 
        # @example
        #   StringInflections.digits("Quake 3") #=> "3"
        #   StringInflections.digits("\n")      #=> ""
        #   StringInflections.digits("1")       #=> "1"
        #   StringInflections.digits(0)         #=> 0
        # @param [String] value Any character sequence
        # @return [String, nil] The object itself or a digit characters sequence
        # 
        # @see http://www.ruby-doc.org/core-1.9.3/Regexp.html Regexp
        # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-gsub String#gsub
        def digits(value)
          if Filters.is_a_string?(value)
            value.gsub(/\D/, '')
          else
            value
          end
        end

        ##
        # Lowercase all characters on the sequence.
        # 
        # @example
        #   StringInflections.downcase("KILL'EM ALL") #=> "kill'em all"
        #   StringInflections.downcase("ÊXITO")       #=> "êxito"
        #   StringInflections.downcase("1")           #=> "1"
        #   StringInflections.downcase(0)             #=> 0
        # @param [String] value Any character sequence
        # @return [String, nil] The object itself or a downcased string
        # 
        # @see http://api.rubyonrails.org/classes/ActiveSupport/Multibyte/Chars.html#method-i-downcase ActiveSupport::Multibyte::Chars#downcase
        # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-downcase String#downcase
        def downcase(value)
          evaluate(:downcase, value)
        end

        def lstrip(value)
          evaluate(:lstrip, value)
        end

        def rstrip(value)
          evaluate(:rstrip, value)
        end

        def squeeze(value)
          evaluate(:squeeze, value)
        end

        def squish(value)
          evaluate(:squish, value)
        end

        def strip(value)
          evaluate(:strip, value)
        end

        def title(value)
          evaluate(:titlecase, value)
        end

        def upcase(value)
          evaluate(:upcase, value)
        end

        private

        def evaluate(method_name, value)
          if need_type_cast?(method_name, value)
            value.mb_chars.send(method_name)
          elsif Filters.is_a_string?(value)
            value.send(method_name)
          else
            value
          end
        end

        def need_type_cast?(method_name, value)
          if value.is_a?(String)
            case method_name
            when :capitalize, :downcase, :titlecase, :upcase
              true
            end
          else
            false
          end
        end
      end
    end
  end
end
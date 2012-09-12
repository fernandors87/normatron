require "active_support/core_ext/string"

module Normatron
  module Filters
    module StringInflections
      class << self

        ##
        # Convert a blank string into a nil object.
        # 
        # @example
        #   StringInflections.blank("")   #=> nil
        #   StringInflections.blank("  ") #=> nil
        #   StringInflections.blank("\n") #=> nil
        #   StringInflections.blank("1")  #=> "1"
        #   StringInflections.blank(0)    #=> 0
        # @param [String] value Any character sequence
        # @return [String, nil] The object itself or nil
        # 
        # @see http://api.rubyonrails.org/classes/String.html#method-i-blank-3F ActiveSupport::CoreExt::Object#blank?
        def blank(value)
          if is_a_string?(value)
            value.to_s.blank? ? nil : value
          else
            value
          end
        end

        ##
        # Downcase all characters in the sequence, except the first.
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
          elsif is_a_string?(value)
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

        def is_a_string?(value)
          value.is_a?(ActiveSupport::Multibyte::Chars) || value.is_a?(String)
        end
      end
    end
  end
end
module Normatron
  module Filters
    module ChompFilter

      ##
      # Remove the given record separator from the end of the string (If present).
      # If <tt>$/</tt> has not been changed from the default Ruby record separator,
      # then chomp also removes carriage return characters (that is it will remove <tt>\n</tt>, <tt>\r</tt>, and <tt>\r\n</tt>).
      # 
      # @example
      #   ChompFilter.evaluate("Bon Scott\n")            #=> "Bon Scott"
      #   ChompFilter.evaluate("Bon Scott\r")            #=> "Bon Scott"
      #   ChompFilter.evaluate("Bon Scott\r\n")          #=> "Bon Scott"
      #   ChompFilter.evaluate("Bon Scott\n\r")          #=> "Bon Scott\n"
      #   ChompFilter.evaluate("Bon Scott", " Scott")    #=> "Bon"
      #
      # @example Using as ActiveRecord::Base normalizer
      #   normalize :attribute_a, :with => :chomp
      #   normalize :attribute_b, :with => [:custom_filter, :chomp]
      #   normalize :attribute_c, :with => [[:chomp, "x"]]
      #   normalize :attribute_d, :with => [{:chomp => "y"}]
      #   normalize :attribute_e, :with => [:custom_filter, [:chomp, "z"]]
      #   normalize :attribute_f, :with => [:custom_filter, {:chomp => "\f"}]
      #
      # @param [String] input A character sequence
      # @param [String] separator A character sequence
      # @return [String] The chopped character sequence or the object itself
      # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-chomp String#chomp
      def self.evaluate(input, separator=$/)
        input.kind_of?(String) ? input.chomp(separator) : input
      end
    end
  end
end
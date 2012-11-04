module Normatron
  module Filters
    
    ##
    # Remove the given record separator from the end of the string (If present).
    # If @$/@ has not been changed from the default Ruby record separator, then chomp also removes carriage return
    # characters (that is it will remove @\n@, @\r@, and @\r\n@).
    # 
    # @example Out of box
    #   ChompFilter.call("Bon Scott\n")         #=> "Bon Scott"
    #   ChompFilter.call("Bon Scott\r")         #=> "Bon Scott"
    #   ChompFilter.call("Bon Scott\r\n")       #=> "Bon Scott"
    #   ChompFilter.call("Bon Scott\n\r")       #=> "Bon Scott\n"
    #   ChompFilter.call("Bon Scott", " Scott") #=> "Bon"
    #
    # @example Using as model normalizer
    #   normalize :attribute_a, :with => :chomp
    #   normalize :attribute_b, :with => [:custom_filter, :chomp]
    #   normalize :attribute_c, :with => [[:chomp, "x"]]
    #   normalize :attribute_d, :with => [{:chomp => "y"}]
    #   normalize :attribute_e, :with => [:custom_filter, [:chomp, "z"]]
    #   normalize :attribute_f, :with => [:custom_filter, {:chomp => "\f"}]
    #
    # @see http://www.ruby-doc.org/core-1.9.3/String.html#method-i-chomp String#chomp
    module ChompFilter

      ##
      # Performs input conversion according to filter requirements.
      #
      # This method returns the object itself when the first argument is not a String.
      #
      # @param  input     [String] The String to be filtered
      # @param  separator [String] The separator used to chomp input
      # @return [String] A new chopped String
      def self.call(input, separator=$/)
        input.kind_of?(String) ? input.chomp(separator) : input
      end
    end
  end
end
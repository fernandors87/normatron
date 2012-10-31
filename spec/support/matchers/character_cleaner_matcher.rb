module FilterMatchers
  def keep(*properties)
    CharacterCleanerMatcher.new(*properties, :keep)
  end

  def remove(*properties)
    CharacterCleanerMatcher.new(*properties, :remove)
  end

  class CharacterCleanerMatcher
    def initialize(*properties, action)
      @options = {}
      @options[:properties] = properties
      @options[:action] = action
      self
    end

    def from(word)
      @options[:input] = word
      self
    end

    def matches?(subject)
      @subject = subject
      @expected = @options[:input].gsub(regexp, '')
      @got = @subject.evaluate(@options[:input], @options[:properties])
      @failure_reason = failure_reason
      @failure_reason.nil?
    end

    def description
      case @failure_reason
      when :identity
        "not be equal #{@expected.inspect}"
      when :type
        "be a kind of #{@options[:input].class}"
      else
        "#{@options[:action]} #{@options[:properties].inspect} from input value"
      end
    end

    def failure_message
      case @failure_reason
      when :value
        ["input:    #{@options[:input].inspect}",
         "expected: #{@expected.inspect}",
         "got:      #{@got.inspect}"] * "\n"
      when :identity
        "expected #{@options[:filter].name} evaluate and returns a different object_id from input object."
      when :type
        "expected #{@options[:filter].name} evaluate and returns the same object type of his input."
      end
    end

    private

    def failure_reason
      if @got != @expected
        :value
      elsif !@got.kind_of?(@options[:input].class)
        :type
      elsif @got.equal?(@options[:input]) && @got.kind_of?(String)
        :identity
      end
    end

    def regexp
      construct = @options[:properties].map { |p| "\\p{#{p}}" } * ""
      construct = "[#{'^' if @options[:action] == :keep}#{construct}]"
      Regexp.new(construct.force_encoding "UTF-8")
    end
  end
end
module FilterMatcher
  def evaluate(input)
    Evaluate.new(input)
  end

  class Evaluate
    def initialize(input)
      @input = input
      self
    end

    def to(output)
      @expected = output
      self
    end

    def with(*args)
      @args = args
      self
    end

    def matches?(filter_module)
      @filter_module = filter_module

      input_class = @input.class
      if @args.nil?
        @got = @filter_module.evaluate(@input)
      elsif @args.size == 1
        @got = @filter_module.evaluate(@input, @args.first)
      else
        @got = @filter_module.evaluate(@input, @args)
      end

      @cause =
      if @got != @expected
        :value
      elsif !@got.kind_of?(input_class)
        :type
      elsif @got.equal?(@input) && !@got.kind_of?(Fixnum)
        :identity
      end

      @cause.nil?
    end

    def description
      case @cause
      when :value
        "eq #{@expected.inspect}"
      when :identity
        "not equal #{@expected.inspect}"
      when :type
        "be a kind of #{@input.class}"
      else
        "be evaluated as #{@expected.inspect}"
      end
    end

    def failure_message
      case @cause
      when :value
        ["expected: #{@expected.inspect}",
         "got:      #{@got.inspect}"] * "\n"
      when :identity
        "expected #{@target} evaluate and returns a different object_id from input object."
      when :type
        "expected #{@target} evaluate and returns the same object type of his input."
      end
    end
  end
end
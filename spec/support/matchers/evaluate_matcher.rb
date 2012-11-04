module FilterMatchers
  def evaluate(input)
    EvaluateMatcher.new(input)
  end

  class EvaluateMatcher
    def initialize(input)
      @input = input
      @constraints = Hash[:value, true, :type, true, :identity, true]
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

    def constraints(constraint)
      @constraints.merge! constraint
      self
    end

    def matches?(filter_module)
      @filter = filter_module
      @got    = get_evaluation
      @reason = get_failure_reason
      @reason.nil?
    end

    def description
      case @reason
      when :value
        "eq #{@expected.inspect}"
      when :identity
        "not equal #{@expected.inspect}"
      when :type
        "be a kind of #{@input.class}"
      else
        "evaluate #{@input.inspect} to #{@expected.inspect}"
      end
    end

    def failure_message
      case @reason
      when :value
        ["input:    #{@input.inspect}",
         "expected: #{@expected.inspect}",
         "got:      #{@got.inspect}"] * "\n"
      when :identity
        "expected #{@filter.name} evaluate and returns a different object_id from input object."
      when :type
        "expected #{@filter.name} evaluate and returns the same object type of his input."
      end
    end

    private

    def get_evaluation
      if @args.nil?
        @filter.call(@input)
      else
        @filter.call(@input, *@args)
      end
    end

    def get_failure_reason
      if @constraints[:value] && (@got != @expected) 
        :value
      elsif @constraints[:type] && !@got.kind_of?(@input.class)
        :type
      elsif @constraints[:identity] && @got.equal?(@input) && @got.kind_of?(String)
        :identity
      end
    end
  end
end
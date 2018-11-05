class Number
    def initialize(value)
        @value = value
    end
    
    def execute
        @value
    end
end

class Add
    def initialize(left, right)
        @left, @right = left, right
    end
    
    def execute
        @left.execute + @right.execute
    end
end

class Multiply
    def initialize(left, right)
        @left, @right = left, right
    end
    
    def execute
        @left.execute * @right.execute
    end
end

class Subtract
    def initialize(left, right)
        @left, @right = left, right
    end
    
    def execute
        @left.execute - @right.execute
    end
end

class Divide
    def initialize(left, right)
        @left, @right = left, right
    end
    
    def execute
        @left.execute / @right.execute
    end
end

class Parser
    def initialize(tokens)
        @tokens = tokens.split(" ")
    end

    def next_token
        @tokens.shift
    end

    def expression
        token = next_token
        if token.nil?
            nil
        elsif token == '+'
            Add.new expression, expression
        elsif token == '-'
            Subtract.new expression, expression
        elsif token == '*'
            Multiply.new expression, expression
        elsif token == '/'
            Divide.new expression, expression
        elsif token.to_f.to_s == token.to_s || token.to_i.to_s == token.to_s
            Number.new token.to_i
        else
            raise "Unexpected token: #{token}"
        end
    end
end


END {
    # A simple Forth (Polish notation) calculator
    if __FILE__ == "interpreter_example.rb"
        p Parser.new("+ - 12 2 / 54 2").expression.execute
    end
}

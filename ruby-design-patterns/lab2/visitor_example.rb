"""
  Check: https://medium.com/kkempin/visitor-design-pattern-in-ruby-bc07395c4abc
"""

require_relative 'interpreter_example'

module Visitable
    def accept(visitor)
        visitor.visit(self)
    end
end

class Visitor
    def visit(subject)
        raise NotImplementedError.new
    end
end

class PlaySomeGames < Visitor
    def visit(computer)
        "Playing GTA V on a computer with #{computer.cpu}, #{computer.gpu} and damned #{computer.ram}"
    end
end

class EditSomePhotos < Visitor
    def visit(computer)
        "Editig photos in Photoshop CC 6 on a computer with #{computer.cpu}, an #{computer.storage} and just #{computer.ram}"
    end
end

class ExplodeComputer < Visitor
    def visit(computer)
        "Fuckin ruined a computer with #{computer.cpu}, #{computer.gpu}, #{computer.storage} and #{computer.ram}. Shame on you!"
    end
end

class EvaluateForthExpression < Visitor

    def initialize(expr)
        @expr = expr
    end

    def visit(computer)
        "My computer with #{computer.cpu} does a pretty good job computing (#{@expr}), which results in #{Parser.new(@expr).expression.execute}"
    end
end

END {
    if __FILE__ == "visitor_example.rb"
        class Computer
            include Visitable
        
            attr_reader :cpu, :gpu, :storage, :ram
        
            def initialize
                @cpu = "Intel CPU"
                @gpu = "Nvidia GPU"
                @storage = "Samsung SSD"
                @ram = "32 DDR4"
            end
        end
        
        computer = Computer.new
        p computer.accept EditSomePhotos.new
        p computer.accept PlaySomeGames.new
        p computer.accept ExplodeComputer.new
        p computer.accept EvaluateForthExpression.new("+ - 12 2 / 54 2")
    end
}

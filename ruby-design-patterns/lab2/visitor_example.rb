"""
  Check: https://medium.com/kkempin/visitor-design-pattern-in-ruby-bc07395c4abc
"""

module Visitable
  def accept(visitor)
    visitor.visit(self)
    # raise NotImplementedError.new
  end
end

class Visitor
  def visit(subject)
    raise NotImplementedError.new
  end
end

# TODO implement Concrete products and Visitors
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

END {
  computer = Computer.new
  p computer.accept EditSomePhotos.new
  p computer.accept PlaySomeGames.new
  p computer.accept ExplodeComputer.new
}

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


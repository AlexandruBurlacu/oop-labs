"""
  Check: https://medium.com/kkempin/bridge-design-pattern-in-ruby-5e0273f5a48e
  Check: https://medium.com/@dljerome/design-patterns-in-ruby-bridge-7aebb1b7bbc6
"""


class ComputingDevice
  # This is the Abstract Abstraction :D and a Facade too
  def initialize(implementation)
    @implementation = implementation
  end

  def run
    raise NotImplementedError.new
  end
end

# Concrete Abstractions / Facades

class Mobile < ComputingDevice
end

class HomePCDevice < ComputingDevice
end

class AFuckinWorkstation < ComputingDevice
end

# Concrete Implementors

class Components
end

class EnergyEfficientComponents < Components
end

class LowBudgetComponents < Components
end

class HighEndComponents < Components
end

END {
  computing_device = Mobile.new(EnergyEfficientComponents.new)
  computing_device.run
}